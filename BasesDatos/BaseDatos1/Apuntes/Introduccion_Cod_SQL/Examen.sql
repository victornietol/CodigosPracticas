use colegio_examen;

select * from alumno_salon;
select * from alumnos;
select * from cursos;
select * from estados;
select * from evaluaciones;
select * from grados;
select * from materias;
select * from niveles;
select * from pagos;
select * from profesor_grupo;
select * from profesores;
select * from salones;




select * from pagos 
where (select clave_alu from alumnos a join pagos pa using (clave_alu) where pago > 30000);


create unique index uk_clave_mat_curso on evaluaciones(clave_alu,id_curso,clave_mat);

-- 7.
select * from evaluaciones;
alter table evaluaciones add unique index UQ_alumno_curso_salon(clave_alu, id_curso, id_salon);
create unique index UQ_alumno_curso_salon on evaluaciones(clave_alu, id_curso, id_salon);
show index from evaluaciones;


select *, min(calificacion) from evaluaciones
where clave_alu = (select distinct clave_alu from evaluaciones);

-- select *, min(calificacion) 
-- join(select distinct clave_alu from evaluaciones) x

-- select x.alumno, calificacion;

select a.clave_alu clave, concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, 
e.calificacion calificacion, m.nombre materia, c.nombre curso, s.observaciones salon
from evaluaciones e 
JOIN alumnos a ON(e.clave_alu = a.clave_alu)
JOIN materias m ON(e.clave_mat = m.clave_mat)
JOIN cursos c ON (e.id_curso = c.id_curso)
JOIN salones s ON (e.id_salon = s.id_salon)
where e.calificacion is not null 
order by 2, 3 desc;




select clave, alumno, min(calificacion) calificacion from(		-- Respuesta correcta
select a.clave_alu clave, concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, 
e.calificacion calificacion, m.nombre materia, c.nombre curso, s.observaciones salon
from evaluaciones e 
JOIN alumnos a ON(e.clave_alu = a.clave_alu)
JOIN materias m ON(e.clave_mat = m.clave_mat)
JOIN cursos c ON (e.id_curso = c.id_curso)
JOIN salones s ON (e.id_salon = s.id_salon)
where e.calificacion is not null 
order by 2, 3 desc) d
group by clave;

select * from evaluaciones where clave_alu = 11070075

-- 6.
select distinct fedita, 
concat(extract(year from fedita),'-',
extract(month from fedita),'-',
extract(day from fedita),' ',
date_add(fedita, interval -6 hour),':',
extract(minute from fedita),':',
date_add(extract(second from fedita), interval -18 second)) n_fecha  from alumnos;

select distinct fedita, date_add(fedita, interval -21618 second) n_fecha from alumnos; 

select extract(minute from now())

select sysdate(), date_add(sysdate(), interval 1 day) nueva_fecha;
-- 5.
select * from pagos;

-- 4. 
select * from alumnos a join pagos p on (a.clave_alu = p.clave_alu)
where p.clave_alu not in
(select al.clave_alu from alumnos al join estados e on (al.id_estado = e.id_estado) where e.estado ='queretaro');


select distinct clave_alu, day(fecha_pago) dia, date_format(fecha_pago, '%M') mes from
(select p.clave_alu, p.fecha_pago from alumnos a join pagos p on (a.clave_alu = p.clave_alu)
where p.clave_alu not in
(select al.clave_alu from alumnos al 
join estados e on (al.id_estado = e.id_estado) where e.estado ='queretaro')) x



select concat(a_paterno, ap_materno, nombre) alumno,  
timestampdiff(year, '1997-03-03', now() anios, 
tipo
-- from (select clave_alu, if(length(curp) < 18, null,
concat(
if( mid(curp, 5, 2) <= 22, '20', '19'),mid(curp, 5, 2), '-',
	mid(curp, 7, 2), '-', mid(curp, 9, 2) ) ) fnac
from alumnos);

select extract(year from now())

select timestampdiff(year, '1997-03-03', now()) aniosdif;

select x.clave_alu, 
timestampdiff(year, x.fnac, now()) anios, 
if(timestampdiff(year, x.fnac, now()) < 18, 'JOVEN', 
if(timestampdiff(year, x.fnac, now()) is null,'SIN IDENTIFICAR','ADULTO'  )) tipo
from (
select clave_alu, if(length(curp) < 18, null,
concat(
if( mid(curp, 5, 2) <= 22, '20', '19'),mid(curp, 5, 2), '-',
	mid(curp, 7, 2), '-', mid(curp, 9, 2) ) ) fnac
from alumnos) x
order by timestampdiff(year, x.fnac, now()) desc;

select x.clave_alu, 
timestampdiff(year, x.fnac, now()) anios, 
if(timestampdiff(year, x.fnac, now()) < 18, 'JOVEN', 'ADULTO'  ) tipo
from (
select clave_alu, if(length(curp) < 18, null,
concat(
if( mid(curp, 5, 2) <= 22, '20', '19'),mid(curp, 5, 2), '-',
	mid(curp, 7, 2), '-', mid(curp, 9, 2) ) ) fnac
from alumnos) x
order by timestampdiff(year, x.fnac, now()) desc;

select nombre, curp,
concat(
if( mid(curp, 5, 2) <= 22, '20', '19'),mid(curp, 5, 2), '-',
	mid(curp, 7, 2), '-', mid(curp, 9, 2) ) fnac
from alumnos
where length(curp) = 18;

select nombre, curp, if(length(curp) < 18, null,
concat(
if( mid(curp, 5, 2) <= 22, '20', '19'),mid(curp, 5, 2), '-',
	mid(curp, 7, 2), '-', mid(curp, 9, 2) ) ) fnac
from alumnos;


-- 3
-- sexo 11 posicion

update alumnos set sexo = mid(curp,11,1) 
where sexo =' ' and length(curp) = 18;

-- where (select clave_alu from alumnos where sexo = ' ' and length(curp) = 18) = clave_alu;


select clave_alu from alumnos where sexo = ' ' and length(curp) = 18;



-- 2.
select * from alumnos
where clave_alu not in (
select distinct a.clave_alu from alumnos a join pagos p on (a.clave_alu = p.clave_alu)
where date_format(p.fecha_pago, '%M') = 'febrero');

select date_format(sysdate(), '%M')
-- 1.
set lc_time_names = 'es_Mx';
drop table if exists pivote;
create table pivote
select d.dia dia, count(*) npagos from
(select date_format(fecha_pago, '%W') dia from pagos where year(fecha_pago) = 2018) d
group by 1
order by 2 desc;

select * from pivote;