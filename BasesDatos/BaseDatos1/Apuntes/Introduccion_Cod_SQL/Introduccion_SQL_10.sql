use colegio2459;

-- Funciones con Fecha

select SYSDATE(); -- Regresa fecha y hora del sistema AAAA-MM-DD HORA
select current_date();  -- regresa la fecha
select current_time();  -- regresa la hora

-- DATE_FORMATE() . 
select SYSDATE(), DATE_FORMAT(sysdate(), '%Y') anio,  -- (<elemento del que se quiere obtener el valor>, <cadena que se quiere mostrar (especificador)>). En este caso se obtiene el año
DATE_FORMAT(sysdate(), '%M') nommes,  	-- regresa el nombre del mes
DATE_FORMAT(sysdate(), '%W') nomdia,	-- regresa el nombre del dia
DATE_FORMAT(sysdate(), '%m') mes,		-- regresa el mes
DATE_FORMAT(sysdate(), '%d') dia;		-- regresa el dia

-- Formar cadenas a partir de utilizar operadores
select sysdate(), -- este es solo para comparar que si sea correcto lo que nos muestra (no es necesario ponerlo)
date_format(sysdate(), 'Hoy es %W, %d del mes %M del año %Y, y es el dia %j') fecha;

	-- pasar a español
    show variables like 'lc_time_names'; -- viendo en que idioma esta el sistema
    SET lc_time_names = 'es_Mx'; 	-- cambiando a español de mexico (si se quiere asignar otro idioma solo se cambia lo que esta entre comillas, ejem. 'es_ES' ==> Español España)

select sysdate(), -- ahora si ya esta en español
date_format(sysdate(), 'Hoy es %W, %d del mes %M del año %Y, y es el dia %j') fecha;

-- Asignar variables en SQL
set @f = '2020-04-24 16:34:22'; -- @<nombre de la variable> = <valor>
select @f;  -- mostrando variable

select @f, date_format(@f, 'Hoy es el dia %j del año') diaanio, -- dia del año de la variable asignada
date_format(@f, 'Hoy es la semana numero %u del año') semanaanio,  -- semana del año
date_format(@f, 'Dia: %d, Mes:%m, Año:%Y') fecha,  	-- fecha
date_format(@f, 'Nombre del mes %M, nombre dia %W') fecha2,		-- fecha 2
date_format(@f, 'Hora:%H, minutos %i, segundos: %s') hora,		-- Hora
date_format(@f, 'Hora en formato 24H: %k') h24,		-- Hora en 24H
date_format(@f, 'Hora en formato 12H: %h') h12,		-- Hora en 12H
date_format(@f, '%p') ampm;		-- Hora en AM o PM

-- Datos desde un campo (campo existente en una tabla)
select distinct fedita,
date_format(fedita, '%Y') anio, date_format(fedita, '%m') mes,
date_format(fedita, '%d') dia, date_format(fedita, '%H') hora,
date_format(fedita, '%i') minutos, date_format(fedita, '%s') segundos,
date_format(fedita, '%u') semana, date_format(fedita, '%k') h24,
date_format(fedita, '%u') semana, date_format(fedita, '%h') h12,
date_format(fedita, '%j') diaanio
from alumnos;

-- Ver los datos de una fecha especifica
select clave_alu, nombre, ap_paterno, ap_materno, sexo, curp, email, fedita
from alumnos
where date_format(fedita, '%Y') = '2017';  -- mostrando datos de alumnos que han cambiado sus datos en el 2017

-- Tambien se puede utilizar para agrupar
select date_format(fedita, '%Y') anio, count(*) nalu  -- contar los alumnos que han cambiando sus datos en el mismo año
from alumnos 
group by date_format(fedita, '%Y')
order by 1;

select date_format(fedita, '%Y') anio, date_format(fedita, '%m') mes,   -- mostrar cuantos alumnos han cambiado sus datos por año y mes
date_format(fedita, '%M') nmes, count(*) nalu
from alumnos 
group by date_format(fedita, '%Y'), date_format(fedita, '%m'), date_format(fedita, '%M')
order by 1, 2;

-- Otras opciones para las funciones (llamar las funciones de fecha con otro nombre)
select distinct fedita, YEAR(fedita) anio, month(fedita) mes, day(fedita) dia, dayname(fedita) nomdia,
monthname(fedita) nommes, dayofweek(fedita) diasemana, dayofyear(fedita) diaanio, hour(fedita) hora,
minute(fedita) minuto, second(fedita) segundo
from alumnos;

select clave_alu, nombre, ap_paterno, ap_materno, sexo, curp, email, fedita
from alumnos
where dayofyear(fedita) > 182;    -- alumnos que han hecho el cambio en la segunda mitad del año

-- Cambiando el valor de la variable
set @f = '2020-12-31 23:59:59';

