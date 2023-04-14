-- 1.- CREACIÓN DE LA TABLA USUARIOS 
CREATE TABLE usuarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    fecha_registro DATE NOT NULL,
    activo BIT DEFAULT 1
);

-- 2.- GENERACIÓN DE 30 USUARIOS CON DATOS ALEAOTORIOS
INSERT INTO usuarios (nombre, apellido, email, contraseña, fecha_registro, activo)
SELECT 
    LEFT(NEWID(), 8),                          -- Generar un nombre aleatorio de 8 caracteres
    LEFT(NEWID(), 8),                          -- Generar un apellido aleatorio de 8 caracteres
    CONCAT('usuario', CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10))) + '@ynv.bo',    -- Generar un email aleatorio
    'contraseña' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR(10)),   -- Generar una contraseña única basada en el número de fila
    DATEADD(day, -1 * (ABS(CHECKSUM(NEWID())) % 365), GETDATE()),   -- Generar una fecha de registro aleatoria en los últimos 365 días
    CAST(RAND() * 2 AS BIT)                    -- Generar un valor aleatorio para el campo activo (0 o 1)
FROM
    (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
            (11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
            (21),(22),(23),(24),(25),(26),(27),(28),(29),(30)) AS nums(n);

-- 3.- MOSTRAR LA TABLA CON LOS USUSARIOS GENERADOS
SELECT *FROM usuarios;

-- 4.- ELIMINAR LA TABLA PARA PODER GENERAR DE NUEVO TODO
DROP TABLE usuarios;

