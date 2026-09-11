IF NOT EXISTS (SELECT 1 FROM clientes)
BEGIN

INSERT INTO clientes(nombre,correo)
VALUES
('Juan Perez','juan@demo.com'),
('Maria Lopez','maria@demo.com'),
('Carlos Ramos','carlos@demo.com');

END;