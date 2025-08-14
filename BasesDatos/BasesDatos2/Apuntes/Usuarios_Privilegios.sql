/*
CREACION DE USUARIOS Y ASIGNACION DE PERMISOS

SQL :
Categorias de lenguaje dentro de SQL
	- DCL
    - DML
    - DDL
    - TCL
    
    
DCL: Se dedica a la administracion de los usuarios

	- Revoke
    - Grant
    - Sys
    
	- Crear usuario (se genera a nivel sistema en mysql.user):
		create user '<nombre de usuario>' @ '<entonrno>' identified by 'pass'
			* entorno: va la ip y el puerto de donde esta trabajando (actualmente es localhost porque es local), pass es password
            
	- Otorgar privilegios al usuario
		GRANT <permisos: create, update, select, delete, grant option, o tambien se puede asigar <all privileges> > ON <la base de datos y las tablas. ejemlo: BD.Tablas, o tambien BD.*, o *.*, etc> TO 'usuario'@'entorno'
        
	- Remover privilegios al usuario
		REVOKE <permisos> ON <bases.tablas> TO 'usuario'@'entorno'
*/

-- Ver usuarios
use mysql;
select * from mysql.user;

-- Crear usuario
CREATE USER 'victornieto'@'localhost' IDENTIFIED BY '123456';

-- Darle privilegios al usuario
GRANT ALL PRIVILEGES ON tarea1_bd.miembro TO 'victornieto'@'localhost';

-- Remover  privilegios
REVOKE ALL PRIVILEGES ON tarea1_bd.miembro FROM 'victornieto'@'localhost';

/*
-- Ejercicio. Proceso almacenado que reciba ("nombre usuario", <tipo de permiso: admin, visual, actualizador>)
	- admin . Todos los permisos menos delete y drop
    - visual . permisos de ver
    - actualizador . permisos de ver + actualizar
    
    SHOW GRANTS FOR 'usuario'@'entorno'
*/

-- Proceso para crear usuario
delimiter //
drop procedure if exists crear_usuario //
create procedure crear_usuario(
	usuario varchar(15),
	tipo varchar(12),
    pass varchar(15)
)
begin
	-- declare consulta text;
    set tipo = lower(tipo);
    
    -- Crear usuario
    set @consulta = concat('create user ','''',usuario,'''','@''localhost'' identified by ''',pass,''';');
    prepare stmt from @consulta;
    execute stmt;
    deallocate prepare stmt;
    
    -- permisos
    case 
		when tipo = 'admin' then
			set @consulta = concat('GRANT ALL PRIVILEGES ON tarea1_bd.* TO ','''',usuario,'''','@''localhost'';');
            prepare stmt from @consulta;
			execute stmt;
			deallocate prepare stmt;
            
            set @consulta = concat('revoke delete, drop ON tarea1_bd.* FROM ','''',usuario,'''','@localhost;');
            prepare stmt from @consulta;
			execute stmt;
			deallocate prepare stmt;
            
		when tipo = 'visual' then
			set @consulta = concat('GRANT select ON tarea1_bd.* TO ','''',usuario,'''','@''localhost'';');
            prepare stmt from @consulta;
			execute stmt;
			deallocate prepare stmt;
            
        when tipo = 'actualizador' then
			set @consulta = concat('GRANT select, update, alter ON tarea1_bd.* TO ','''',usuario,'''','@''localhost'';');
            prepare stmt from @consulta;
			execute stmt;
			deallocate prepare stmt;
    end case;
end //
delimiter ;

-- Probando el procedimiento
call crear_usuario('sebas','admin','123456');
show grants for 'sebas'@'localhost';