import axios from "axios";

const API_URL =
  import.meta.env.VITE_API_URL || "http://localhost:8080";

const api = axios.create({
  baseURL: API_URL,
  timeout: 10000,
});

export const getClientes = async () => {
  const response = await api.get("/api/clientes");
  return response.data;
};

export default api;