-- Trigger

use colegio2459;

-- ver triggers de la BD
select TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE, ACTION_STATEMENT
FROM  INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA = 'colegio2459';

-- generar un TRIGGER
select * from cursos;

	-- cambiar el delimitador para poder generar el trigger (esto se hace porque ya no se debe usar ; para separar cada operacion)
    delimiter // 
    drop trigger if exists bi_cursos // 
    
    -- ahora si se empieza a crear el trigger
    create trigger bi_cursos
    before insert on cursos
    for each row
    begin    	-- aqui comienza lo que hace el trigger
		if(left(new.nombre, 5) <> 'curso') then
			set new.nombre = concat('curso ', new.nombre);
		end if;
        set new.nombre = upper(new.nombre);
        set new.abreviatura = upper(new.abreviatura);
    end; //
    delimiter ; -- regresando el delimitador
    
-- haciendo insercion para probar el trigger
    insert into cursos values 
	('C100', 'escolar 2019-2020', 'cur19-20', '2019-08-01', '2019-01-01'),
	('C200', 'curso escolar 2020-2021', 'cur20-21', '2020-08-01', '2021-01-01');

-- version 2 del trigger, agregando validacion de fechas
 delimiter // 
    drop trigger if exists bi_cursos // 
    create trigger bi_cursos
    before insert on cursos
    for each row
    begin    	
		if(left(new.nombre, 5) <> 'curso') then
			set new.nombre = concat('curso ', new.nombre);
		end if;
        set new.nombre = upper(new.nombre);
        set new.abreviatura = upper(new.abreviatura);
        if(new.ffin <= new.finicio) then
			signal sqlstate'45000'				-- esto significa que va a marcar un error si se pone una fecha invalida
            set message_text = 'Fecha final fuera de rango';
        end if;
    end; //
    delimiter ; -- regresando el delimitador
    
    -- probando el trigger
	insert into cursos values 
	('C300', 'escolar 2021-2022', 'cur21-22', '2019-08-01', '2019-01-01'),  -- no deja insertar porque la fecha final esta fuera de rango
	('C400', 'curso escolar 2022-2023', 'cur22-23', '2020-08-01', '2021-01-01');

	-- probando trigger pero con datos correctos
    insert into cursos values 
	('C300', 'escolar 2021-2022', 'cur21-22', '2019-08-01', '2020-01-01'),
	('C400', 'curso escolar 2022-2023', 'cur22-23', '2020-08-01', '2021-01-01');

-- Hacer una bitacora para llevar un registro de la BD
drop table if exists bitacora;
create table bitacora(
	id int not null auto_increment primary key,
    fecha datetime not null,
    usuario varchar(50) not null,
    tabla varchar(50) not null,
    sentencia varchar(50) not null,
    accion text null
);

select * from bitacora;
	
    -- HACIENDO otro trigger
    delimiter // 
    drop trigger if exists ad_cursos // 
    
    create trigger ad_cursos
    after delete on cursos
    for each row
    begin    	-- trigger para guardar los datos de las eliminaciones que se hagan en la tabla (trigger delete, solo puede ver old.<campo>)
		INSERT INTO bitacora VALUES 
		(null, sysdate(), user(), 'cursos', 'delete',
		JSON_OBJECT('id_curso',old.id_curso , 'nombre',old.nombre , 'abreviatura',old.abreviatura, 'finicio', old.finicio, 'ffin', old.ffin));

    end; //
    delimiter ;
    
    -- probando trigger
    select * from bitacora;
    select * from cursos;
    
    delete from cursos where id_curso >= 'C100';