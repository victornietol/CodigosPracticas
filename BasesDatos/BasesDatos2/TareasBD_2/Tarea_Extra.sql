/*
-- Clase 13/03/2024

Ejercicio.
	1. Crear una tabla "administrador" deonde lo podamos asignar a una biblioteca.
    2. Hacer un procedimiento almacenado que: 
		- Que tome el nombre y ap paterno (las primeras 2 letras c/u), los concatene y genere un usuario de la base de datos (solo tablas libros y sus prestamos, solo los puede leer) (de miembro biblbioteca)
        - Que tome el nombre y ap paterno y ap materno (las 2 primeras letras de c/u), lo concatene y genere un usuario para la BD (el puede ver todas las tablas y actualizarlas) (de la nueva tabla)

*/

use tarea1_bd;

drop table if exists biblioteca;
create table if not exists biblioteca(
	id_biblioteca int not null auto_increment,
    nombre varchar(70),
    calle varchar(50),
    colonia varchar(50),
    delegacion varchar(50),
    primary key(id_biblioteca)
);

-- 1. Tabla Administrador
drop table if exists administrador;
create table if not exists administrador(
	id_administrador int not null auto_increment,
    nombre varchar(50) not null,
    ap_pat varchar(50) not null,
    ap_mat varchar(50) not null,
    biblioteca varchar(70) not null,
    nombre_usuario varchar(70) not null,
    fecha_modificacion date not null,
    primary key (id_administrador)
);

delimiter //
drop trigger if exists registro_insert_administrador //
create trigger registro_insert_administrador
before insert on administrador
for each row
begin
	set new.nombre_usuario = user();
    set new.fecha_modificacion = curdate();
end; //
delimiter ;


-- 2. Procedimientos almacenados
delimiter //
drop procedure if exists crear_user_MBib //
create procedure crear_user_MBib()
begin
	declare c_nombre varchar(70);
    declare c_ap_pat varchar(70);
    declare pass varchar(15) default '123456';
    declare c_final int default 0;
    
    -- Cursor
    declare cur cursor for
    select nombre,ap_paterno
    from miembro;
    
    -- Variable para controlar el final de las iteraciones
    declare continue handler for not found set c_final = 1;
    
    -- Abrir cursor
    open cur;
    
    -- Bucle para iterar cada registro de la tabla
    bucle: loop
		fetch cur into c_nombre,c_ap_pat;
        
        if c_final = 1 then
			leave bucle;
		end if;
        
		select concat('create user ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),'''','@''localhost'' identified by ''',pass,''';') as Consultas_MB
        union
        select concat('GRANT select ON tarea1_bd.libros TO ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),'''','@''localhost'';')
        union
        select concat('GRANT select ON tarea1_bd.prestamos TO ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),'''','@''localhost'';');
        
        /*
        -- Crear usuario
        set @consulta = concat('create user ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),'''','@''localhost'' identified by ''',pass,''';');
		prepare stmt from @consulta;
		execute stmt;
		deallocate prepare stmt;
        
        -- Asignar privilegios
        set @consulta = concat('GRANT select ON tarea1_bd.libros TO ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),'''','@''localhost'';');
		prepare stmt from @consulta;
		execute stmt;
		deallocate prepare stmt;
        
        set @consulta = concat('GRANT select ON tarea1_bd.prestamos TO ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),'''','@''localhost'';');
		prepare stmt from @consulta;
		execute stmt;
		deallocate prepare stmt;
        */
        
    end loop bucle;
end //
delimiter ;

call crear_user_MBib();



delimiter //
drop procedure if exists crear_user_adminis //
create procedure crear_user_adminis()
begin
	declare c_nombre varchar(70);
    declare c_ap_pat varchar(70);
    declare c_ap_mat varchar(70);
    declare pass varchar(15) default '123456';
    declare c_final int default 0;
    
    -- Cursor
    declare cur cursor for
    select nombre,ap_pat,ap_mat
    from administrador;
    
    -- Variable para controlar el final de las iteraciones
    declare continue handler for not found set c_final = 1;
    
    -- Abrir cursor
    open cur;
    
    -- Bucle para iterar cada registro de la tabla
    bucle: loop
		fetch cur into c_nombre,c_ap_pat,c_ap_mat;
        
        if c_final = 1 then
			leave bucle;
		end if;
        
		select concat('create user ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),lower(left(c_ap_mat,2)),'''','@''localhost'' identified by ''',pass,''';') as Consultas_Admin
        union
        select concat('GRANT select ON tarea1_bd.* TO ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),lower(left(c_ap_mat,2)),'''','@''localhost'';')
        union
        select concat('GRANT update ON tarea1_bd.* TO ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),lower(left(c_ap_mat,2)),'''','@''localhost'';')
        union
        select concat('GRANT alter ON tarea1_bd.* TO ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),lower(left(c_ap_mat,2)),'''','@''localhost'';');
        
        /*
        -- Crear usuario
        set @consulta = concat('create user ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),lower(left(c_ap_mat,2)),'''','@''localhost'' identified by ''',pass,''';');
		prepare stmt from @consulta;
		execute stmt;
		deallocate prepare stmt;
        
        -- Asignar privilegios
        set @consulta = concat('GRANT select ON tarea1_bd.* TO ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),lower(left(c_ap_mat,2)),'''','@''localhost'';');
		prepare stmt from @consulta;
		execute stmt;
		deallocate prepare stmt;
        
        set @consulta = concat('GRANT update ON tarea1_bd.* TO ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),lower(left(c_ap_mat,2)),'''','@''localhost'';');
		prepare stmt from @consulta;
		execute stmt;
		deallocate prepare stmt;
        
        set @consulta = concat('GRANT alter ON tarea1_bd.* TO ','''',lower(left(c_nombre,2)),lower(left(c_ap_pat,2)),lower(left(c_ap_mat,2)),'''','@''localhost'';');
		prepare stmt from @consulta;
		execute stmt;
		deallocate prepare stmt;
        */
        
    end loop bucle;
end //
delimiter ;

call crear_user_adminis();


