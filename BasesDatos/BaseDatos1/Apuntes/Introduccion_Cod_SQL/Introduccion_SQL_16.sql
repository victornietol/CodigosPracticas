use colegio2459;

-- Funciones definidas por el usuario

	-- Ver las funciones que hay en la BD
show function status where Db = 'colegio2459';

-- Creando funcion para obtener el promedio de algun alumno
delimiter //
DROP FUNCTION IF EXISTS promedio_alumno //
create function promedio_alumno(matricula varchar(10), curso varchar(5))
returns decimal(10,2)
reads sql data 
deterministic
begin
	declare nmat int;
    declare suma_calif float;
    declare promedio float;
    
    select count(e.clave_mat) into nmat
    from evaluaciones e join  materias m using(clave_mat)
    where e.clave_alu = matricula and e.id_curso = curso and promedia = 1;
    
    select sum(calificacion) into suma_calif
    from evaluaciones where clave_alu = matricula and id_curso = curso;
    
    set promedio = format(suma_calif / nmat, 2);
    return promedio;
end //
delimiter ;

-- usando funcion
select clave_alu, concat_ws(' ', ap_paterno, ap_materno, nombre) alumno,
promedio_alumno(clave_alu, 'C012') promedio
from alumnos;

-- otro ejemplo
select promedio_alumno('11050210', 'C012') promedio;  -- llamando la funcion sin usar un from

-- V2 la funcion promedio_alumno
delimiter //
DROP FUNCTION IF EXISTS promedio_alumno //
create function promedio_alumno(matricula varchar(10), curso varchar(5))
returns decimal(10,2)
reads sql data 
deterministic
begin
    declare promedio float;
    
    select format(avg(calificacion),2) into promedio -- ahora se usa AVG para obtener el promedio
    from evaluaciones where clave_alu = matricula and id_curso = curso;
    
    return promedio;
end //
delimiter ;

-- probando la funcion. Mostrando el promedio de los alumnos de todos los cursos
select a.clave_alu, concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno,
c.nombre curso, abreviatura,
promedio_alumno(a.clave_alu, sa.id_curso) promedio
from alumnos a JOIN alumno_salon sa ON(a.clave_alu = sa.clave_alu)
JOIN cursos c ON (sa.id_curso = c.id_curso)
order by alumno;

-- creando vista con la consulta anterior
create or replace view alumnos_promedio as
select a.clave_alu, concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno,
c.nombre curso, abreviatura,
promedio_alumno(a.clave_alu, sa.id_curso) promedio
from alumnos a JOIN alumno_salon sa ON(a.clave_alu = sa.clave_alu)
JOIN cursos c ON (sa.id_curso = c.id_curso);

select * from alumnos_promedio order by alumno; -- ordenando despues de la vista porque dentro la vista no se puede ordenar