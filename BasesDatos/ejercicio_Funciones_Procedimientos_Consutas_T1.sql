-- CONSULTAS Y CREACION DE FUNCIONES
USE tarea1_bd;

-- Creacion de la tabla direcciones
CREATE TABLE IF NOT EXISTS direccion(
	id_direccion INT NOT NULL AUTO_INCREMENT,
    calle VARCHAR(30) NOT NULL,
    numero_exterior INT NOT NULL,
    numero_interior INT NULL,
    codigo_postal INT(5) NOT NULL,
    colonia VARCHAR(50) NOT NULL,
    delegacion VARCHAR(70) NOT NULL,
    nombre_usuario VARCHAR(70) NOT NULL COMMENT "Usuario que realizo la modificacion",
	fecha_modificacion DATE NOT NULL COMMENT "Fecha de modificacion del registro",
    PRIMARY KEY (id_direccion)
);

-- Agregando fk a miembro
ALTER TABLE miembro ADD fk_direccion INT NULL;
ALTER TABLE miembro ADD FOREIGN KEY (fk_direccion) REFERENCES direccion(id_direccion);

-- Creando vista con el numero de libros disponibles
CREATE VIEW vista_libros_disponibles AS
	SELECT estado AS Estado, COUNT(*) AS TOTAL 
    FROM libros 
    WHERE estado = 'Disponible'
    GROUP BY estado;
SELECT * FROM vista_libros_disponibles;    

-- Consulta para mostrar los prestamos registrados con su libro, autor, y miembro que realizo el prestamo
SELECT p.fecha_inic Inicio_Prestamo, p.fecha_fin Termino_Prestamo, concat_ws(' ', m.nombre, m.ap_paterno, m.ap_materno) Miembro_Biblio, l.nombre Libro, autor_libro.autor Autor, l.genero Genero, l.anio_publicacion Anio_Publicacion, l.editorial Editorial, l.clasificacion Clasificacion
FROM libros l 
JOIN prestamos p ON (l.prestamos_id_prestamos = p.id_prestamos)
JOIN miembro m ON (m.id_miembro = p.miembro_id_miembro)
JOIN (
	SELECT concat_ws(' ', a.nombre, a.ap_paterno, a.ap_materno) autor, l.id_libros 	id_libro FROM libros_autores l_a
JOIN libros l ON (l_a.libros_id_libros = l.id_libros)
JOIN autores a ON (l_a.autores_id_autor = a.id_autor)
) autor_libro ON (l.id_libros = autor_libro.id_libro)
ORDER BY Inicio_Prestamo DESC;


-- CREACION DE FUNCIONES Y PROCEDIMIENTO ALMACENADO

-- Funcion para prestamos por dia
delimiter //
DROP FUNCTION IF EXISTS prestamos_dia //
CREATE FUNCTION prestamos_dia(fecha date)
returns int 
reads sql data
deterministic
begin
	declare num_lib int;
    declare resultado int;
    select count(*) from prestamos where fecha = fecha_inic group by fecha_inic into resultado;
    set num_lib = ifnull(resultado,0);
    return num_lib;
end //
delimiter ;

-- Funcion para devoluciones por dia
delimiter //
DROP FUNCTION IF EXISTS devoluciones_dia //
CREATE FUNCTION devoluciones_dia(fecha date)
returns int 
reads sql data
deterministic
begin
	declare num_lib int;
    declare resultado int;
    select count(*) from prestamos where fecha = fecha_fin group by fecha_fin into resultado;
    set num_lib = ifnull(resultado,0);
    return num_lib;
end //
delimiter ;

-- Procedimiento para generar el reporte segun el dia que se le indique y guardarlo en un archivo txt
delimiter //
DROP PROCEDURE IF EXISTS prestamos_dia //
CREATE PROCEDURE prestamos_dia(fecha date)
begin
	select rpad('|',1,''), rpad('FECHA',10,' '),rpad('|',1,''), rpad('No. Prestamos Dia',17,' '), rpad('|',1,''), rpad('No. Devoluciones',17,' '), rpad('|',1,'')
    union
    select rpad('|',1,''), rpad(fecha,10,' '), rpad('|',1,''), rpad(prestamos_dia(fecha),17,' '), rpad('|',1,''),  rpad(devoluciones_dia(fecha),17,' '), rpad('|',1,'') 
    into outfile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ReporteDia.txt';
end //
delimiter ;

-- Procedimiento para generar el reporte de todos los prestamos registrados y guardarlo en un txt
delimiter //
DROP PROCEDURE IF EXISTS prestamos_registrados //
CREATE PROCEDURE prestamos_registrados()
begin
	SELECT RPAD('|',1,''), RPAD('INICIO_PRESTAMO',15,' '), RPAD('|',1,''), RPAD('TERMINO_PRESTAMO',16,' '), RPAD('|',1,''), RPAD('MIEMBRO_BIBLIOTECA',50,' '), RPAD('|',1,''), RPAD('LIBRO',50,' '), RPAD('|',1,''), RPAD('AUTOR',50,' '), RPAD('|',1,''), RPAD('GENERO',30,' '), RPAD('|',1,''), RPAD('ANIO_PUBLICACION',16,' '), RPAD('|',1,''), RPAD('EDITORIAL',40,' '), RPAD('|',1,''), RPAD('CLASIFICACION',20,' '), RPAD('|',1,'')
    union
	SELECT RPAD('|',1,''), RPAD(p.fecha_inic,15,' '), RPAD('|',1,''), RPAD(p.fecha_fin,16,' '), RPAD('|',1,''), RPAD(concat_ws(' ', m.nombre, m.ap_paterno, m.ap_materno),50,' '), RPAD('|',1,''), RPAD(l.nombre,50,' '), RPAD('|',1,''), RPAD(autor_libro.autor,50,' '), RPAD('|',1,''), RPAD(l.genero,30,' '), RPAD('|',1,''), RPAD(l.anio_publicacion,16,' '), RPAD('|',1,''), RPAD(l.editorial,40,' '), RPAD('|',1,''), RPAD(l.clasificacion,20,' '), RPAD('|',1,'')
	FROM libros l 
	JOIN prestamos p ON (l.prestamos_id_prestamos = p.id_prestamos)
	JOIN miembro m ON (m.id_miembro = p.miembro_id_miembro)
	JOIN (
		SELECT concat_ws(' ', a.nombre, a.ap_paterno, a.ap_materno) autor, l.id_libros 	id_libro FROM libros_autores l_a
	JOIN libros l ON (l_a.libros_id_libros = l.id_libros)
	JOIN autores a ON (l_a.autores_id_autor = a.id_autor)
	) autor_libro ON (l.id_libros = autor_libro.id_libro)
	-- ORDER BY Inicio_Prestamo DESC
	INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ReportePrestamos.txt';
end //
delimiter ;

-- Usando el procedimiento para generar el reporte de algunos dias
CALL prestamos_dia('2022-06-15');

-- Usando el procedimiento para generar el reporte de prestamos totales
CALL prestamos_registrados();