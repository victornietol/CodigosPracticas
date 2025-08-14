-- LOGS

-- Registros que se generan en las transacciones o eventos que ocurren dentro del sistema de gestion de bases de datos (SGBD)
-- Ruta para la consola de comandos c:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p

use mysql;
show tables;
select * from user; -- ver los users

-- Para ver los logs
select * from general_log;

-- encender los logs
set global general_log = 'on';
set global log_output = 'table';

-- Prueba de insertando en una tabla
use tarea1_bd;
select * from miembro;
INSERT INTO miembro(nombre,ap_paterno,ap_materno,adeudo,anio_nacimiento) VALUES ('Pedro', 'Hernandez', 'Salgado', 200.5, '2002-12-11');
-- update miembro set adeudo = 200.5 where id_miembro = 18;



-- COMMIT 
-- Cuando una serie de operaciones SQL se agrupan en una transaccion, la sentencia COMMIT se utiliza para confirmar esas operaciones y hacer que las operaciones se hagan permanentes en la BD
-- Verificar si el autocommit esta activo:
SELECT @@autocommit;
-- Desactivar el autocommit
SET autocommit = 0;

-- ROOLLBACK
-- Regresa el estado a uno anterior a un commit, antes de que se realizara la transaccion

-- TAREA. Procedimiento almacenado que recibe n cantidad de usuarios, que vaya seccionando cada usuario y lo inserte (cada usuario separado por comas), hacer commit cada 3 usuarios. 10 usuarios por cada llamada del procedimiento, (en total deben ser 31 usuarios)
