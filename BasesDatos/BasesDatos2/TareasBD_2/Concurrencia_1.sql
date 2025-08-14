-- CONCURRENCIA

-- Tipos de concurrencia

-- Lecturas sucias. Se leen datos de una transaccion que no esta confirmada
-- Lecturas no repetibles. Cuando un usuario lee los mismos datos varias veces pero encuentra valores diferentes.
-- Lecturas fantasma. Un usuario obtiene un conjunto de datos ...
-- Actualizaciones perdidas. Las transacciones de escritura simultaneas sobreescriben los cambios de las demás sin tener en cuenta las disputas

-- Tecnicas para control de concurrencia

-- Bloqueo. Se bloquea el acceso a la base de datos mientras otro usuario o programa esta interactuando con la base, hasta que se deja de usar por ese usuario se libera la base. (Bloqueo exclusivo, etc)
-- Basado en marcas de tiempo. Se ejecutan los programas que acceden a la base en horarios distintos y se deben de acomodar dependiendo de la prioridad del programa.

-- Control de concurrencia optimista (OCC). Hace un resumen de todo lo que estuvo bien y lo ejecuta. No se hace durante el dia.
-- Control de concurrencia de múltiples versiones (MVCC). 

-- EJERCICIO. Hacer procedimiento almacenado que seleccione (la tabla que ya actualizamos) y lea uno a uno cada registro

use tarea1_bd;

delimiter //
drop procedure if exists leer_reg //
create procedure leer_reg()
begin
	declare c_id int;
    declare c_nombre varchar(70);
    declare c_ap_paterno varchar(45);
    declare c_ap_materno varchar(45);
    declare c_adeudo float;
    declare c_anio_nac date;
    declare c_nombre_usu varchar(70);
    declare c_fecha_mod date;
    declare c_final int default 0; -- Variable para llevar el control de las iteraciones
    
    -- Declaracion del cursor para recorrer registros de la tabla origen
    declare cur cursor for 
    select id_miembro,nombre,ap_paterno,ap_materno,adeudo,anio_nacimiento,nombre_usuario,fecha_modificacion 
    from miembro;
    
    -- Variable para controlar el final de las iteraciones
    declare continue handler for not found set c_final = 1;
    
    -- Se abre el cursor
    open cur;
    
    -- Se genera el bucle para iterar y hacer las inserciones con el cursor
    bucle: loop
		fetch cur into c_id,c_nombre,c_ap_paterno,c_ap_materno,c_adeudo,c_anio_nac,c_nombre_usu,c_fecha_mod;
        if c_final = 1 then
			leave bucle;
		end if;
        select c_id,c_nombre,c_ap_paterno,c_ap_materno,c_adeudo,c_anio_nac,c_nombre_usu,c_fecha_mod;
    end loop bucle;
    
end //
delimiter ;



call leer_reg();