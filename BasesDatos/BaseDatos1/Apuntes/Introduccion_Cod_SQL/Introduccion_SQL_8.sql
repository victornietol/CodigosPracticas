use colegio2459;

-- Operadores logicos SQL

-- Operador AND
select * from alumnos;
select * from alumnos
where sexo = 'f' AND ciudad <>'queretaro';

-- Operador OR
select * from alumnos
where sexo = 'f' OR ciudad <>'queretaro';

-- Operador NOT
select * from alumnos
where NOT (sexo = 'f' OR ciudad <>'queretaro');

-- Otro ejemplo de encontrar un rango de valores con ayuda de AND
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where estatura >= 1.60 AND estatura <= 1.69
order by estatura;

-- Utilizando BETWEEN en lugar de AND (es más rapido que utilizar dos condicionales) (where <campo de la comparacion> BETWEEN <rango menor> AND <rango mayor>)
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where estatura BETWEEN 1.60 AND 1.69
order by estatura;

-- Utilizando NOT
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where NOT estatura BETWEEN 1.60 AND 1.69
order by estatura;

-- Otro ejemplo de BETWEEN
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre BETWEEN 'miguel' AND 'oscar'
order by nombre;

-- Buscando entre nombre con M y O
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre BETWEEN 'm' AND 'o'
order by nombre;

-- Evaluando otra cadena aunque estas cadenas no sean parte de la base (BETWEEN evalua las cadenas en orden alfabetico
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre BETWEEN 'mago' AND 'oso'
order by nombre;

-- También trabaja con fechas
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura,
fedita
from alumnos
order by nombre;

-- Mostrar entre un rango de fechas (between hace un mayor o igual)
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura,
fedita
from alumnos
where fedita BETWEEN '2016-10-02 00:00:00' AND '2016-10-03 23:59:59'
order by fedita;

-- Operador IN 
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre = 'carlos' or nombre = 'estefania' or nombre = 'abraham' or nombre =
'maria'
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre IN ('carlos', 'estefania', 'abraham', 'maria')   -- Aqui ya se aplica el IN, (es mas corto que estar poniendo varios or) (hace la misma funcion que poner varios OR)
order by nombre;

-- Negando el IN
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre NOT IN ('carlos', 'estefania', 'abraham', 'maria')   -- Aqui ya no van a aparecer estos valores
order by nombre;

-- Haciendo INTERSECCION con una consulta anidada 
select * from alumnos;
select * from profesores;
select distinct nombres from profesores;
-- esta es la consulta (alumos que se llaman como profesores) 
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre IN (select distinct nombres from profesores)   -- va a evaluar solo a los nombres que muestre el distinct
order by nombre;

-- Consulta aún más anidada (profesores que se llaman como alumnos) (esta es una consulta dentro de otra consulta)
select * from profesores
where nombres IN(
select nombre
from alumnos
where nombre IN (select distinct nombres from profesores))
order by nombres;

-- Operador LIKE (busca subcadenas)
	--  %  representa cualquier cadena
    --  _  representa una posicion
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre LIKE 'adrian'   
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre LIKE '%adrian%'  -- %  cualquier cadena que contenga 'adrian'
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre LIKE 'adrian%'    -- aqui las cadenas que inician con 'adrian' y despues tienen cualquer cadena
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre LIKE '%adrian'    -- aqui las cadenas que inician con cualquier cadena y terminal con 'adrian'
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre LIKE '%a%'    -- cualquier cadena que contenga una 'a'
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre NOT LIKE '%a%'    -- cualquier cadena no contenga una 'a'
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre LIKE '% %'    -- buscando alumnos con mas de un nombre
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre LIKE '% % %'    -- buscando alumnos con mas de dos nombres
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre LIKE '% % %' and not(nombre like '%de%' or nombre like '%del%' or nombre like '%  %')    -- buscando alumnos con mas de dos nombres pero que no contengan 'de', 'del', '  ' <== doble espacio 
order by nombre;

-- filtrar por correo validos
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where email LIKE '%@%.%'  -- todo correo valido tiene @ y '.'
order by nombre;

-- filtrar por correos no validos
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where email not LIKE '%@%.%'  -- todo correo valido tiene @ y '.'
order by nombre;

-- Utilizando _ (representa posiciones)
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre like '____'  -- cada espacio representa un caracter
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre like '_A__'  -- muestra un caracter especifico en una posicion determinada
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre like '_A_A'  -- muestra un caracteres especificos en posiciones determinadas
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where nombre like '_A%A'  -- cualquier cadena que tenga una A en la segunda poscion y en la ultima posicion, y ademas que sea de la longitud que sea
order by nombre;

-- Busqueda basada en el CURP
-- CURP
-- 4 posiciones para nombre
-- 6 posiciones para fecha de nacimiento AAMMDD
-- 1 posicion para sexo
-- estado de nacimiento en la posicion 12 2 posiciones
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where curp like '___________DF%' -- alumnos que nacieron en el DF (se busca a partir del curp)
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where curp like '__________MDF%' -- mujeres que nacieron en el DF (se busca a partir del curp)
order by nombre;

select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura
from alumnos
where curp like '____91____MDF%' -- mujeres que nacieron en el 91 en el DF (se busca a partir del curp)
order by nombre;

-- ver los alumnos de alguna ciudad (sin importar como este escrito)
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura, id_estado
from alumnos
where (ciudad like '%quer%' or ciudad like '%qro%')  -- muestra los alumnos de queretaro sin importar como este escrito el estado
order by ciudad;

-- cuando la ciudad sea null
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura, id_estado
from alumnos
where ciudad is null
order by ciudad;

-- ahora muestra cuando ciudad sea un campo blanco
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura, id_estado
from alumnos
where ciudad = ''
order by ciudad;

-- muestra los alumnos que si tiene ciudad
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura, id_estado
from alumnos
where ciudad is not null
order by ciudad;

-- mostrando los alumnos que tienen ciudad NULL o blanco
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura, id_estado
from alumnos
where (ciudad is null OR ciudad = '')
order by ciudad;

-- mostrando los alumnos que si tienen ciudad (null es diferente a blanco)
select nombre, ap_paterno, ap_materno, sexo, ciudad, curp, email, estatura, id_estado
from alumnos
where not (ciudad is null OR ciudad = '')
order by ciudad;