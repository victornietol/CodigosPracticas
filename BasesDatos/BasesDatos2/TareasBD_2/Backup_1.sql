-- RESPALDO

-- Backup de linea de comando en mysql
-- Es el que contendrá el respaldo completo tanto de estructura como en datospero lo debemos de hacer desde linea de comandos

-- Comando para llegar al directorio de los comandos de MySQL

-- cd C:\
-- cd Program Files
-- cd MySQL
-- cd (SELECCIONAR MySQL Server)
-- cd bin

-- Comando mysqldump -u [username] -p [database_name] [tbl_name...] > [backup_name].sql
-- Ejemplo: mysqldump -u root -p tarea1_bd > C:\Users\nieto\Downloads\backupTarea1bd.sql


-- RECUPERACION

-- En el mismo directorio del ejemplo anterior  ejecutar:
-- mysql -u [username] -p [backup_name].sql
-- ejemplo: mysql -u root -p tarea1_bd < C:\Users\nieto\Downloads\backupTarea1bd.sql
-- * Hay que crear la base de nuevo que se quiera regenerar: ejemplo -> create database [nombre]


-- FALLAS DE TRANSACCION

-- 	   *Buscar codigos de errores de MySQL para conocer que errores se pueden generar
--  Las transacciones son una forma de programacion dentro de las bases

-- TAREA

use tarea1_bd;

-- Trigger para que cada vez que haya un insert se guarde el usuario que realizo el cambio y la fecha
delimiter //
drop trigger if exists registro_insert //
create trigger registro_insert
before insert on miembro
for each row
begin
	set new.nombre_usuario = user();
    set new.fecha_modificacion = curdate();
end; //
delimiter ;

-- Probando el trigger
-- select * from miembro;
-- INSERT INTO miembro(nombre,ap_paterno,ap_materno,adeudo,anio_nacimiento) VALUES ('Omar Jose', 'Hernandez', 'Salgado', 103.34, '2002-12-11');


create table if not exists miembro_respaldo like miembro;

delimiter //
drop procedure if exists insert_miembro //
create procedure insert_miembro(
	in v_id_miembro int,
    in v_nombre varchar(70),
    in v_ap_paterno varchar(45),
    in v_ap_materno varchar(45),
    in v_adeudo float,
    in v_anio_nacimiento date,
    in v_nombre_usuario varchar(70),
    in v_fecha_modificacion date
)
begin
    declare duplicate_key condition for sqlstate '23000';
    declare continue handler for duplicate_key
    begin
		select 'El usuario ya existe' as Mensaje;
    end;
    insert into miembro_respaldo(id_miembro,nombre,ap_paterno,ap_materno,adeudo,anio_nacimiento,nombre_usuario,fecha_modificacion ) values (v_id_miembro,v_nombre,v_ap_paterno,v_ap_materno,v_adeudo,v_anio_nacimiento,v_nombre_usuario,v_fecha_modificacion);
end //
delimiter ;


delimiter //
drop procedure if exists respaldo_miembro //
create procedure respaldo_miembro()
begin
	-- Variables del cursor
    declare v_id int;
    declare v_nombre varchar(70);
    declare v_ap_paterno varchar(45);
    declare v_ap_materno varchar(45);
    declare v_adeudo float;
    declare v_anio_nac date;
    declare v_nombre_usu varchar(70);
    declare v_fecha_mod date;
    declare v_final int default 0;
    
    -- Declaracion del cursor para recorrer registros de la tabla origen
    declare cur cursor for 
    select id_miembro,nombre,ap_paterno,ap_materno,adeudo,anio_nacimiento,nombre_usuario,fecha_modificacion 
    from miembro where fecha_modificacion = curdate();
    
    -- Variable para controlar el final de las iteraciones
    declare continue handler for not found set v_final = 1;
    
    -- Se abre el cursor
    open cur;
    
    -- Se genera el bucle para iterar y hacer las inserciones con el cursor
    bucle: loop
		fetch cur into v_id,v_nombre,v_ap_paterno,v_ap_materno,v_adeudo,v_anio_nac,v_nombre_usu,v_fecha_mod;
        if v_final = 1 then
			leave bucle;
		end if;
        call insert_miembro(v_id,v_nombre,v_ap_paterno,v_ap_materno,v_adeudo,v_anio_nac,v_nombre_usu,v_fecha_mod);
    end loop bucle;
    
end //
delimiter ;

call respaldo_miembro();
select * from miembro_respaldo;