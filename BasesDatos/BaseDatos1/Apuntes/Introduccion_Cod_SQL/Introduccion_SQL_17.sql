-- Procedimientos almacenados

-- ver los esquemas
select routine_name, routine_type,definer,created,security_type,SQL_Data_Access 
from information_schema.routines  -- <== esta parte nos muestra las rutinas generales y tambien las funciones
where routine_type='PROCEDURE' and 
routine_schema= 'colegio2459';    -- <== indicar la base


-- creacion
delimiter //
drop procedure if exists listar_alumno //
create procedure listar_alumnos(in matricula varchar(20))
begin
	select * from alumnos where clave_alu = matricula;
end //
delimiter ;

-- para usar el procedimiento se tiene que usar CALL. (Lo generado no es una vista, sino un procedimiento almacenado en la base)
CALL listar_alumnos('11070116')


-- otro procedimiento
delimiter //
drop procedure if exists datos_alumno //
create procedure datos_alumnos(in tipoconsulta int, in matricula varchar(20))
begin
	set @q = concat('select * from alumnos where clave_alu =', matricula);
    if tipoconsulta = 1 then
		set @q = concat('select * from alumnos where clave_alu =', matricula);
	end if;
    if tipoconsulta = 2 then
		set @q = concat('select * from pagos where clave_alu =', matricula);
	end if;
    if tipoconsulta = 3 then
		set @q = concat('select * from evaluaciones where clave_alu =', matricula);
	end if;
    prepare stmt from @q;  -- <== prepara la consulta (o lo que se tenga) (en este caso es una consulta)
    execute stmt;			-- <== executa la sentencia 
    deallocate prepare stmt;	-- <== enviar lo que genero la sentencia
end //
delimiter ;

-- probando la sentencia . (va a mostrar diferentes cosas dependiendo del valor de la primera variable). (la vista generada (realmente no es una vista) ahora se llama record set y tiene cursores que permiten recorrer el renglon de la informacion mostrada)
CALL datos_alumnos(1,'11070116');
CALL datos_alumnos(2,'11070116');
CALL datos_alumnos(3,'11070116');

-- otro procedimiento
-- creacion
delimiter //
drop procedure if exists lista_correo_alumno //
create procedure lista_correo_alumnos(inout listamail text)
begin
	declare terminado int default 0;
    declare direccion_email varchar(150) default '';
    
    -- declaramos el cursor
    declare cursor_email cursor for 
		select email from alumnos where email like '%@%.%';  -- <== '%@%.%' es para encontrar los correos validos
	
    -- declaramos el handler para terminar de recorrer el cursor
    declare continue handler for not found   -- <== indica que se detenga cuando llegue al final del archivo
		set terminado = 1;
        
	-- ahora si se ejecuta el cursor (aqui se abre el cursor)
    open cursor_email;  -- <== todavia no recorre los datos
    
    -- recorriendo el cursor
    leerEmail: loop		-- Es como si fuera un for, o un while
		fetch cursor_email into direccion_email;	-- <== almacena el valor 
        if terminado = 1 then
			leave leerEmail;	-- <== es como si fuera un BREAK
		end if;
        set listamail = concat('<', upper(direccion_email), '>', ';', listamail); -- <== el UPPER solo es para mostrar que se pueden manipular los datos que contenga direccion_email. Lo generado con esto no modifica los datos que realmente estan guardados en la BD, por lo tanto, solo es una modificacion externa para los datos de salida que se generan
    end loop leerEmail;
    
    close cursor_email; 	-- <== cerrar el cursor
end //
delimiter ;

-- probando el procedimiento
set @lista ='';
call lista_correo_alumnos(@lista);
select @lista;