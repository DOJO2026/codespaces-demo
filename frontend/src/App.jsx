import { useState } from "react";
import axios from "axios";
import "./App.css";

function App() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);

  const consultarBackend = async () => {
    setLoading(true);

    try {
      const response = await axios.get("http://localhost:8080/api/demo");
      setData(response.data);
    } catch (error) {
      console.error(error);
      alert("No se pudo conectar con el Backend");
    }

    setLoading(false);
  };

  return (
    <div className="container">
      <h1> Codespaces DevOps Demo</h1>

      <h2>Frontend React + Spring Boot</h2>

      <button onClick={consultarBackend}>
        {loading ? "Consultando..." : "Consultar Backend"}
      </button>

      {data && (
        <div className="card">
          <h3>Respuesta del Backend</h3>

          <p>
            <strong>Status:</strong> {data.status}
          </p>

          <p>
            <strong>Mensaje:</strong> {data.message}
          </p>

          <p>
            <strong>Environment:</strong> {data.environment}
          </p>

          <p>
            <strong>Version:</strong> {data.version}
          </p>

          <p>
            <strong>Timestamp:</strong> {data.timestamp}
          </p>
        </div>
      )}
    </div>
  );
}

export default App;