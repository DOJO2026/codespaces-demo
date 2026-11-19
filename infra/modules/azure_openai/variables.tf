variable "NAME" {
  type        = string
  description = "Azure OpenAI account name - must be globally unique"
}

variable "RESOURCE_GROUP_NAME" {
  type = string
}

variable "LOCATION" {
  type = string
}

variable "SKU_NAME" {
  type    = string
  default = "S0"
}

variable "DEPLOYMENT_NAME" {
  type    = string
  default = "chat-deployment"
}

variable "MODEL_NAME" {
  type    = string
  default = "gpt-4o-mini"
}

variable "MODEL_VERSION" {
  type    = string
  default = "2024-07-18"
}

variable "MODEL_CAPACITY" {
  type    = number
  default = 1
}

# Deployment separado para embeddings - lo necesita Backend_Python_API para
# generar los vectores que indexa en Azure AI Search (RAG).
variable "EMBEDDING_DEPLOYMENT_NAME" {
  type    = string
  default = "embedding-deployment"
}

variable "EMBEDDING_MODEL_NAME" {
  type    = string
  default = "text-embedding-ada-002"
}

variable "EMBEDDING_MODEL_VERSION" {
  type    = string
  default = "2"
}

variable "EMBEDDING_MODEL_CAPACITY" {
  type    = number
  default = 1
}

variable "TAGS" {
  type    = map(string)
  default = {}
}
