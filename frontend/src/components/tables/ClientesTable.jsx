import { FaUsers } from "react-icons/fa";

function ClientesTable({ clientes }) {
  if (!clientes || clientes.length === 0) {
    return (
      <div className="empty-state">
        <FaUsers />

        <h3>No hay clientes para mostrar</h3>

        <p>
          Presiona el botón "Consultar clientes" para cargar la información.
        </p>
      </div>
    );
  }

  return (
    <div className="table-container">
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Correo</th>
            <th>Estado</th>
          </tr>
        </thead>

        <tbody>
          {clientes.map((cliente) => (
            <tr key={cliente.id}>
              <td>{cliente.id}</td>
              <td>{cliente.nombre}</td>
              <td>{cliente.correo}</td>

              <td>
                <span className="active-status">
                  {cliente.estado || "ACTIVO"}
                </span>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default ClientesTable;