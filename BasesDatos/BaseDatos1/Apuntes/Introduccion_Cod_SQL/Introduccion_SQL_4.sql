use prueba2459;
show tables;

select * from poeta;

-- Utilizando ON DUPLICATE KEY para escribir un nuevo registro con una llave existente, y asignarle una nueva llave al registro que ya existia (parecido a recorrer un lugar el registro que 
-- ya se encontraba anteriormente e insertar el nuevo antes)
insert into poeta (id_poeta, nombre, apellidos)  -- <== aquí no permite la operación porque detecta que ya existe esa llave
 values (103, 'ALBERTO', 'CORONA');
 
insert into poeta (id_poeta, nombre, apellidos)  -- <== aquí si permite la operación porque se le esta asignando una nueva llave al registro que ya existía
 values (103, 'ALBERTO', 'CORONA')
ON DUPLICATE KEY UPDATE id_poeta = id_poeta + 10; -- <== aquí se indica como se va a modificar

-- Reemplazar valores ya existentes sin usar WHERE (ahora utilizando REPLACE)
REPLACE INTO poeta (id_poeta, nombre, apellidos) -- se indica el registro que se va a reemplazar con la PK (id_poeta), y despues vienen los campos que se van a afectar
values (103, 'JOSE ALBERTO', 'CORONA REYES'); 
-- Reemplazando varios valores
REPLACE INTO poeta (id_poeta, nombre, apellidos)
values (103, 'JOSE ALBERTO', 'CORONA REYES'),
(101, 'NORMA ANGELICA', 'ALARCON DIAZ');

select * from escritor;
-- Carga masiva del contenido de un archivo en una tabla. El comando es LOAD DATA. LOCAL indica que el archivo esta en la misma máquina.
LOAD DATA LOCAL INFILE 'D:\\MySQL Pruebas\\Archivos con datos\\escritores.csv' 
INTO TABLE escritor  -- <== indica en que tabla
FIELDS TERMINATED BY ','  -- <== indica el caracter que separa los campos (en que terminan)
ENCLOSED BY ''    -- <== indica como estan encerrados los campos, por ejemplo, si los campos estan entre comillas (en este caso no estan entre comillas por eso va vacio)
LINES TERMINATED BY '\n'   -- <== indica que las lineas terminan en saldo de linea
IGNORE 1 LINES;   -- <== indica que se ignore la primera linea (en este caso correspondiente a la cabezara del archivo csv)

	-- verificar que se tenga activada la opcion de cargar archivos, activar la opcion
	SHOW GLOBAL VARIABLES LIKE 'local_infile';
	SET GLOBAL local_infile=1;
    
-- Eliminar todo un renglon (DELETE), *cuidado porque puede borrar toda la tabla si se omite la clausula WHERE
DELETE FROM escritor WHERE id_escritor = 1104;
	-- eliminar más elementos con una condición
select * from escritor WHERE id_escritor >= 1120; -- <== esto sólo es para verificar que si son los datos que se quieren borrar
DELETE FROM escritor WHERE id_escritor >= 1120;  -- <== aquí si se realiza el borrado 
-- eliminar por dirección
DELETE FROM escritor WHERE direccion = 'MX';
-- eliminar con varios condicionantes
DELETE FROM escritor
WHERE id_escritor >= 1120 AND direccion <> 'MX'; --  <> <== significa diferente de (en python es !=)

select * from escritor;
-- utilizando UPDATE para cambiar datos de la tabla
UPDATE escritor SET nombre = UPPER(nombre)  -- <== cambiando a mayusculas con UPPER
where id_escritor >= 1140;

UPDATE escritor SET direccion = 'CDMX', apellidos = upper(apellidos)  -- los campos a cambiar se separan por comas
where id_escritor >= 1135 AND id_escritor <= 1139;