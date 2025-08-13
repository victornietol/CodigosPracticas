use colegio2459;

-- Haciendo busqueda de campos con condicionales (Clausula WHERE)
select distinct nombre from alumnos;

select nombre, ap_paterno, ap_materno, sexo, sexo = 'm'
from alumnos
where sexo <> 'm';

select nombre, ap_paterno, ap_materno, sexo, ciudad, peso, estatura
from alumnos
where sexo = 'm' and ciudad != 'QUERETARO';  -- agregando condicionales para filtrar las busquedas

select nombre, ap_paterno, ap_materno, sexo, ciudad, peso, estatura,
(peso/(estatura*estatura)) imc
from alumnos
where sexo = 'm' and ciudad != 'QUERETARO'
and (peso/(estatura*estatura)) > 20;   -- haciendo consulta con un campo temporal (el campo todavia no existe, por eso es temporal)

select nombre, ap_paterno, ap_materno, sexo, ciudad, peso, estatura,
(peso/(estatura*estatura)) imc
from alumnos
where sexo = 'm' and ciudad != 'QUERETARO'
or (peso/(estatura*estatura)) > 20;   -- si se cambia un AND por un OR mostrará más registros

-- Negacion
select nombre, ap_paterno, ap_materno, sexo, ciudad, peso, estatura
from alumnos
where not sexo = 'm';  -- se indica que el sexo no debe ser 'm'

select * from alumnos where 1=1;  -- 1=1 indica que mostrará todos los registros porque 1 es igual 1 

select * from alumnos where binary ciudad = 'queretaro'; -- una consulta en binario se evalua diferete, por lo tanto en este caso no va a regresar nada

-- Clausula GROUP BY
select ciudad from alumnos
group by ciudad;  -- crea grupos con una etiqueta (es parecido a distinct) funciona de mejor manera con funciones de agregacion. Los campos que se pongan en GROUP BY tambien deben de estar en SELECT

					-- funciones de agragacion
					-- count() max() min() avg() sum()

select sexo, count(*)
from alumnos
group by sexo;   -- agrupa los campos que coinciden y los cuenta 

select sexo, count(*) as nalu
from alumnos
where ciudad = 'queretaro'  -- haciendo lo mismo que el caso anterior, pero filtrando las consultas por ciudad (siempre debe ir en orden las clasulas, en este caso va antes WHERE que GROUP BY)
group by sexo;

select ciudad, sexo, count(*) as nalu  -- agregando mas criterios
from alumnos
where ciudad <> 'queretaro'  
group by ciudad, sexo;

-- Clausula HAVING. Todo lo que viene de una funcion de agregacion se tiene que hacer con HAVING
select ciudad, sexo, count(*) as nalu  
from alumnos
where ciudad <> 'queretaro'  
group by ciudad, sexo
having nalu >= 10;

select nombre, count(*) nalu  -- ejemplo de mostrar las nombre de mujeres que tengan nombre repetidos
from alumnos
where sexo = 'f'
group by nombre
having nalu >1;

select nombre, ap_paterno, ap_materno, count(*) nalu  -- otro ejemplo para identificar si son la misma persona
from alumnos
group by nombre, ap_paterno, ap_materno
having nalu >1;

select * from alumnos   -- verificando si son repetidos los registros del caso anterior
where
(nombre = 'LUISA ANDREA' AND ap_paterno = 'GOMEZ' AND ap_materno = 'RENTERIA')
or 
(nombre = 'LUISA'AND ap_paterno = 'MEJIA'AND ap_materno = 'JIMENEZ');

-- Clausula ORDER BY
select * 
from alumnos
order by ap_paterno;  -- ordenando por un campo especificado

select nombre, ap_paterno, ap_materno
from alumnos
order by ap_paterno, ap_materno, nombre;

select nombre, ap_paterno, ap_materno
from alumnos
order by ap_paterno asc, ap_materno asc, nombre asc;  -- es lo mismo que lo anterior (los acomoda en ascendente)

select nombre, ap_paterno, ap_materno
from alumnos
order by 2, 3, 1;  -- es lo mismo que los anteriores

select nombre, ap_paterno, ap_materno
from alumnos
order by 2 desc, 3 asc, 1 desc; -- diferente orden de ordenamiento

select sexo, nombre, ap_paterno, ap_materno
from alumnos
order by sexo desc, 3 asc, nombre desc;  -- diferente orden de ordenamiento y se le agrego otro campo

select sexo, nombre, ap_paterno, ap_materno
from alumnos
where ciudad = 'queretaro'      -- filtrando por un campo 
order by sexo desc, 3 asc, nombre desc;   

select sexo, nombre, ap_paterno, ap_materno
from alumnos
where ciudad = 'queretaro' or ciudad = 'corregidora'      -- filtrando por dos campos 
order by sexo desc, 3 asc, nombre desc; 

select sexo, nombre, ap_paterno, ap_materno
from alumnos
where (ciudad = 'queretaro' or ciudad = 'corregidora') and sexo = 'f'      -- filtrando por mas campos 
order by sexo desc, 3 asc, nombre desc;

select nombre, count(*) nalu
from alumnos
where sexo = 'f'
group by nombre
having nalu >=2
order by 2 desc, 1;

-- 	Clausula LIMIT 
select nombre, ap_paterno, ap_materno
from alumnos
limit 10;  -- muestra los primeros 10 registros que aparecen

select nombre, ap_paterno, ap_materno
from alumnos
where sexo = 'f'
limit 10;

select nombre, ap_paterno, ap_materno
from alumnos
where sexo = 'f'
limit 10, 10;  -- indica el inicio y cuantos se van a mostrar a partir de esa posicion (limit <inicio>, <cuantos se van a mostrar>)

select nombre, ap_paterno, ap_materno
from alumnos
where sexo = 'f'
limit 300, 10;  -- ya no va a mostrar nada porque ya no ha registros apartir de 300

select nombre, ap_paterno, ap_materno
from alumnos
where sexo = 'f'
limit 280, 10;  --  solo va a mostrar 2 registros porque solo quedan dos registros despues de 280

select nombre, count(*) nalu
from alumnos
where sexo = 'f'
group by nombre
having nalu >=2
order by 2 desc, 1
limit 5;  -- mostrando los 5 nombres de mujeres mas repetidos

select nombre, count(*) nalu
from alumnos
where sexo = 'f'
group by nombre
having nalu >=2
order by 2 desc, 1
limit 5, 5; -- mostrando los 5 siguientes registros despues del 5 