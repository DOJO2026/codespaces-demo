function ServiceCard({
  icon,
  title,
  technology,
  status,
  detail,
  connected = true,
}) {
  return (
    <div className={`service-card ${connected ? "" : "error"}`}>
      <div className="service-icon">{icon}</div>

      <div className="service-info">
        <strong>{title}</strong>
        <span>{technology}</span>

        <div
          className={`service-status ${
            connected ? "connected" : "disconnected"
          }`}
        >
          <span className="status-dot"></span>
          {status}
        </div>
      </div>

      <span className="service-detail">{detail}</span>
    </div>
  );
}

export default ServiceCard;