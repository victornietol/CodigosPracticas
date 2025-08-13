-- PRODUCTO CARTESIANO y JOIN (join con coma) 

-- Producto cartesiano .  Multiplicación de los renglones de las tablas, y la suma de sus campos
use colegio2459;

select * from alumnos;
select * from pagos order by clave_alu;

-- identificar el producto cartesiano (contar el resultado del producto cartesiano)
select count(*)
from alumnos, pagos;

-- haciendo producto cartesiano de un solo pago con todos los alumnos
select *
from alumnos, pagos
where pagos.id = 25481;

-- JOIN
select *
from alumnos, pagos
where alumnos.clave_alu = pagos.clave_alu  -- la llave primaria debe ser igual a la llave foranea 
and pagos.id = 25481;					   -- 

select *  -- pagos de todos los alumnos
from alumnos, pagos
where alumnos.clave_alu = pagos.clave_alu
order by 1;

select *  -- pagos de un solo los alumnos
from alumnos, pagos
where alumnos.clave_alu = pagos.clave_alu
and alumnos.clave_alu = '11030172'
order by 1;

-- Ejemplo JOIN
select * from salones;
select * from grados;
select * from niveles;
select * from cursos;

select *     -- join de salones de un grado
from salones s, grados g
where s.id_grado = g.id_grado
order by 1;

select *     -- join completo . mostrando los salones y sus correspondencias
from salones s, grados g, niveles n, cursos c
where s.id_grado = g.id_grado
and s.id_nivel = n.id_nivel
and s.id_curso = c.id_curso
order by 1;

-- mostrando los datos sin repetir del JOIN  generado  
select s.id_salon, observaciones salon, tipo_grupo, g.nombre grado, -- (observaciones es el nombre del salon)
n.nombre nivel, c.nombre curso
from salones s, grados g, niveles n, cursos c
where s.id_grado = g.id_grado
and s.id_nivel = n.id_nivel
and s.id_curso = c.id_curso
order by 1;

-- salones de BACHILLERATO  (ASI DE DEBE DE BUSCAR LOS SALONES DE ALGUN GRADO)
select s.id_salon, observaciones salon, tipo_grupo, g.nombre grado, -- (observaciones es el nombre del salon)
n.nombre nivel, c.nombre curso
from salones s, grados g, niveles n, cursos c
where s.id_grado = g.id_grado
and s.id_nivel = n.id_nivel
and s.id_curso = c.id_curso
and n.nombre = 'BACHILLERATO'
order by 1;

-- salones de bachillerato y de 6o grado
select s.id_salon, observaciones salon, tipo_grupo, g.nombre grado, -- (observaciones es el nombre del salon)
n.nombre nivel, c.nombre curso
from salones s, grados g, niveles n, cursos c
where s.id_grado = g.id_grado
and s.id_nivel = n.id_nivel
and s.id_curso = c.id_curso
and n.nombre = 'BACHILLERATO' AND g.nombre = '6o'
order by 1;

-- pagos por alumno (alumnos que hecho algun pago) (y cuanto han pagado)
select a.clave_alu, concat_ws(' ', ap_paterno, ap_materno, nombre) alumno,
count(*) npagos, sum(pago) tpago
from alumnos a, pagos p
where a.clave_alu = p.clave_alu
group by a.clave_alu, concat_ws(' ', ap_paterno, ap_materno, nombre);

-- mujeres que han hecho un pago
select a.clave_alu, concat_ws(' ', ap_paterno, ap_materno, nombre) alumno,
count(*) npagos, sum(pago) tpago
from alumnos a, pagos p
where a.clave_alu = p.clave_alu
and sexo = 'f'
group by a.clave_alu, concat_ws(' ', ap_paterno, ap_materno, nombre);

-- Interseccion 
-- Para ver alumnos que no han pagado se puede hacer una interseccion o con un JOIN, de preferencia se hace un JOIN pero depende de como lo indique el profesor
-- Alumnos que si han pagado
select * from  alumnos
where clave_alu IN(select distinct clave_alu from pagos);

-- Alumnos que no han pagado
select * from  alumnos
where clave_alu NOT IN(select distinct clave_alu from pagos);

-- validando el caso anterior (alumno que no ha pagado)
select * from pagos where clave_alu = '11030183';

-- pagos por sexo
select sexo, count(*) npagos, sum(pago) tpago
from alumnos a, pagos p
where a.clave_alu = p.clave_alu
group by sexo; 

-- pagos por sexo, año
select sexo, extract(YEAR from fecha_pago) anio, 
count(*) npagos, sum(pago) tpago
from alumnos a, pagos p
where a.clave_alu = p.clave_alu
group by sexo, extract(YEAR from fecha_pago)
order by 1, 2; 

-- pagos por sexo, año y mes
select sexo, extract(YEAR from fecha_pago) anio, MONTH(fecha_pago) mes,
count(*) npagos, sum(pago) tpago
from alumnos a, pagos p
where a.clave_alu = p.clave_alu
group by sexo, extract(YEAR from fecha_pago), MONTH(fecha_pago)
order by 1, 2, 3; 

-- haciendo lo mismo que el caso anterior pero cambiando el GROUP BY
select sexo, extract(YEAR from fecha_pago) anio, MONTH(fecha_pago) mes,
count(*) npagos, sum(pago) tpago
from alumnos a, pagos p
where a.clave_alu = p.clave_alu
group by sexo, anio, mes
order by 1, 2, 3; 