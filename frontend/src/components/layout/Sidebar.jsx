import {
  FaChartPie,
  FaUsers,
  FaHeartbeat,
  FaInfoCircle,
  FaCloud,
} from "react-icons/fa";

function Sidebar() {
  return (
    <aside className="sidebar">
      <div className="brand">
        <div className="brand-icon">D</div>

        <div>
          <h2>DOJO</h2>
          <span>DevOps Demo</span>
        </div>
      </div>

      <nav className="navigation">
        <button className="nav-item">
          <FaChartPie />
          Dashboard
        </button>

        <button className="nav-item active">
          <FaUsers />
          Clientes
        </button>

        <button className="nav-item">
          <FaHeartbeat />
          Estado de Servicios
        </button>

        <button className="nav-item">
          <FaInfoCircle />
          Acerca de
        </button>
      </nav>

      <div className="sidebar-footer">
        <FaCloud />

        <div>
          <strong>Demo DevSecOps</strong>
          <span>Azure • Terraform • GitHub</span>
          <small>v1.0.0</small>
        </div>
      </div>
    </aside>
  );
}

export default Sidebar;