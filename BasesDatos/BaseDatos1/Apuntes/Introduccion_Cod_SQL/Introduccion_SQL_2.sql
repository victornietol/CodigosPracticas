-- para mostrar tablas del base puro
show variables like '%dir%';
show databases;
show tables from sakila; -- no tocar esta parte
create database if not exists prueba2459;
use prueba2459;
CREATE TABLE escritor (
id_escritor INT NOT NULL auto_increment, 
nombre VARCHAR(30) NOT NULL, 
apellidos VARCHAR(40) NOT NULL, 
direccion VARCHAR(100) NULL,
alias VARCHAR(30) NULL DEFAULT 'NA', 
PRIMARY KEY(id_escritor)
) ;
-- independencia fisica 
-- drop database prueba2459; -- cuidado con usar drop

show tables;
show index from escritor; -- tambien se puede mostrar como show index from prueba2459.escritor;

CREATE TABLE libro(
	id_libro INT NOT NULL auto_increment PRIMARY KEY,
    id_escritor INT NOT NULL,
    titulo VARCHAR(200) NOT NULL UNIQUE,
    contenido TEXT NULL,
    FOREIGN KEY (id_escritor) REFERENCES escritor(id_escritor) -- Llave foranea REFERENCES de donde viene
    ON DELETE RESTRICT ON UPDATE CASCADE 
);

CREATE UNIQUE INDEX uk_escritor ON escritor(nombre, apellidos);
SHOW create table escritor; -- mostrar como se creo la tabla

-- como resultado de copiar el campo sin comillas generado por SHOW create table escritor;
CREATE TABLE `escritor` (
  `id_escritor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `apellidos` varchar(40) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `alias` varchar(30) DEFAULT 'NA',
  PRIMARY KEY (`id_escritor`),
  UNIQUE KEY `uk_escritor` (`nombre`,`apellidos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

show index from libro;

-- crear una tabla poeta basada en la tabla escritor
CREATE TABLE poeta LIKE escritor;

show tables;
desc poeta;

-- mofificar tabla
ALTER TABLE poeta CHANGE id_escritor id_poeta INT NOT NULL;  -- CHANGE <campo que se va a cambiar> <nuevo nombre> <constructores>

-- borrar algo, en este caso quitar que sea llave primaria
ALTER TABLE poeta DROP PRIMARY KEY;

-- agregar de nuevo llave primaria
ALTER TABLE poeta ADD PRIMARY KEY(id_poeta);

-- agregar campo
ALTER TABLE poeta
ADD nacionalidad VARCHAR(30) NULL AFTER direccion, -- AFTER indica despues de que campo se va a colocar el campo nuevo
ADD fnac DATE NULL;  -- los datos que se agreguen deben de ser nulos

-- quitar algun elemento 
ALTER TABLE poeta
ADD COLUMN sueldo DECIMAL(10,2) NULL,
DROP fnac,
MODIFY direccion VARCHAR(200); -- se utiliza para modificar 