IF OBJECT_ID('clientes', 'U') IS NULL
BEGIN
    CREATE TABLE clientes
    (
        id BIGINT IDENTITY(1,1) PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL,
        correo VARCHAR(255) NOT NULL UNIQUE
    );
END;