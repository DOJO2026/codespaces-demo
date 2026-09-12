import StatusCard from "./StatusCard";

function Dashboard(){

    return(

        <div className="dashboard">

            <StatusCard
                title="Frontend"
                value="React + Vite"
                status="online"
            />

            <StatusCard
                title="Backend"
                value="Spring Boot"
                status="online"
            />

            <StatusCard
                title="Azure SQL"
                value="Connected"
                status="online"
            />

            <StatusCard
                title="App Service"
                value="Linux"
                status="online"
            />

            <StatusCard
                title="Terraform"
                value="Infrastructure"
                status="online"
            />

            <StatusCard
                title="GitHub Actions"
                value="CI/CD"
                status="online"
            />

            <StatusCard
                title="Key Vault"
                value="Next Stage"
                status="pending"
            />

            <StatusCard
                title="OpenTelemetry"
                value="Next Stage"
                status="pending"
            />

        </div>

    );

}

export default Dashboard;