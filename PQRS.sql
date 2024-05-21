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
 rol ENUM('Admin', 'Usuario') NOT NULL,
 fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);        
 
 SELECT DATE_FORMAT(fecha, '%Y-%m-%d %h:%i:%s %p') AS fecha_formato_12h FROM usuarios;
 INSERT INTO usuarios (nombre, apellido, telefono, cedula, correo, contrasena, rol)
VALUES ('anyel', 'lopez', '32321', '1087', 'es@1', '11', 'Admin');     
      
      
CREATE TABLE pqrs (
  idPqrs INT (10) PRIMARY KEY,
  tipo VARCHAR(50),
  descripcion VARCHAR (50),
  archivo VARCHAR (255),
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

  
INSERT INTO pqrs (idPqrs, tipo, descripcion, archivo) 
VALUES 
	(1, 'queja', 'muy mal', '.pdf');

/* PROCEDIMIENTOS---------------*/
DELIMITER //
CREATE PROCEDURE agregar (
  IN tut_idPqrs INT (10),
  IN tut_tipo VARCHAR(50),
  IN tut_descripcion VARCHAR(50),
  IN tut_archivo VARCHAR (255)
)
BEGIN
SELECT DATE_FORMAT(fecha, '%Y-%m-%d %h:%i:%s %p') AS fecha FROM pqrs;
    INSERT INTO pqrs (idPqrs, tipo, descripcion, archivo, fecha)
    VALUES (tut_idPqrs, tut_tipo, tut_descripcion, tut_archivo, CURRENT_TIMESTAMP);
    
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
    INSERT INTO usuarios (nombre, apellido, telefono, cedula, correo, contrasena, rol, fecha)
    VALUES (tut_Nombre, tut_Apellido, tut_telefono, tut_Cedula, tut_Correo, tut_Contrasena, tut_Rol, CURRENT_TIMESTAMP);
END //

DELIMITER ;