-- Operador JOIN

use colegio2459;

-- JOIN de pagos de alumnos
select * 
from alumnos a JOIN pagos p ON (a.clave_alu = p.clave_alu);

--  pagos de las mujeres
select * 
from alumnos a JOIN pagos p ON (a.clave_alu = p.clave_alu)
where sexo = 'f';

-- Otra forma de hacer el JOIN, ahora con USING. no muestra la llave foranea en la vista temporal
-- indicando cual es la llave con la que se hace (se hace esto solo si la clave se llama igual en las dos tablas)
select * 
from alumnos a JOIN pagos p USING(clave_alu);

-- Otra forma de JOIN con NATURAL JOIN.
-- Si la llave primaria y la llave foranea se llaman igual y son del mismo tipo se puede hacer esto. (No es necesario poner la PK ni FK, solito lo infiere)
select * 
from alumnos a NATURAL JOIN pagos p;

-- Mostrando alumnos que tengan pagos
select a.clave_alu, 
concat_ws(' ', ap_paterno, ap_materno, nombre) alumno,
count(*) npagos, sum(pago) tpago
from alumnos a JOIN pagos p ON(a.clave_alu = p.clave_alu)
group by a.clave_alu;

-- LEFT JOIN. alumnos que estan en una pero no en la otra parte
select *
from alumnos a LEFT JOIN pagos p ON(a.clave_alu = p.clave_alu)
order by 1 desc;

-- mostrando todos los alumnos aunque no tengan pagos
select a.clave_alu, 
concat_ws(' ', ap_paterno, ap_materno, nombre) alumno,
count(*) npagos, sum(pago) tpago
from alumnos a LEFT JOIN pagos p ON(a.clave_alu = p.clave_alu)
group by a.clave_alu
order by 3;

-- ahora no va a contar los que no tengan pagos, aunque si los va a mostrar
select a.clave_alu, 
concat_ws(' ', ap_paterno, ap_materno, nombre) alumno,
count(pago) npagos, sum(pago) tpago
from alumnos a LEFT JOIN pagos p ON(a.clave_alu = p.clave_alu)
group by a.clave_alu
order by 3;

-- ahora en lugar de decir null en tpago, va a decir 0 si da como resultado null
select a.clave_alu, 
concat_ws(' ', ap_paterno, ap_materno, nombre) alumno,
count(pago) npagos, ifnull(sum(pago), 0) tpago
from alumnos a LEFT JOIN pagos p ON(a.clave_alu = p.clave_alu)
group by a.clave_alu
order by 3;

-- mostrando salones
select * from salones;

-- JOIN
select * from niveles n JOIN salones s ON(n.id_nivel = s.id_nivel);

-- LEFT JOIN
select * from niveles n LEFT JOIN salones s ON(n.id_nivel = s.id_nivel);

-- niveles que tienen salon
select * from niveles n LEFT JOIN salones s ON(n.id_nivel = s.id_nivel)
WHERE s.id_nivel is null;

-- alumnos que no han hecho pagos
select *
from alumnos a LEFT JOIN pagos p ON(a.clave_alu = p.clave_alu)
where p.clave_alu is null
order by 1;

-- mostrando alumnos que no tengan pagos 
select a.clave_alu, 
concat_ws(' ', ap_paterno, ap_materno, nombre) alumno,
count(pago) npagos, ifnull(sum(pago), 0) tpago
from alumnos a LEFT JOIN pagos p ON(a.clave_alu = p.clave_alu)
where p.clave_alu is null
group by a.clave_alu
order by 3;

-- Usando RIGTH. mostrando los salones aunque no tengan niveles (ayuda a identificar los datos que son basura)

select * from niveles n RIGHT JOIN salones s ON(n.id_nivel = s.id_nivel); -- esto va a mostrar los datos que son basura porque no hay nivel 0

-- mostrando los salones que no tienen referencia y por lo tanto son basura
select * from niveles n RIGHT JOIN salones s ON(n.id_nivel = s.id_nivel)
WHERE n.id_nivel is null;   -- <== aqui se cambio s.id_nivel por s.id_nivel 

-- pagos que no correspondan a un alumno
select*
from alumnos a RIGHT JOIN pagos p ON(a.clave_alu = p.clave_alu)
where a.clave_alu is null 
order by 1 desc;   -- no va a mostrar nada porque no hay datos basura

-- insertar datos para ver como se identifica los datos basura
insert into pagos values('21040207', '150038', '1104020735', 'INSCRIPCION1718', '7000', '2017-03-15 00:00:00', 'A', '2017-03-16 09:20:53', 'C012', null),
('21070167', '154372', '1107016715', 'INSCRIPCION1718', '5600', '2017-03-15 00:00:00', 'A', '2017-03-16 09:20:53', 'C012', null),
('21070129', '154298', '1107012965', 'INSCRIPCION1718', '5600', '2017-03-15 00:00:00', 'A', '2017-03-16 09:20:53', 'C012', null),
('21070166', '150038', '1107016652', 'INSCRIPCION1718', '5600', '2017-03-15 00:00:00', 'A', '2017-03-16 09:20:53', 'C012', null),
('21040155', '154057', '1104015580', 'INSCRIPCION1718', '7000', '2017-03-15 00:00:00', 'A', '2017-03-16 09:20:53', 'C012', null
);

-- ahora se hace lo anterior para identificar la basura
select*
from alumnos a RIGHT JOIN pagos p ON(a.clave_alu = p.clave_alu)
where a.clave_alu is null 
order by 1 desc;   -- ahora si muestra los datos

-- haciendo lo mismo del punto anterior, pero mostrando de mejor manera los pagos que no corrsponden alumnos. (ahora solo muestra los pagos p.*)
select p.*
from alumnos a RIGHT JOIN pagos p ON(a.clave_alu = p.clave_alu)
where a.clave_alu is null 
order by 1 desc;

-- otro ejemplo de representar lo anterior
select p.id, p.clave_alu, a.*    -- ahora muestra estos campos
from alumnos a RIGHT JOIN pagos p ON(a.clave_alu = p.clave_alu)
where a.clave_alu is null 
order by 1 desc;