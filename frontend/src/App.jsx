import { useState } from "react";
import axios from "axios";

import "./App.css";

import Header from "./components/Header";
import Dashboard from "./components/Dashboard";

const API_URL = import.meta.env.VITE_API_URL;

function App() {

  const [clientes, setClientes] = useState([]);
  const [loading, setLoading] = useState(false);

  const consultarClientes = async () => {

    setLoading(true);

    try {

  const response = await axios.get(
    `${API_URL}/api/clientes`
  );

      setClientes(response.data);

    } catch (error) {

      console.error(error);

      alert("No se pudo conectar con el Backend.");

    } finally {

      setLoading(false);

    }

  };

  return (

    <div className="container">

      {/* ========================= HEADER ========================= */}

      <Header />

      {/* ========================= DASHBOARD ========================= */}

      <Dashboard />

      {/* ========================= LOGS ========================= */}

      <div className="logs">

        <h3>Estado del Sistema</h3>

        <p>🟢 Frontend ................. ONLINE</p>

        <p>🟢 Backend ................. ONLINE</p>

        <p>🟢 Azure SQL ............... CONNECTED</p>

        <p>🟢 Spring Boot ............. RUNNING</p>

        <p>🟢 GitHub Actions .......... READY</p>

        <p>🟢 Terraform ............... APPLIED</p>

        <p>🟡 Key Vault ............... PENDING</p>

        <p>🟡 OpenTelemetry ........... PENDING</p>

        <p>🟡 Application Insights .... PENDING</p>

        <p>🟡 Log Analytics ........... PENDING</p>

        <br />

        <p><strong>Environment:</strong> DEV</p>

        <p><strong>Azure Region:</strong> East US 2</p>

      </div>

      {/* ========================= BOTON ========================= */}

      <div className="actions">

        <button onClick={consultarClientes}>

          {loading
            ? "Consultando Azure SQL..."
            : "Consultar Azure SQL"}

        </button>

      </div>

      {/* ========================= TABLA ========================= */}

      {clientes.length > 0 && (

        <div className="card">

          <h3>Clientes Registrados</h3>

          <p
            style={{
              marginBottom: "25px",
              color: "#8fd3ff",
              fontSize: "18px"
            }}
          >

            Total de registros encontrados:
            <strong> {clientes.length}</strong>

          </p>

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

                    <span className="online">

                      ● ACTIVO

                    </span>

                  </td>

                </tr>

              ))}

            </tbody>

          </table>

        </div>

      )}

      {/* ========================= ARQUITECTURA ========================= */}

      <div className="card">

        <h3>Arquitectura DevSecOps</h3>

        <div
          style={{
            display: "flex",
            justifyContent: "space-around",
            alignItems: "center",
            flexWrap: "wrap",
            gap: "20px",
            marginTop: "25px"
          }}
        >

          <div>
            <h2>⚛️</h2>
            <p>React</p>
          </div>

          <h2>➡️</h2>

          <div>
            <h2>☕</h2>
            <p>Spring Boot</p>
          </div>

          <h2>➡️</h2>

          <div>
            <h2>🗄️</h2>
            <p>Azure SQL</p>
          </div>

          <h2>➡️</h2>

          <div>
            <h2>☁️</h2>
            <p>App Service</p>
          </div>

        </div>

      </div>

      {/* ========================= FOOTER ========================= */}

      <div className="footer">

        <h3>Powered By</h3>

        <br />

        Terraform • GitHub Actions • Azure • Spring Boot • React • Azure SQL

        <br /><br />

        <small>

          Codespaces DevSecOps Dashboard v1.0.0

        </small>

      </div>

    </div>

  );

}

export default App;