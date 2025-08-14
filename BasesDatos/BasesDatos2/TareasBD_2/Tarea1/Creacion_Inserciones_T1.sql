-- CREACION DE LA BASE DE DATOS
DROP DATABASE IF EXISTS tarea1_bd;
CREATE DATABASE IF NOT EXISTS tarea1_bd;
USE tarea1_bd;

CREATE TABLE IF NOT EXISTS autores(
  id_autor INT NOT NULL AUTO_INCREMENT,
  nacionalidad VARCHAR(70) NOT NULL,
  nombre VARCHAR(70) NOT NULL,
  ap_paterno VARCHAR(45) NOT NULL,
  ap_materno VARCHAR(45) NOT NULL,
  nombre_usuario VARCHAR(70) NOT NULL COMMENT "Usuario que realizo la modificacion",
  fecha_modificacion DATE NOT NULL COMMENT "Fecha de modificacion del registro",
  PRIMARY KEY (id_autor)
);

CREATE TABLE IF NOT EXISTS miembro(
  id_miembro INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(70) NOT NULL,
  ap_paterno VARCHAR(45) NOT NULL,
  ap_materno VARCHAR(45) NOT NULL,
  adeudo FLOAT NOT NULL,
  anio_nacimiento DATE NOT NULL,
  nombre_usuario VARCHAR(70) NOT NULL COMMENT "Usuario que realizo la modificacion",
  fecha_modificacion DATE NOT NULL COMMENT "Fecha de modificacion del registro",
  PRIMARY KEY (id_miembro)
);

