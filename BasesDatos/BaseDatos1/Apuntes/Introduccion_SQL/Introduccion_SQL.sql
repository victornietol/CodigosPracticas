show databases;
-- Mostrando las tablas de una database
show tables from information_schema; 
-- Ver que se tiene en una tabla en particular
show columns from information_schema.tables;
-- Ver los indices
show index from information_schema.tables;
-- ver las variables del servidor
show variables;
-- ver el estado del servidor 
show status;
-- crear una base de datos
CREATE DATABASE prueba;
-- crear BD comprobando si no existe
CREATE DATABASE IF NOT EXISTS prueba;
-- conectar a la base de datos creada (BD prueba)
USE prueba;
-- si se quiere ver alguna parte de la BD ya no es necesario especificar a que BD
-- me tengo que conectar porque ya se establecio la conexión utilizando USE
show tables;
-- usando SELECT para visualizar datos
SELECT 'Hola mundo';
-- Poniendole nombre a la columna
SELECT 'Hola mundo' as saludo;
-- usar SELECT para ver el resultado de operaciones (las comas los separan por campos)
SELECT 4+2, 4-1, 4*2, 4/2;
-- ponerle nombre al campo (también se puede hace con 'as' como se hizo anteriormente)
SELECT 4+2 as suma, 4-1 as resta, 4*2 multiplicacion, 4/2 division;
-- tambien se puede utilizar SELECT con la jerarquia de parentesis
SELECT ((4+2) * (4-2)) / ((4*2) + (4/2)) operacion;
-- tambien se puede tener el resultado de funciones (fecha)
SELECT sysdate(), current_date(), current_time();
-- saber a que BD se esta conectado, con que usuario, y que version de BD tengo
SELECT database(), user(), version();
-- mostrar tablas en la base de datos actual
SHOW TABLES;
-- crear una tabla dentro de la BD en la que estoy conectado
CREATE TABLE proveedor(
	id_proveedor INT NOT NULL AUTO_INCREMENT,
    proveedor VARCHAR(100) NOT NULL,
    rfc varchar(13) NOT NULL, 
    fecha_registro DATETIME NULL,
    PRIMARY KEY(id_proveedor),
    UNIQUE KEY uk_rfc (rfc)
);
-- crear tabla verificando si ya existe
CREATE TABLE IF NOT EXISTS proveedor(
	id_proveedor INT NOT NULL AUTO_INCREMENT,
    proveedor VARCHAR(100) NOT NULL,
    rfc varchar(13) NOT NULL, 
    fecha_registro DATETIME NULL,
    PRIMARY KEY(id_proveedor),
    UNIQUE KEY uk_rfc (rfc)
);
-- creando otra tabla
CREATE TABLE IF NOT EXISTS producto(
	id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(18) NOT NULL UNIQUE,
    producto VARCHAR(200) NOT NULL,
    descripcion VARCHAR(100) NULL
);
-- ver las tablas creadas
SHOW TABLES;
-- ver los campos de la tabla
SHOW COLUMNS FROM proveedor;
-- ver la esctructura de una tabla mas rapido
DESC proveedor;
-- ver los indices
SHOW INDEX FROM proveedor;
-- ver los campos de una tabla
desc producto;
-- ver los indices de la nueva tabla
SHOW INDEX FROM producto;
-- borrar tabla si es que existe (elimina todos los elementos)
DROP TABLE IF EXISTS producto;
-- seleccionar que campos se quieren mostrar (* significa que todos) SELECT <campos> from <tabla>
select * from proveedor;
-- mostrar las tablas de una tabla especifica (en este caso las tablas del diccionario de datos
-- (information_schema) que coincidan con la tabla 'prueba'
select * from information_schema.tables where table_schema = 'prueba';