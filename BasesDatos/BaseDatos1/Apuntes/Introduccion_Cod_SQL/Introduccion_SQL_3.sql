use prueba2459;
show tables;

select * from escritor;
desc escritor;
show index from escritor;

INSERT INTO escritor VALUES (null,'OCTAVIO','PAZ','MX',NULL); -- Ingresar datos en los campos de una tabla (con clausula VALUES)
INSERT INTO escritor (nombre, apellidos) VALUES ('ELENA','PONIATOWSKA'); -- solo ingresar campos especificos

INSERT INTO escritor (nombre, apellidos) VALUES ('ROSARIO', NULL); -- no se puede ingresar porque el segundo no puede ser null
INSERT INTO escritor (apellidos, nombre) VALUES ('CASTELLANOS','ROSARIO'); -- aquí si se puede cambiar el orden para insertar

-- hacer varias inserciones en una sola instrucción 
INSERT INTO escritor (id_escritor, nombre, apellidos) VALUES
(NULL, 'JOSE EMILIO', 'PACHECO'), (NULL, 'LAURA', 'ESQUIVEL'),
(100, 'ALFONSO', 'REYES'), (NULL, 'NORMA', 'ALARCON'), (NULL, 'ISAAC', 'ASIMOV');
-- insertar con clausula SET
INSERT INTO escritor SET nombre = 'GABRIEL', apellidos = 'GARCIA MARQUEZ';

desc poeta; 
select * from poeta;
-- ingresar datos con un SELECT 
INSERT INTO poeta(id_poeta, nombre, apellidos, alias) -- lista de campos a llenar
select id_escritor, nombre, apellidos, alias from escritor; -- que campos se van a seleccionar

select * from libro;
-- ver un constraint 
SELECT * FROM information_schema.TABLE_CONSTRAINTS 
WHERE information_schema.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND information_schema.TABLE_CONSTRAINTS.TABLE_SCHEMA = 'prueba2459';
-- ver todos los constraints de una BD
SELECT * FROM information_schema.TABLE_CONSTRAINTS 
WHERE information_schema.TABLE_CONSTRAINTS.TABLE_SCHEMA = 'prueba2459';

-- insertar datos a libro
select * from libro;
desc libro;
insert into libro values (null, 1, 'El laberinto de la soledad', 'Lo primero que hace Paz es analizar la identidad mexicana desde fuera del país; en Los Ángeles para ser precisos. Aquí había un grupo llamado los pachucos, específicamente en los años 50 del siglo XX.  Estos jóvenes mexicanos querían ser diferentes a su origen y a la cultura adoptada. De acuerdo con nuestro autor, el pachuco lo que quería era sobresalir en este país.');
-- insertar varios libros en distintos autores
insert into libro values (null, 1, 'Piedra del sol',NULL), (null, 1, 'La llama doble',NULL), (null, 102, 'Fundacion',NULL), (null, 1, 'La rama',NULL), (null, 103, 'Cien años de soledad',NULL), (null, 103, 'El coronel no tiene quien le escriba',NULL);

-- NIETO LICONA VICTOR MANUEL
select * from escritor;
select * from poeta;
select * from libro; 

insert into libro values (null, 1000, 'Diablo guardian', NULL); -- error de integridad

-- actualizar sin filtro (no se debe de hacer porque cambia todo)
update escritor set direccion = 'MEX';

-- activando integridad referencial (cascade)
update escritor set id_escritor = id_escritor + 1000;

-- haciendo uso de ON DELETE para evitar borrar datos que tienen hijos y con esto crear basura
delete from escritor where id_escritor = '1102';