CREATE TABLE IF NOT EXISTS prestamos(
  id_prestamos INT NOT NULL AUTO_INCREMENT,
  fecha_inic DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  miembro_id_miembro INT NOT NULL,
  nombre_usuario VARCHAR(70) NOT NULL COMMENT "Usuario que realizo la modificacion",
  fecha_modificacion DATE NOT NULL COMMENT "Fecha de modificacion del registro",
  PRIMARY KEY (id_prestamos),
  FOREIGN KEY (miembro_id_miembro) REFERENCES miembro (id_miembro)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS libros(
  id_libros INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  estado VARCHAR(45) NOT NULL,
  genero VARCHAR(45) NOT NULL,
  anio_publicacion DATE NOT NULL,
  editorial VARCHAR(70) NOT NULL,
  clasificacion VARCHAR(20) NOT NULL,
  costo FLOAT NOT NULL,
  prestamos_id_prestamos INT NOT NULL,
  nombre_usuario VARCHAR(70) NOT NULL COMMENT "Usuario que realizo la modificacion",
  fecha_modificacion DATE NOT NULL COMMENT "Fecha de modificacion del registro",
  PRIMARY KEY (id_libros),
  FOREIGN KEY (prestamos_id_prestamos) REFERENCES prestamos (id_prestamos)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS libros_autores(
  id_libro INT NOT NULL AUTO_INCREMENT,
  autores_id_autor INT NOT NULL,
  libros_id_libros INT NOT NULL,
  nombre_usuario VARCHAR(70) NOT NULL COMMENT "Usuario que realizo la modificacion",
  fecha_modificacion DATE NOT NULL COMMENT "Fecha de modificacion del registro",
  PRIMARY KEY (id_libro),
  FOREIGN KEY (autores_id_autor) REFERENCES autores (id_autor)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (libros_id_libros) REFERENCES libros (id_libros)
    ON DELETE RESTRICT ON UPDATE CASCADE
);


-- INSERCIONES EN LA BASE DE DATOS

INSERT INTO autores(nacionalidad,nombre,ap_paterno,ap_materno,nombre_usuario,fecha_modificacion) VALUES 
	('China','Winifield','Gritland','Crock','Victor Nieto','2024-02-21'),
	('Russia','Gaye','Alexsandrov','Flatte','Victor Nieto','2024-02-21'),
	('Libya','Leone','Slator','McClaren','Victor Nieto','2024-02-21'),
	('Indonesia','Sofie','Fashion','Scullin','Victor Nieto','2024-02-21'),
	('Russia','Luisa','Winman','Joppich','Victor Nieto','2024-02-21'),
	('Czech Republic','Borg','Skypp','Brooke','Victor Nieto','2024-02-21'),
	('Indonesia','Monti','Hedditeh','Petren','Victor Nieto','2024-02-21'),
	('Mexico','Aurthur','Boyne','Beatens','Victor Nieto','2024-02-21'),
	('Indonesia','Almeria','Mitchenson','Clelland','Victor Nieto','2024-02-21'),
	('Francia','St. Clair','Roofe','Shalne','Victor Nieto','2024-02-21'),
    ('Burkina_Faso','Gallen','Lusgdin','Zollie','Victor Nieto','2024-02-21'),
    ('Mexico','Kingsmill','Sheering','Mose','Victor Nieto','2024-02-21'),
    ('French Southern Territories','Sharia','Humblestone','Brandon','Victor Nieto','2024-02-21'),
    ('Madagascar','Brideaux','Cash','Trey','Victor Nieto','2024-02-21'),
    ('Nigeria','Patrica','Routhorn','Gilla','Victor Nieto','2024-02-21');

INSERT INTO miembro(nombre,ap_paterno,ap_materno,adeudo,anio_nacimiento,nombre_usuario,fecha_modificacion) VALUES
	('Javier', 'Suárez', 'Pérez', 103.34, '2002-12-11','Victor Nieto','2024-02-21'),
    ('María', 'García', 'López', 50.20, '1990-05-02','Victor Nieto','2024-02-21'),
    ('Pedro', 'Martínez', 'Gómez', 75.60, '1992-09-15','Victor Nieto','2024-02-21'),
    ('Laura', 'Hernández', 'Rodríguez', 20.10, '1985-10-07','Victor Nieto','2024-02-21'),
    ('Carlos', 'Pérez', 'Sánchez', 30.75, '1988-04-20','Victor Nieto','2024-02-21'),
    ('Ana', 'González', 'Fernández', 90.00, '1983-11-25','Victor Nieto','2024-02-21'),
    ('Sofía', 'Díaz', 'Jiménez', 15.40, '1995-01-30','Victor Nieto','2024-02-21'),
    ('Luis', 'Ruiz', 'Vargas', 45.30, '1998-03-08','Victor Nieto','2024-02-21'),
    ('Diego', 'Flores', 'López', 60.80, '1993-06-18','Victor Nieto','2024-02-21'),
    ('Andrea', 'Gómez', 'Hernández', 25.00, '1987-10-22','Victor Nieto','2024-02-21'),
	('Ana', 'López', 'García', 150.20, '1989-05-15','Victor Nieto','2024-02-21'),
    ('Pedro', 'Martínez', 'Hernández', 80.50, '1995-08-20','Victor Nieto','2024-02-21'),
    ('María', 'González', 'Rodríguez', 45.70, '1980-03-10','Victor Nieto','2024-02-21'),
    ('Juan', 'Sánchez', 'Pérez', 30.00, '1992-11-25','Victor Nieto','2024-02-21'),
    ('Laura', 'Díaz', 'Fernández', 60.90, '1987-09-02','Victor Nieto','2024-02-21');
    
INSERT INTO prestamos(fecha_inic,fecha_fin,miembro_id_miembro,nombre_usuario,fecha_modificacion) VALUES
	('2022-06-15', '2022-07-20', 9,'Victor Nieto','2024-02-21'),
    ('2022-06-15', '2023-05-05', 5,'Victor Nieto','2024-02-21'),
    ('2023-08-25', '2023-09-30', 13,'Victor Nieto','2024-02-21'),
    ('2022-12-01', '2023-01-15', 3,'Victor Nieto','2024-02-21'),
    ('2023-09-05', '2023-11-20', 8,'Victor Nieto','2024-02-21'),
    ('2022-10-20', '2023-01-05', 7,'Victor Nieto','2024-02-21'),
    ('2023-04-15', '2023-08-15', 14,'Victor Nieto','2024-02-21'),
    ('2023-07-01', '2023-08-15', 2,'Victor Nieto','2024-02-21'),
    ('2023-02-10', '2023-04-30', 12,'Victor Nieto','2024-02-21'),
    ('2023-05-20', '2023-07-25', 6,'Victor Nieto','2024-02-21'),
    ('2022-11-10', '2023-01-20', 4,'Victor Nieto','2024-02-21'),
    ('2022-11-10', '2023-03-10', 11,'Victor Nieto','2024-02-21'),
    ('2023-06-25', '2023-09-15', 10,'Victor Nieto','2024-02-21'),
    ('2022-08-05', '2022-10-10', 1,'Victor Nieto','2024-02-21'),
    ('2022-09-15', '2022-11-25', 15,'Victor Nieto','2024-02-21');    
    
INSERT INTO libros(nombre,estado,genero,anio_publicacion,editorial,clasificacion,costo,prestamos_id_prestamos,nombre_usuario,fecha_modificacion) VALUES
	('La sombra del viento', 'Dañado', 'Misterio', '2001-04-27', 'Planeta', 'Adultos', 22.99, 8,'Victor Nieto','2024-02-21'),
    ('Harry Potter y la piedra filosofal', 'Disponible', 'Fantasía', '1997-06-26', 'Bloomsbury Publishing', 'Niños', 19.99, 3,'Victor Nieto','2024-02-21'),
    ('Cien años de soledad', 'Prestado', 'Ficción', '1967-05-30', 'Editorial Sudamericana', 'Adultos', 25.99, 12,'Victor Nieto','2024-02-21'),
    ('El código Da Vinci', 'Disponible', 'Misterio', '2003-03-18', 'Doubleday', 'Adultos', 15.50, 7,'Victor Nieto','2024-02-21'),
    ('El alquimista', 'Disponible', 'Novela', '1988-11-25', 'HarperCollins', 'Adolescentes', 12.75, 9,'Victor Nieto','2024-02-21'),
    ('1984', 'Disponible', 'Ciencia ficción', '1949-06-08', 'Secker & Warburg', 'Adultos', 18.25, 6,'Victor Nieto','2024-02-21'),
    ('El principito', 'Prestado', 'Literatura infantil', '1943-04-06', 'Reynal & Hitchcock', 'Niños', 14.99, 14,'Victor Nieto','2024-02-21'),
    ('Los juegos del hambre', 'Prestado', 'Ciencia ficción', '2008-09-14', 'Scholastic Corporation', 'Adolescentes', 20.75, 2,'Victor Nieto','2024-02-21'),
    ('Romeo y Julieta', 'Dañado', 'Tragedia', '1597-01-20', 'Thomas Cotes', 'Adolescentes', 13.25, 4,'Victor Nieto','2024-02-21'),
    ('Orgullo y prejuicio', 'Disponible', 'Clásico', '1813-01-28', 'T. Egerton, Whitehall', 'Adultos', 10.00, 11,'Victor Nieto','2024-02-21'),
    ('Las crónicas de Narnia', 'Prestado', 'Fantasía', '1950-10-16', 'Geoffrey Bles', 'Niños', 27.00, 5,'Victor Nieto','2024-02-21'),
    ('El señor de los anillos', 'Disponible', 'Fantasía', '1954-07-29', 'George Allen & Unwin', 'Adolescentes', 30.50, 15,'Victor Nieto','2024-02-21'),
    ('Crónica de una muerte anunciada', 'Disponible', 'Ficción', '1981-09-05', 'La Oveja Negra', 'Adolescentes', 16.80, 10,'Victor Nieto','2024-02-21'),
    ('El nombre del viento', 'Disponible', 'Fantasía', '2007-03-27', 'Daw Books', 'Adultos', 18.95, 1,'Victor Nieto','2024-02-21'),
    ('El gran Gatsby', 'Disponible', 'Ficción', '1925-04-10', 'Charles Scribner Sons', 'Adultos', 21.50, 13,'Victor Nieto','2024-02-21');
    
INSERT INTO libros_autores(autores_id_autor,libros_id_libros,nombre_usuario,fecha_modificacion) VALUES
	(7, 11,'Victor Nieto','2024-02-21'),
    (3, 8,'Victor Nieto','2024-02-21'),
    (14, 5,'Victor Nieto','2024-02-21'),
    (2, 9,'Victor Nieto','2024-02-21'),
    (10, 6,'Victor Nieto','2024-02-21'),
    (1, 15,'Victor Nieto','2024-02-21'),
    (13, 4,'Victor Nieto','2024-02-21'),
    (12, 7,'Victor Nieto','2024-02-21'),
    (5, 10,'Victor Nieto','2024-02-21'),
    (8, 3,'Victor Nieto','2024-02-21'),
    (6, 12,'Victor Nieto','2024-02-21'),
    (11, 2,'Victor Nieto','2024-02-21'),
    (4, 13,'Victor Nieto','2024-02-21'),
    (9, 1,'Victor Nieto','2024-02-21'),
    (15, 14,'Victor Nieto','2024-02-21');