-- DATE_ADD(), DATE_SUB() . Ayudan a modificar intervalos de tiempo en una fecha (<campo de fecha>, < INTERVAL <cantidad intervalo> <medición del intervalo> >) . DATE_SUB() trabaja igual pero en negativo . El intervalo no se puede anidar, se tendría que anidar la función.
select @f, date_add(@f, INTERVAL 1 second) mas1s, -- agregandole un segundo
date_add(@f, INTERVAL 1 day) mas1dia, -- agregandole un dia
date_add(@f, INTERVAL 1 hour) mas1hora,	-- agregandole una hora
date_add(@f, INTERVAL 1 month) mas1mes,	-- agregandole un mes
date_add(@f, INTERVAL 1 year) mas1anio;	-- agregandole un año

select sysdate(), date_add(sysdate(), INTERVAL 2 hour) mas2h,  -- mostrando la fecha actual pero con diferentes horas
date_add(sysdate(), INTERVAL -2 hour) men2hr, -- menos dos horas
date_sub(sysdate(), INTERVAL 2 hour) me2hr,	-- menos dos horas pero con date_sub()
date_sub(sysdate(), INTERVAL -2 hour) mas2hr;	-- mas dos horas pero con date_sub()

select fedita, date_add(fedita, INTERVAL 2 hour) mas2h  -- mostrando la fecha de un campo pero con hora diferente
from alumnos;

-- Función DATEDIFF() . Devuelve la diferencia en dias de dos fechas . DATEDIFF( <fecha u hora mas actual>, <fecha mas antigua>)
select distinct fedita, datediff(now(), fedita) difdias -- *now() es un alias para sysdate()
from alumnos;

select distinct fedita, datediff(now(), fedita) difdias,  --  Si se quiere mostra la diferencia en horas o minutos entonces se tiene que hacer una multiplicacion
(datediff(now(), fedita) * 24) difhr,		-- diferencia en horas
((datediff(now(), fedita) * 24) * 60) difmin,		-- diferencia en minutos
(datediff(now(), fedita) / 7) difsem,		-- diferencia en semanas
(datediff(now(), fedita) / 30.3) difmes,		-- diferencia en meses
(datediff(now(), fedita) / 365) difanios		-- diferencia en años
from alumnos;

select clave_alu, nombre, ap_paterno, ap_materno, sexo, curp, email, fedita  -- alumnos que hayan hecho un cambio en mas de 5 años
from alumnos
where (datediff(now(), fedita) / 365) > 5;

-- Funcion TIMESTAMPDIFF() . Diferencia de un segmento de tiempo. TIMESTAMPDIFF(<escala del segmento>, <fecha mas antigua>, <fecha mas actual>)
select distinct fedita, curdate(), timestampdiff(MINUTE, fedita, sysdate()) difmin -- curdate() ==> hora actual
from alumnos;

select distinct fedita, curdate(), 
timestampdiff(MINUTE, fedita, sysdate()) difmin,  -- diferencia en minutos
timestampdiff(SECOND, fedita, sysdate()) difseg,  -- diferencia en segundos
timestampdiff(HOUR, fedita, sysdate()) difhr,	-- diferencia en horas
timestampdiff(WEEK, fedita, sysdate()) difsem,	-- diferencia en semanas
timestampdiff(QUARTER, fedita, sysdate()) diftrim, 	-- diferencia en trimestres
timestampdiff(YEAR, fedita, sysdate()) difanio,	 -- diferencia en años
timestampdiff(DAY, fedita, sysdate()) difdia  -- diferencia en dias
from alumnos;

-- Funcion EXTRACT() . Obtener formatos o segmentos de una fecha, por ejemplo, el dia de una fecha . EXTRACT(<que se quiere extraer> from <campo del que se quiere extraer>)
select distinct fedita, extract(DAY from fedita) dia 
from alumnos;

select distinct fedita, extract(DAY from fedita) dia,  -- extraer el dia
extract(WEEK from fedita) semana, extract(DAY_HOUR from fedita) diahora -- extraer la semana, extraer el dia y hora
from alumnos;

-- Obtener la edad de un alumno a partir del CURP
select nombre, ap_paterno, ap_materno, curp, ( year(curdate()) - year(fnac) ) edad, -- obterner la edad haciedo la operacion
timestampdiff(YEAR, fnac, sysdate()) edad2											-- obtener la edad con timestampdiff
from
(																					-- haciendo una subconsulta para mostrar una tabla temporal
select nombre, ap_paterno, ap_materno, curp, substr(curp, 5, 2) anio,
concat(
if(mid(curp, 5, 2) <= 10, '20', '19'), mid(curp, 5, 2), '-',
mid(curp, 7, 2), '-', mid(curp, 9, 2)) fnac
from alumnos
where length(curp) = 18) x;