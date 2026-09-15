import api from "./api";

export const getClientes = async () => {
  const response = await api.get("/api/clientes");
  return response.data;
};