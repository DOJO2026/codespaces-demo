import "./Header.css";

function Header() {

    const fecha = new Date();

    const hora = fecha.toLocaleTimeString("es-PE");

    const dia = fecha.toLocaleDateString("es-PE");

    return (

        <header className="header">

            <div className="header-left">

                <div className="logo-title">

                    <div className="logo">

                        🚀

                    </div>

                    <div>

                        <h1>

                            CODESPACES DEVSECOPS

                        </h1>

                        <h2>

                            CONTROL CENTER

                        </h2>

                    </div>

                </div>

                <p className="subtitle">

                    Terraform • GitHub Actions • Azure • Spring Boot • React • Azure SQL

                </p>

            </div>

            <div className="header-right">

                <div className="status-card">

                    <span className="status-green"></span>

                    DEV

                </div>

                <div className="status-info">

                    <p>

                        <strong>Version:</strong> 1.0.0

                    </p>

                    <p>

                        <strong>Region:</strong> East US 2

                    </p>

                    <p>

                        <strong>Fecha:</strong> {dia}

                    </p>

                    <p>

                        <strong>Hora:</strong> {hora}

                    </p>

                </div>

            </div>

        </header>

    );

}

export default Header;