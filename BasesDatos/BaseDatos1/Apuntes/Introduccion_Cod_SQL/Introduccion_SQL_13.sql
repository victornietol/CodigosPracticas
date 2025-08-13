-- FULL OUTHER JOIN . 
use colegio2459;

select * from alumnos;
select * from profesores;

-- Haciendo UNION. Suma los renglones de dos tablas con el mismo numero de columnas (permanecen las columnas de la primera tabla)
select clave_alu, ap_paterno, ap_materno, nombre from alumnos
UNION
select clave_prof, apellido_p, apellido_m, nombres from profesores;

	-- lo mismo, pero mejor filtrado
select clave_alu clave, ap_paterno paterno, ap_materno materno, nombre from alumnos
UNION
select clave_prof, apellido_p, apellido_m, nombres from profesores
order by 2,3,4;

	-- otra forma (agragando otro campo si se quiere)
select clave_alu clave, ap_paterno paterno, ap_materno materno, nombre, 'alumno' tipo from alumnos
UNION
select clave_prof, apellido_p, apellido_m, nombres, 'profesor' tipo from profesores
order by 2,3,4;

	-- contar cuantos corresponden a un tipo
select tipo, count(*) npersonas
from
(select clave_alu clave, ap_paterno paterno, ap_materno materno, nombre, 'alumno' tipo from alumnos
UNION
select clave_prof, apellido_p, apellido_m, nombres, 'profesor' tipo from profesores) p
group by tipo;

-- Haciendo varios UNION (se puso el 'tipo' para ver de donde venian los datos)
select clave_mat clave, nombre item, 'materia' tipo from materias
UNION
select id_nivel, nombre, 'nivel' from niveles
UNION
select id_grado, nombre, 'grado' from grados
UNION
select pago, count(*) npagos, 'pago' from pagos group by pago
order by 2;

-- revisando varias bases . UNION ALL, muestra todos los datos aunque se repitan. (si no se pone ALL los muestra como un distinct)
select clave_alu clave, ap_paterno paterno, ap_materno materno, nombre, 'colegio2459' base 
from alumnos -- aqui iria la otra base
UNION ALL
select clave_alu clave, ap_paterno paterno, ap_materno materno, nombre, 'colegio2409' base
from alumnos
UNION ALL
select clave_alu clave, ap_paterno paterno, ap_materno materno, nombre, 'colegio1709' base 
from alumnos
order by 1;

-- Haciendo un UNION DE UN LEFT JOIN y RIGHT JOIN, osea un FULL OUTER JOIN. (todo lo que esta en A y todo lo que esta en B)
select * from 
alumnos a LEFT JOIN pagos p ON(a.clave_alu = p.clave_alu)  -- mostrando un LEFT JOIN
UNION		-- No lleva ALL porque sino repite datos (en este caso no es necesario)
select * from 
alumnos a RIGHT JOIN pagos p ON(a.clave_alu = p.clave_alu); -- mostrando un LEFT JOIN

-- FULL OUTER JOIN. (Otro caso). En este se muestran los datos que no estan en B y tampoco estan en A
select * from 
alumnos a LEFT JOIN pagos p ON(a.clave_alu = p.clave_alu) 
where p.clave_alu is null 
UNION		
select * from 
alumnos a RIGHT JOIN pagos p ON(a.clave_alu = p.clave_alu)
where a.clave_alu is null;


-- VISTAS.
show tables;
select * from alumnos;

	-- crear VISTA
CREATE VIEW estudiantes AS
select * from alumnos;  -- se crea una vista como la tabla alumnos. (y todos los cambios en alumnos tambien se ven reflejados en estudiantes)

	-- usando la vista
select * from estudiantes;
select * from estudiantes where curp <> '';

	-- tambien pueden ocultar datos 
create or replace view inscritos as
select clave_alu matricula, concat_ws('', ap_paterno, ap_materno, nombre) alumnos, curp, email mail
from alumnos;

select * from inscritos;
desc inscritos;

	-- agregando un filtro
create or replace view alumnas as
select clave_alu matricula, concat_ws('', ap_paterno, ap_materno, nombre) alumnos, curp, email mail
from alumnos
where sexo = 'f';

select * from alumnas;

	-- crear vista basada en otra vista
create or replace view alumnos_pagos as
select i.matricula, alumnos, count(pago) npagos, ifnull(sum(pago), 0) tpagos
from inscritos i LEFT JOIN pagos p ON(i.matricula = p.clave_alu)
group by i.matricula;

select * from alumnos_pagos;

	-- ver quien no ha pagado con la vista
select * from alumnos_pagos where npagos = 0;

-- Borra vista
drop view inscritos; -- si se borra la vista ya no se pueden usar las vistas que sean dependientes de esa vista borrada

-- para poder distinguir las vistas de las tablas
select * from information_schema.tables
where table_schema = 'colegio2459';

	-- ahora solo se muestran las vistas . (SOLO SE MUESTRAN LAS VISTAS)
select * from information_schema.tables
where table_schema = 'colegio2459' 
AND table_type = 'VIEW';

	-- ver como se creo una vista
show create view alumnos_pagos;

-- lo anterior genera esto:
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `alumnos_pagos` AS select `i`.`matricula` AS `matricula`,`i`.`alumnos` AS `alumnos`,count(`p`.`pago`) AS `npagos`,ifnull(sum(`p`.`pago`),0) AS `tpagos` from (`inscritos` `i` left join `pagos` `p` on((`i`.`matricula` = `p`.`clave_alu`))) group by `i`.`matricula`;
