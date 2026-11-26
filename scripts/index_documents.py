"""
Crea (o actualiza) el indice de Azure AI Search y sube los fragmentos de
data/search-docs/chunks.json con sus embeddings reales.

Esquema del indice (coincide con lo que espera app/services/rag.py del
backend):
    chunk_id      (clave)
    parent_id
    title
    chunk         (texto)
    text_vector   (vector, 1536 dimensiones - text-embedding-ada-002)
"""
import json
import os
import re
import sys
import time

import requests
from openai import AzureOpenAI, RateLimitError

AZURE_OAI_ENDPOINT = os.environ["AZURE_OAI_ENDPOINT"]
AZURE_OAI_KEY = os.environ["AZURE_OAI_KEY"]
AZURE_OAI_EMBEDDING_DEPLOYMENT = os.environ["AZURE_OAI_EMBEDDING_DEPLOYMENT"]

AZURE_SEARCH_ENDPOINT = os.environ["AZURE_SEARCH_ENDPOINT"].rstrip("/")
AZURE_SEARCH_KEY = os.environ["AZURE_SEARCH_KEY"]
AZURE_SEARCH_INDEX = os.environ["AZURE_SEARCH_INDEX"]

CHUNKS_FILE = os.environ.get("CHUNKS_FILE", "data/search-docs/chunks.json")
VECTOR_DIMENSIONS = 1536
API_VERSION = "2023-11-01"

client = AzureOpenAI(
    azure_endpoint=AZURE_OAI_ENDPOINT,
    api_key=AZURE_OAI_KEY,
    api_version="2024-05-01-preview",
)


def ensure_index():
    url = f"{AZURE_SEARCH_ENDPOINT}/indexes/{AZURE_SEARCH_INDEX}?api-version={API_VERSION}"
    headers = {"Content-Type": "application/json", "api-key": AZURE_SEARCH_KEY}
    body = {
        "name": AZURE_SEARCH_INDEX,
        "fields": [
            {"name": "chunk_id", "type": "Edm.String", "key": True, "filterable": True},
            {"name": "parent_id", "type": "Edm.String", "filterable": True},
            {"name": "title", "type": "Edm.String", "searchable": True, "filterable": True},
            {"name": "chunk", "type": "Edm.String", "searchable": True},
            {
                "name": "text_vector",
                "type": "Collection(Edm.Single)",
                "searchable": True,
                "dimensions": VECTOR_DIMENSIONS,
                "vectorSearchProfile": "default-vector-profile",
            },
        ],
        "vectorSearch": {
            "algorithms": [
                {
                    "name": "default-hnsw",
                    "kind": "hnsw",
                    "hnswParameters": {"m": 4, "efConstruction": 400, "efSearch": 500, "metric": "cosine"},
                }
            ],
            "profiles": [
                {"name": "default-vector-profile", "algorithm": "default-hnsw"}
            ],
        },
    }
    resp = requests.put(url, headers=headers, json=body, timeout=30)
    if resp.status_code not in (200, 201):
        print(resp.text)
        resp.raise_for_status()
    print(f"Indice '{AZURE_SEARCH_INDEX}' listo (status {resp.status_code}).")


def get_embedding(text: str, max_retries: int = 8):
    for attempt in range(1, max_retries + 1):
        try:
            response = client.embeddings.create(model=AZURE_OAI_EMBEDDING_DEPLOYMENT, input=text)
            time.sleep(1)  # pequeña pausa para no pegarle tan seguido al limite
            return response.data[0].embedding
        except RateLimitError as e:
            wait = 65
            match = re.search(r"retry after (\d+) seconds", str(e), re.IGNORECASE)
            if match:
                wait = int(match.group(1)) + 5
            print(f"  Rate limit alcanzado (intento {attempt}/{max_retries}), esperando {wait}s...")
            time.sleep(wait)
    raise RuntimeError("Se agotaron los reintentos por rate limit (429) de Azure OpenAI.")


def upload_documents(docs):
    url = f"{AZURE_SEARCH_ENDPOINT}/indexes/{AZURE_SEARCH_INDEX}/docs/index?api-version={API_VERSION}"
    headers = {"Content-Type": "application/json", "api-key": AZURE_SEARCH_KEY}
    actions = [{"@search.action": "mergeOrUpload", **d} for d in docs]
    resp = requests.post(url, headers=headers, json={"value": actions}, timeout=60)
    resp.raise_for_status()
    results = resp.json().get("value", [])
    failed = [r for r in results if not r.get("status")]
    if failed:
        print("ERRORES al subir documentos:")
        for f in failed:
            print(f)
        sys.exit(1)
    print(f"Subidos {len(results)} documentos correctamente.")


def main():
    with open(CHUNKS_FILE, encoding="utf-8") as f:
        chunks = json.load(f)

    print(f"{len(chunks)} fragmentos a indexar desde {CHUNKS_FILE}")

    ensure_index()

    batch = []
    for i, c in enumerate(chunks, start=1):
        vector = get_embedding(c["chunk"])
        batch.append({
            "chunk_id": c["chunk_id"],
            "parent_id": c["parent_id"],
            "title": c["title"],
            "chunk": c["chunk"],
            "text_vector": vector,
        })
        if len(batch) >= 10:
            upload_documents(batch)
            batch = []
        if i % 10 == 0:
            print(f"  {i}/{len(chunks)} fragmentos procesados...")

    if batch:
        upload_documents(batch)

    print("Indexacion completa.")


if __name__ == "__main__":
    main()
