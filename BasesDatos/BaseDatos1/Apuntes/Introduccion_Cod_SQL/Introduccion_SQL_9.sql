-- Funciones de cadena
use colegio2459;

-- Funcion CONCAT
select clave_alu, CONCAT(ap_paterno, ' ', ap_materno, ' ', nombre) alumno, -- va a concatenar los parametros que le pasemos
sexo, curp
from alumnos;

select clave_alu, CONCAT_WS(' ', ap_paterno, ap_materno, nombre) alumno, -- Concatena los valores indicados y los separa con el primer parametro
sexo, curp
from alumnos;

select clave_alu, CONCAT_WS(' ', ap_paterno, ap_materno, nombre) alumno, -- Concatena los valores indicados y los separa con el primer parametro
sexo, curp
from alumnos
where CONCAT_WS(' ', ap_paterno, ap_materno, nombre) like '%mar%';  -- concatena todos los campos y los evalua y muestra todos los que contengan 'mar'

select * from 
(select clave_alu, CONCAT_WS(' ', ap_paterno, ap_materno, nombre) alumno,    -- se esta anidando la consulta mostrando una tabla temporal para poder usar el campo alumno como si estuviera en verdad
sexo, curp
from alumnos) x
where alumno like '%mar%';   -- usamos una tabla temporal (la que se genera con lo del parentesis y fue nombrada x), y ahora si se puede usar el campo alumno de esa tabla como parametro

-- Funciones para formato
select distinct nombre, lower(nombre), lcase(nombre), -- pasa a minusculas
upper(nombre), ucase(nombre)                          -- pasa a mayusculas
from alumnos;

-- Obtener una cadena especifica
select distinct nombre, left(nombre, 4), right(nombre, 4),  -- left regresa los caracteres de las izq., right los de la derecha, mid regresa los de enmedio (<variable>, <inicio>, <cuantos caracteres se quieren mostrar (si no se pone nada regresa todos los valores a partir del inicio)>)
mid(nombre, 4), mid(nombre, 4, 4)
from alumnos;

-- Hacer la primera letra mayuscula y las demas minusculas
select distinct nombre, 
concat( upper(left(nombre, 1)), lcase(mid(nombre, 2)) ) lcapital  
from alumnos;

-- Funcion length
select distinct nombre, length(nombre)  -- cuenta los caracteres
from alumnos;

select distinct nombre, length(nombre),  -- contando una cadena concatenada
length(CONCAT_WS(' ', ap_paterno, ap_materno, nombre))
from alumnos;

select distinct nombre, length(nombre)
from alumnos
order by 2 DESC;  -- acomodando los nombres de mayor a menor

select distinct nombre, length(nombre)
from alumnos
where length(nombre) between 7 and 10 -- mostrando los nombre de largo entre 7 y 10
order by 2 DESC;    -- el 2 indica con que valor se esta ordenando (en este caso se ordena por longitud ==> length() )

select length(nombre) longitud, count(*) nnombres  -- mostrando que valores de longitud de los nombre se repite mas
from alumnos
group by length(nombre)
order by 2 desc;

-- Funcion IF
select distinct nombre, sexo,
if(sexo='M', 'MASCULINO', 'NO MASCULINO') genero  -- usando IF (<condicion>, <que pasa si es verdadero>, <que pasa si es falso>)
from alumnos; 

select distinct nombre, sexo,
if(sexo='M', 'MASCULINO', 
	if(sexo='F', 'FEMENINO', 'NO DEFINIDO') -- anidando un IF
) genero  -- usando IF ()
from alumnos; 

select nombre, curp,   -- obtiendo fecha nacimiento desde el curp
mid(curp, 5, 2) anio, mid(curp, 7, 2) mes, mid(curp, 9, 2) dia
from alumnos
where length(curp) = 18;

select nombre, curp, -- poniendo si los años son de 2000 0 1900 
if( mid(curp, 5, 2) <= 22, '20', '19') decada,
mid(curp, 5, 2) anio, mid(curp, 7, 2) mes, mid(curp, 9, 2) dia
from alumnos
where length(curp) = 18
order by 3;

select nombre, curp,   -- ahora si se obtiene la fecha completa
concat(
if( mid(curp, 5, 2) <= 22, '20', '19'),mid(curp, 5, 2), '-',
	mid(curp, 7, 2), '-', mid(curp, 9, 2) ) fnac
from alumnos
where length(curp) = 18
order by 3;

-- Funcion LOCATE . Regresa la posición en la que se encuentra la variable, pero empieza a contar los espacios desde el inicio, no desde la posición que le indiquemos que empiece a buscar 
select distinct nombre, locate('A', nombre), locate('A', nombre, 4) -- localiza un caracter (<caracter>, <variable>, <apartir de  que posicion (si se omite empieza desde el inicio)>) |  locate('A', nombre) ==> muestra la primera aparicion, locate('A', nombre, 4) ==> muestra la primera aparicion desde la cuarta posicion
from alumnos;

select distinct nombre, locate('A', nombre), locate('A', nombre, 4)
from alumnos
where locate('A', nombre) = 0;  -- que no contenga A

select distinct nombre, locate('A', nombre), locate('A', nombre, 4)
from alumnos
where locate('A', nombre) <> 0; -- que contenga A

select distinct nombre, locate('LUIS', nombre), locate('LUIS', nombre, 4)
from alumnos
where locate('LUIS', nombre) <> 0; -- que contenga LUIS

select distinct nombre, locate('LUIS', nombre), locate('LUIS', nombre, 4)
from alumnos
where locate(' ', nombre) <> 0; -- alumnos que tengan dos nombre (esta mostrando los nombres sin repeticiones porque se esta usando DISTINCT)

select distinct nombre,  -- Localizacion de primer nombre y segundo nombre
left(nombre, locate(' ', nombre) -1) n1,  -- primer nombre
mid(nombre, locate(' ', nombre) +1) n2    -- segundo nombre
from alumnos;

select distinct nombre,  -- Localizacion de primer nombre y segundo nombre y determinando si es primer nombre o segundo nombre
if(locate(' ', nombre)>0, left(nombre, locate(' ', nombre)-1), nombre) n1,  -- primer nombre
if(locate(' ', nombre)=0, null, mid(nombre, locate(' ', nombre)+1)) n2    -- segundo nombre
from alumnos;

-- Funcion REPEAT
select distinct nombre, repeat(nombre, 5) -- (<variable>, <veces que se va a repetir>)
from alumnos;

select distinct nombre, repeat('*', length(nombre))
from alumnos;

-- Funcion replace
select distinct nombre, replace(nombre, 'A', '4') -- ( <variable>, <caracter que se va a cambiar>, <caracter por el que se va a sustituir>)
from alumnos;

-- Crear  correo 
-- primera letra del nombre
-- ap_paterno
-- si es mujer @fes.mx si no @fes.com
-- espacios en blanco reemplazar por _

select distinct nombre, ap_paterno,
lower(
concat(
left(nombre,1), replace(ap_paterno, ' ', '_'),
if(sexo='f','@fes.mx','@fes.com')
)) newemail
from alumnos
where (length(email)=0 or locate('.', email)=0);