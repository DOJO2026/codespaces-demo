import { useState } from "react";

import {
  FaUsers,
  FaLaptop,
  FaServer,
  FaSyncAlt,
  FaExclamationCircle,
} from "react-icons/fa";

import Sidebar from "./components/layout/Sidebar";
import Header from "./components/layout/Header";
import ServiceCard from "./components/status/ServiceCard";
import ClientesTable from "./components/tables/ClientesTable";

import { getClientes } from "./services/api";

import "./styles/app.css";

function App() {
  const [clientes, setClientes] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [backendConnected, setBackendConnected] = useState(false);

  const consultarClientes = async () => {
    setLoading(true);
    setError("");

    try {
      const data = await getClientes();

      setClientes(data);
      setBackendConnected(true);
    } catch (err) {
      console.error("Error consultando clientes:", err);

      setClientes([]);
      setBackendConnected(false);
      setError("No se pudo consultar el backend.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="app">
      <Sidebar />

      <div className="main-area">
        <Header />

        <main className="content">
          <section className="page-title">
            <div className="title-icon">
              <FaUsers />
            </div>

            <div>
              <h1>Clientes</h1>
              <p>
                Consulta y visualiza los clientes registrados en el sistema.
              </p>
            </div>
          </section>

          <section className="services">
            <ServiceCard
              icon={<FaLaptop />}
              title="Frontend"
              technology="React + Vite"
              status="Disponible"
              detail={window.location.host}
              connected={true}
            />

            <ServiceCard
              icon={<FaServer />}
              title="Backend"
              technology="Spring Boot"
              status={backendConnected ? "Conectado" : "No conectado"}
              detail={
                import.meta.env.VITE_API_URL || "http://localhost:8080"
              }
              connected={backendConnected}
            />
          </section>

          <section className="clients-panel">
            <div className="panel-header">
              <div>
                <h2>Listado de Clientes</h2>
                <p>
                  Obtiene la información directamente desde el backend.
                </p>
              </div>

              <button
                className="primary-button"
                onClick={consultarClientes}
                disabled={loading}
              >
                <FaSyncAlt className={loading ? "spin" : ""} />

                {loading ? "Consultando..." : "Consultar clientes"}
              </button>
            </div>

            {error && (
              <div className="error-message">
                <FaExclamationCircle />

                <div>
                  <strong>{error}</strong>
                  <span>
                    Verifica que el backend esté disponible y que la URL sea
                    correcta.
                  </span>
                </div>
              </div>
            )}

            <ClientesTable clientes={clientes} />
          </section>
        </main>

        <footer>
          <span>© 2026 DOJO - Demo DevSecOps</span>
          <span>React + Vite | Azure | Spring Boot</span>
        </footer>
      </div>
    </div>
  );
}

export default App;