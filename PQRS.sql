DROP DATABASE IF EXISTS pqrsDb;
CREATE DATABASE pqrsDb CHARACTER SET utf8mb4;
USE pqrsDb;

CREATE TABLE usuarios (
 idUsuario INT PRIMARY KEY AUTO_INCREMENT,
 nombre VARCHAR(70) NOT NULL, 
 apellido VARCHAR(70) NOT NULL,
 telefono VARCHAR(70) NOT NULL, 
 cedula VARCHAR(70) UNIQUE NOT NULL, 
 correo VARCHAR(150) NOT NULL,
 contrasena VARCHAR(50) NOT NULL,
 rol ENUM('Admin', 'Usuario') NOT NULL
	);        
 
 INSERT INTO usuarios (nombre, apellido, telefono, cedula, correo, contrasena, rol)
VALUES ('anyel', 'lopez', '32321', '1087', 'es@1', '11', 'Admin');     
      
      
CREATE TABLE pqrs (
  nombre VARCHAR (200) NOT NULL,
  apellido VARCHAR (200) NOT NULL, 
  telefono VARCHAR(50) NOT NULL,
  cedula VARCHAR(50) NOT NULL PRIMARY KEY,
  tipo VARCHAR(50),
  descripcion VARCHAR (50),
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO pqrs (nombre, apellido, telefono, cedula, tipo, descripcion) 
VALUES 
	('anyel', 'lopez', '123', '12333', 'queja', 'muy mal');

DELIMITER //

CREATE PROCEDURE agregar (
 IN tut_nombre VARCHAR(200),
  IN tut_apellido VARCHAR(50), 
  IN tut_telefono TEXT,
  IN tut_cedula VARCHAR(50),
  IN tut_tipo VARCHAR(50),
  IN tut_descripcion VARCHAR(50)
)
BEGIN
    INSERT INTO pqrs (nombre, apellido, telefono, cedula, tipo, descripcion, fecha)
    VALUES (tut_nombre, tut_apellido, tut_telefono, tut_cedula, tut_tipo, tut_descripcion, CURRENT_TIMESTAMP);
    
    SELECT * FROM pqrs WHERE nombre = tut_nombre AND apellido = tut_apellido AND telefono = tut_telefono 
    AND cedula = tut_cedula AND tipo = tut_tipo AND descripcion = tut_descripcion;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE agregarUsuarios (
    IN tut_Nombre VARCHAR(70),
    IN tut_Apellido VARCHAR(70),
    IN tut_telefono VARCHAR(70), 
    IN tut_Cedula VARCHAR(70),
    IN tut_Correo VARCHAR(150),
    IN tut_Contrasena VARCHAR(50),
    IN tut_Rol ENUM('Admin', 'Usuario')
)
BEGIN
    INSERT INTO usuarios (nombre, apellido, telefono, cedula, correo, contrasena, rol)
    VALUES (tut_Nombre, tut_Apellido, tut_telefono, tut_Cedula, tut_Correo, tut_Contrasena, tut_Rol);
END //

DELIMITER ;