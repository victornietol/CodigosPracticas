-- Ejercicios de repaso  	13 / 05 / 2022
use colegio2459;

-- 1. Listar el alumno, el salon y el curso en el que esta inscrito
desc alumnos;
desc salones;
desc cursos;
desc alumno_salon;

select concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, s.observaciones salon, c.nombre curso from alumnos a, salones s, cursos c, alumno_salon alu_s
where alu_s.clave_alu = a.clave_alu and alu_s.id_curso = c.id_curso and alu_s.id_salon = s.id_salon
order by 1;

-- 2. Listar el número de materias por alumno (usar la tabla evaluaciones)
desc evaluaciones;
select * from evaluaciones;

select clave_alu, count(*) nmaterias
from evaluaciones
where clave_mat is not null
group by clave_alu
order by nmaterias desc;

select a.clave_alu, count(*) nmaterias
from evaluaciones e, alumnos a
where e.clave_alu = a.clave_alu
group by clave_alu
order by nmaterias desc;


select a.clave_alu, concat_ws(' ', a.ap_paterno, a.ap_materno, nombre) alumno, count(*) nmaterias
from alumnos a JOIN evaluaciones e ON(a.clave_alu = e.clave_alu)
where e.clave_mat is not null
group by a.clave_alu
order by nmaterias desc, concat_ws(' ', a.ap_paterno, a.ap_materno, nombre);


-- 3. Lista la clave y nombre del alumno y las calificaciones del curso activo 
desc evaluaciones;
desc alumnos;
desc cursos;
desc materias;
select * from materias;

select a.clave_alu clave, concat_ws(' ', ap_paterno, ap_materno, nombre) alumno, e.calificacion calificacion
from evaluaciones e JOIN alumnos a ON(e.clave_alu = a.clave_alu)
where e.calificacion is not null
order by 2, 3 desc;

select a.clave_alu clave, concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, 
e.calificacion calificacion, m.nombre materia
from evaluaciones e 
JOIN alumnos a ON(e.clave_alu = a.clave_alu)
JOIN materias m ON(e.clave_mat = m.clave_mat)
where e.calificacion is not null
order by 2, 3 desc;


-- 4. Listar el total de pagos por alumno por curso 
desc pagos;
desc alumnos;
desc cursos;
select * from pagos;

select c.nombre curso, concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, count(*) tpagos
from pagos p 
JOIN alumnos a ON(p.clave_alu = a.clave_alu)
JOIN cursos c ON(p.id_curso = c.id_curso)
group by a.clave_alu, c.id_curso
order by 3 desc, 2;

select c.nombre curso, concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, count(*) tpagos
from pagos p 
JOIN alumnos a ON(p.clave_alu = a.clave_alu)
JOIN cursos c ON(p.id_curso = c.id_curso)
group by concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre), c.nombre
order by 3 desc, 2;


-- 5. Listar los profesores de los salones de 2do grado (Usar Consulta anidada)
desc profesor_grupo;
desc profesores;
desc salones;
desc grados;
select * from profesores;
select * from salones;
select * from profesor_grupo;

select s.id_salon, s.id_grado, s.observaciones   -- salones de 2o grado
from salones s JOIN grados g ON (s.id_grado = g.id_grado)
where g.nombre = '2o';

select * from 		-- obteniendo los profesores de salones de 2o grado
(select s.id_salon salon, s.observaciones salon_nombre, g.nombre grado 
from salones s JOIN grados g ON (s.id_grado = g.id_grado)
where g.nombre = '2o') x 
JOIN profesor_grupo pg ON(x.salon = pg.id_salon);

select pg.clave_prof, count(*) from 		-- contando los profesores para verificar los datos
(select s.id_salon salon, s.observaciones salon_nombre, g.nombre grado 
from salones s JOIN grados g ON (s.id_grado = g.id_grado)
where g.nombre = '2o') x 
JOIN profesor_grupo pg ON(x.salon = pg.id_salon)
group by pg.clave_prof;

select p.* from			-- consulta final con todos los profesores 
(select distinct pg.clave_prof prof										
from (select s.id_salon salon, s.observaciones salon_nombre, g.nombre grado 
from salones s JOIN grados g ON (s.id_grado = g.id_grado)
where g.nombre = '2o') x 
JOIN profesor_grupo pg ON(x.salon = pg.id_salon) ) y
JOIN profesores p ON(y.prof = p.clave_prof);

select concat_ws(' ', p.apellido_p, p.apellido_m, p.nombres) profesor		-- consulta final mostrando solo los nombres
from																	 
(select distinct pg.clave_prof prof										
from (select s.id_salon salon, s.observaciones salon_nombre, g.nombre grado 
from salones s JOIN grados g ON (s.id_grado = g.id_grado)
where g.nombre = '2o') x 
JOIN profesor_grupo pg ON(x.salon = pg.id_salon) ) y
JOIN profesores p ON(y.prof = p.clave_prof)
order by 1;