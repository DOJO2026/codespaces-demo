import "./Architecture.css";

import {
    SiReact,
    SiSpringboot,
    SiTerraform,
    SiGithubactions,
    SiMicrosoftsqlserver,
    FaMicrosoft
} from "../icons/AzureIcons";

function Architecture() {

    return (

        <div className="architecture">

            <h2>Arquitectura DevSecOps</h2>

            <div className="flow">

                <div className="node">
                    <SiGithubactions size={48} />
                    <span>GitHub</span>
                </div>

                <div className="arrow">→</div>

                <div className="node">
                    <SiTerraform size={48} />
                    <span>Terraform</span>
                </div>

                <div className="arrow">→</div>

                <div className="node">
                    <FaMicrosoft size={48} />
                    <span>Azure</span>
                </div>

                <div className="arrow">→</div>

                <div className="node">
                    <SiSpringboot size={48} />
                    <span>Spring Boot</span>
                </div>

                <div className="arrow">→</div>

                <div className="node">
                    <SiMicrosoftsqlserver size={48} />
                    <span>Azure SQL</span>
                </div>

                <div className="arrow">→</div>

                <div className="node">
                    <SiReact size={48} />
                    <span>React</span>
                </div>

            </div>

        </div>

    );

}

export default Architecture;