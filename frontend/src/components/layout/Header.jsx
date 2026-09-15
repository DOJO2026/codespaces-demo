import { FaBars, FaUser } from "react-icons/fa";

function Header() {
  return (
    <header className="header">
      <div className="header-left">
        <FaBars className="menu-icon" />

        <div>
          <h3>Sistema de Gestión</h3>
          <span>Frontend React + Backend Spring Boot</span>
        </div>
      </div>

      <div className="header-right">
        <span className="environment">
          <span className="environment-dot"></span>
          DEV
        </span>

        <div className="user-icon">
          <FaUser />
        </div>
      </div>
    </header>
  );
}

export default Header;