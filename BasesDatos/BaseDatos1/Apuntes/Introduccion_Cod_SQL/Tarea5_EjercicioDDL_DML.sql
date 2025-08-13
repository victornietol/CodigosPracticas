-- 1.
create database if not exists ejercicio5;
use ejercicio5;

-- 2 y 3.
create table if not exists personal(
	id_personal INT NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    ap_paterno varchar(20) NOT NULL,
    ap_materno varchar(20) NOT NULL,
    fecha_nac date NOT NULL,
    rfc varchar(13) NOT NULL,
    sexo varchar(1) NOT NULL,
    direccion varchar(100) DEFAULT NULL,
	colonia varchar(100) DEFAULT NULL,
	cp varchar(6) DEFAULT NULL,
	ciudad varchar(100) DEFAULT NULL,
    PRIMARY KEY(id_personal),
    UNIQUE KEY uk_rfc(rfc)
);

create table if not exists producto(
	id_producto INT NOT NULL AUTO_INCREMENT,
    producto varchar(100) NOT NULL,
    peso INT NOT NULL,
    descripcion varchar(200) NOT NULL,
    fecha_reg DATE NOT NULL,
    PRIMARY KEY(id_producto)
);

create table if not exists certificacion(
	id_certificacion INT NOT NULL AUTO_INCREMENT,
    id_personal INT NOT NULL,
    certificacion varchar(100) NOT NULL,
    empresa varchar(100) NOT NULL,
    cargo varchar(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    fecha_expedicion DATE NOT NULL,
    PRIMARY KEY(id_certificacion),
    FOREIGN KEY(id_personal) REFERENCES personal(id_personal)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- 4.
ALTER table producto add UNIQUE INDEX uk_idproducto_producto (id_producto, producto);
ALTER table certificacion add UNIQUE INDEX uk_id_cert_certificacion_empresa (id_certificacion, certificacion, empresa);
ALTER table personal add UNIQUE INDEX uk_nombre_completo (nombre, ap_paterno, ap_materno);

-- 5.
ALTER table producto DROP index uk_idproducto_producto;

-- 6. 
ALTER table producto ADD precio INT NULL AFTER descripcion;

-- 7.
ALTER table producto MODIFY precio DECIMAL(10,2);

-- 8. 
ALTER table personal RENAME to empleado;

-- 9.
ALTER table certificacion DROP fecha_contratacion;

-- 10.
ALTER table producto MODIFY id_producto INT NOT NULL; -- Eliminando autoincrement para poder eliminar la PK
ALTER table producto DROP PRIMARY KEY;

-- 11.
INSERT INTO producto (id_producto, producto, peso, descripcion, fecha_reg) values (1,'REFRESCO COLA', 1, 'REFRESCO SABOR COLA DE 1 LITRO', '2021-02-13' );
INSERT INTO producto SET id_producto = 2, producto = 'TELEVISION', peso = 3, descripcion = 'TELEVISION DE 50 PULGADAS OLED', precio = 19000.00, fecha_reg = '2021-03-27';
INSERT INTO producto values
(3,'REFRIGERADOR', 65, 'REFRIGERADOR 11 PIES', 7990.00, '2022-01-10' ),
(4,'SOFA', 30, 'SOFA CAMA', 4699.00, '2020-07-03' ),
(5,'COLCHON', 37, 'COLCHON KING SIZE', 5399.99, '2022-02-25' );

INSERT INTO  empleado values 
(null, 'JAVIER', 'RAMIREZ', 'HERNANDEZ', '1978-11-23', 'RAHJ7811231HO', 'M', 'CALLE 24', 'TULTEPEC', '55020', 'ESTADO DE MEXICO'),
(null, 'DAVID', 'GONZALEZ', 'OLVERA', '1995-04-16','GOOD9504162DA', 'M', 'CALLE FLORES', 'TLATELOLCO', '507670', 'CIUDAD DE MEXICO'),
(null, 'EDUARDO', 'MANCERA', 'ESLAVA', '1989-08-02','MAEE8908021NT', 'M', 'AVENIDA CENTRAL', 'SAN NICOLAS DE LOS GARZA', '66635', 'NUEVO LEON'),
(null, 'ALEJANDRA', 'TORRES', 'MARTINEZ', '1983-05-17','TOMA8305172FE', 'F', 'EJE LUIS OLVERA', 'VALLEJO', '07670', 'CIUDAD DE MEXICO'),
(null, 'SUSANA', 'ALVAREZ', 'MORALES', '1992-12-02','ALMS9212025FI', 'F', 'AVENIDA PROGRESO', 'DOCTORES', '06350', 'CIUDAD DE MEXICO');

INSERT INTO certificacion SET id_certificacion = null, id_personal = 1, certificacion = 'LABORAL', empresa = 'EMPRESA X', cargo = 'DIRECTOR COMERCIAL', fecha_expedicion = '2022-03-22';
INSERT INTO certificacion values 
(null, 2, 'LABORAL', 'FERRETERIA ABC', 'CONTADOR', '2020-11-30'),
(null, 3,'LABORAL', 'CONSTRUCTORA Z', 'DIRECTOR DE PROYECTOS', '2021-09-17'),
(null, 4,'LABORAL', 'MUEBLERIA SA', 'DIRECTOR DE FINANZAS', '2022-04-01'),
(null, 4,'CURSO DISEÑO', 'EMPRESA CURSOS X', 'DISEÑADOR', '2021-12-24'),
(null, 5,'LABORAL', 'TALLER MN', 'MECANICO', '2021-12-24');

-- 12.
DELETE FROM empleado where id_personal = 2; -- Se borrará el empleado en la tabla empleado y también se borraran sus certificaciones debido a que se tiene activo ON DELETE CASCADE

-- 13.
CREATE TABLE producto_tmp SELECT * FROM producto;

-- 14.
select * from information_schema.tables where table_schema = 'ejercicio5' AND (table_name = 'certificacion' or table_name = 'empleado' or table_name = 'producto' or table_name = 'producto_tmp'); 

-- 15.
DROP DATABASE ejercicio5;
