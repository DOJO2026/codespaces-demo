function StatusCard({ title, value, status }) {

    return (

        <div className="dashboard-card">

            <h3>{title}</h3>

            <p>{value}</p>

            <br/>

            <span className={status}>

                ● {status.toUpperCase()}

            </span>

        </div>

    );

}

export default StatusCard;