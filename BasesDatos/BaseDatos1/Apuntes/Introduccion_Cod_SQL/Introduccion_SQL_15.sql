use colegio2459;
select * from bitacora;

-- Trigger UPDATE

select TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE, ACTION_STATEMENT, trigger_schema
FROM  INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA = 'colegio2459';

-- creando trigger

delimiter // 
drop trigger if exists bu_cursos // 
    
create trigger bu_cursos
before update on cursos
for each row
begin   
	declare caso varchar(10) default 'caso 0'; 	-- declarando variable
	if(new.ffin < old.ffin) then 		-- validando la fecha que se introduce
		set new.ffin = old.ffin;
        set caso = 'caso 1';
	elseif(new.ffin <= old.finicio) then
		set new.ffin = date_add(old.finicio, interval 1 year);
        set caso = 'caso 2';
	elseif(new.ffin <= new.finicio) then
		set new.ffin = date_add(new.finicio, interval 1 year);
        set caso = 'caso 3';
	end if;
    
    set new.nombre = upper(new.nombre);		-- poniendo todo en mayusculas
    set new.abreviatura = upper(new.abreviatura);
    
	INSERT INTO bitacora VALUES 
	(null, sysdate(), user(), 'cursos', 'update',
	JSON_OBJECT('caso', caso,'old_id_curso',old.id_curso , 'old_nombre',old.nombre , 'old_abreviatura',old.abreviatura, 'old_finicio', old.finicio, 'old_ffin', old.ffin,
    'new_id_curso',new.id_curso , 'new_nombre',new.nombre , 'new_abreviatura',new.abreviatura, 'new_finicio', new.finicio, 'new_ffin', new.ffin));

end; //
delimiter ;

-- probando trigger
select * from cursos;
select * from bitacora;

insert into cursos values 
('C100', 'escolar 20219-2020', 'cur19-20', '2019-08-01', '2020-01-01'),
('C200', 'curso escolar 2020-2021', 'cur20-21', '2020-08-01', '2021-01-01'),
('C300', 'escolar 2021-2022', 'cur21-22', '2021-08-01', '2022-10-01'),
('C400', 'curso escolar 2022-2023', 'cur22-23', '2022-08-01', '2023-01-01');

update cursos set ffin = '2019-01-01 00:00:00', nombre = 'ciclo escolar 2019-2020', abreviatura = 'CIE19-20' where id_curso = 'C100';

update cursos set ffin = '2019-12-31 00:00:00' where id_curso = 'C200';

update cursos set ffin = '2020-10-01 00:00:00', finicio = '2021-06-01 00:00:00' where id_curso = 'C300';


-- Funciones definidas por el usuario

delimiter // 
drop function if exists saludo //

create function saludo(str varchar(50))
returns varchar(80)
deterministic		-- indica que siempre va a funcionar igual
begin
	declare result varchar(80) default '';
    declare hora varchar(80) default '';
    set hora = date_format(sysdate(), '%H');
    case			-- usando CASE para determinar el caso
		when hora between 5 and 11 then set result = concat('Buenos dias ', str);
        when hora between 12 and 18 then set result = concat('Buenos tardes ', str);
        when hora between 19 and 23 then set result = concat('Buenos noches ', str);
        else set result = concat('Hola ', str);
	end case;
    return result;
end //
delimiter ;

show function status;

-- probando la funcion

select saludo('patito 23');
select distinct saludo(nombre) from alumnos;