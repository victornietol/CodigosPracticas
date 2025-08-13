-- Repaso examen
use colegio2459;

show columns from alumnos;

desc alumnos;

select * from information_schema.tables;

show index from alumnos;

use prueba_bd;

create unique index uk_nuevo_index on libro(id_libro, titulo);
show index from libro;

use prueba2459;
update escritor set direccion = 'Desconocida';
select*from escritor;
update escritor set direccion = 'MX', alias = 'EE'  where id_escritor = 1002;

select 4>5, 4<5;

insert into escritor values (1153,'Javier','Hernandez Perez','calle 1432',null)
on duplicate key update id_escritor = id_escritor+1000;

replace into escritor (id_escritor,nombre,apellidos)
values (1150, 'Carlos','Huerta');

use colegio2459;

select distinct nombre, clave_alu from alumnos;

select concat_ws(' ', ap_paterno, ap_materno, nombre) alumno, sexo, sexo = 'm'
from alumnos
where sexo = 'f';

select nombre, ap_paterno, ap_materno, sexo, ciudad, peso, estatura,
(peso/(estatura*estatura)) imc
from alumnos
where sexo = 'm' and ciudad != 'QUERETARO'
and (peso/(estatura*estatura)) > 20;

select nombre, ap_paterno, ap_materno, sexo, ciudad, peso, estatura,
(peso/(estatura*estatura)) imc
from alumnos
where sexo = 'm' and ciudad != 'QUERETARO'
having imc > 20;

select ciudad, sexo, count(*) as nalu  -- agregando mas criterios
from alumnos
where ciudad <> 'queretaro'  
group by ciudad, sexo;

select nombre, ciudad, count(*) from alumnos
where estatura > 1.65
group by nombre, ciudad;

select nombre, ciudad, count(*) num from alumnos
where estatura > 1.65
group by nombre, ciudad
having num>1;

select * from alumnos
where not sexo = 'f';

select * from alumnos
where sexo <> 'f';

select * from alumnos
where not peso between 50 and 60
order by peso;

select * from alumnos		-- nombres de la m a la p
where nombre between 'm' and 'p'
order by nombre;

select * from alumnos
where fedita between '2016-10-02 00:00:00' and '2016-10-02 23:59:59' 
order by fedita;

select * from alumnos
where clave_admin in ('NULL', '')
AND direccion is null;

select * from alumnos
where nombre in (select distinct nombres from profesores)
order by nombre;

select * from alumnos
where not nombre like 'a%';

select * from alumnos
where email like '%@%.%';

select * from alumnos
where email like 'v%@%';

select * from alumnos
where nombre like '____'
and sexo = 'm';

select * from alumnos
where curp like '____91____mdf%' and nombre like '%c%';

select * from alumnos
where ciudad not like '%quer%' and ciudad not like '%qro%'; -- and ciudad not like ' ';

select * from alumnos
where not (ciudad is null or ciudad = '')
order by ciudad;

select * from alumnos
where not sexo ='';

select concat_ws(' ', ap_paterno, ap_materno, nombre) nombre from alumnos
having nombre like '%mar%';

select * from 	-- lo mismo que el anterior pero mas largo
(select concat_ws(' ', ap_paterno, ap_materno, nombre) nombre from alumnos) x
where nombre like '%mar%';

select lower(nombre) from alumnos;

select distinct nombre , left(nombre,4) inicio, right(nombre,4) final, mid(nombre,5,3) enmedio from alumnos
where nombre like '_____%';

select concat_ws(' ',
concat( left(upper(ap_paterno),1) , mid(lower(ap_paterno),2) ), 
concat( left(upper(ap_materno),1) , mid(lower(ap_materno),2) ),
concat( left(upper(nombre),1) , mid(lower(nombre),2) ) 
) nombre from alumnos;

select nombre, length(nombre) from alumnos;

select nombre, length(nombre) longitud from alumnos
having longitud > 10;

select 
concat_ws(' ', ap_paterno, ap_materno, nombre) nombre, 
length( concat_ws(' ', ap_paterno, ap_materno, nombre) ) longitud 
from alumnos
having longitud > 30
order by 2 desc;

select clave_alu, nombre, if(nombre like '%v%', 'si tiene', 'no tiene') letra 
from alumnos;

select clave_alu, nombre, if(estatura is null, 'no tiene', 'si tiene') letra 
from alumnos;

select clave_alu, nombre, if(estatura is null, 'no tiene', 'si tiene') letra 
from alumnos
having letra like 'no tiene';

select nombre, curp,   -- ahora si se obtiene la fecha completa
concat(
if( mid(curp, 5, 2) <= 22, '20', '19'),
	mid(curp, 5, 2), '-',
	mid(curp, 7, 2), '-', 
    mid(curp, 9, 2) ) fnac
from alumnos
where length(curp) = 18
having fnac > '1994-12-31';

select nombre, locate('v',nombre) posicion from alumnos
having posicion > 0;

select nombre, locate('victor',nombre) posicion from alumnos
having posicion > 0;

select nombre, locate(' ', nombre) posicion from alumnos;

select distinct nombre,  -- Localizacion de primer nombre y segundo nombre y determinando si es primer nombre o segundo nombre
if(locate(' ', nombre)>0, left(nombre, locate(' ', nombre)-1), nombre) n1,  -- primer nombre
if(locate(' ', nombre)=0, null, mid(nombre, locate(' ', nombre)+1) ) n2    -- segundo nombre
from alumnos;

select distinct nombre,  
if(locate(' ', nombre)>0, left(nombre, locate(' ', nombre)-1), nombre) n1,  
if(locate(' ', nombre)=0, null, mid(nombre, locate(' ', nombre)+1) ) n2   
from alumnos
having n2 is not null;

-- select nombre, repeat('-',length(nombre)) caract from alumnos;

select nombre, replace(nombre,'E','*') from alumnos; -- (si distingue de mayusculas y minusculas)

select nombre, left(nombre,2) from alumnos;

select sysdate();

select sysdate(), date_format(sysdate(), '%Y') anio;
select sysdate() fecha, date_format(sysdate(), '%M') mes;
select sysdate() fecha, date_format(sysdate(), '%d') dia;	
select sysdate() fecha, date_format(sysdate(), '%W') dia_nombre;
select sysdate() fecha, date_format(sysdate(), '%j') dia_anio_numero;	

set lc_time_names = 'es_Mx';						-- PASAR A ESPAÑOL LAS FECHAS

select '1997-09-17' fecha, date_format('1997-09-17', '%Y') anio;	-- 1997
select '1997-09-17' fecha, date_format('1997-09-17', '%y') anio;	--  97

select '1997-09-17' fecha, date_format('1997-09-17', '%M') mes;		-- nombre
select '1997-09-17' fecha, date_format('1997-09-17', '%m') mes;		-- numero

select '1997-09-17' fecha, date_format('1997-09-17', '%D') dia;		-- 17th
select '1997-09-17' fecha, date_format('1997-09-17', '%d') dia;		-- 17

select '1997-09-17' fecha, date_format('1997-09-17', '%W') dia_semana_nombre;		-- nombre del dia de la semana	
select '1997-09-17' fecha, date_format('1997-09-17', '%w') dia_semana_nombre;		-- numero del dia de la semana

select '1997-09-17' fecha, date_format('1997-09-17', '%j') dia_anio_numero;		-- numero del dia del año

select date_format(sysdate(), 'Hoy es %W %d de %M del %Y') fecha;

set @variable_e = 24;

select @variable_e + 4;

set @variable_e = 'hola';

select @variable_e;
select left(@variable_e,1);

use colegio2459;

select distinct fedita,
date_format(fedita, '%Y') anio, date_format(fedita, '%m') mes,
date_format(fedita, '%d') dia, date_format(fedita, '%H') hora,
date_format(fedita, '%i') minutos, date_format(fedita, '%s') segundos,
date_format(fedita, '%u') semana, date_format(fedita, '%k') h24,
date_format(fedita, '%u') semana, date_format(fedita, '%h') h12,
date_format(fedita, '%j') diaanio
from alumnos;

select clave_alu, nombre, fedita from alumnos
where date_format(fedita,'%Y') = '2017';

select clave_alu, nombre, fedita from alumnos	-- es lo mismo que el anterior
where year(fedita) = 2017;

select date_format(fedita,'%Y') anio, count(*)from alumnos
group by date_format(fedita,'%Y');

select distinct year(fedita) anio from alumnos;

select second(sysdate());

select sysdate(), date_add(sysdate(), interval 1 day) nueva_fecha;
select sysdate(), date_add(sysdate(), interval 1 year) nueva_fecha;
select sysdate(), date_add(sysdate(), interval 	-10 minute) nueva_fecha;

select distinct fedita, datediff(now(),fedita) difdias from alumnos;

set @fecha = '1997-09-17 12:38:34';
select now(), timestampdiff(year, @fecha, now()) aniosdif;

select fedita, timestampdiff(year, fedita, now()) tiempo from alumnos;

select @fecha, timestampdiff(day, @fecha, now()) dif_dias;

select @fecha, extract(day from @fecha) dia, extract(month from @fecha) mes, extract(year from @fecha) anio;

-- edad a partir del curp
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

use proyecto_bd1_2459;

-- PRODUCTO CARTESIANO
select * from entidades e, productor p
order by e.id_entidades, p.id_productor;

		-- CONVIRTIENDOLO EN UN JOIN 
        select * from entidades e, productor p
		WHERE e.id_entidades = p.id_entidades;

use colegio2459;

select * from salones s, grados g, niveles n, cursos c
where s.id_grado = g.id_grado
and s.id_nivel = n.id_nivel
and s.id_curso = c.id_curso;

select s.id_salon, observaciones salon, tipo_grupo, g.nombre grado, 
n.nombre nivel, c.nombre curso
from salones s, grados g, niveles n, cursos c
where s.id_grado = g.id_grado
and s.id_nivel = n.id_nivel
and s.id_curso = c.id_curso
order by 1;

select * from salones;
select * from niveles;
select*from grados;

select s.id_salon, observaciones salon, tipo_grupo, g.nombre grado, 
n.nombre nivel, c.nombre curso
from salones s, grados g, niveles n, cursos c
where s.id_grado = g.id_grado
and s.id_nivel = n.id_nivel
and s.id_curso = c.id_curso
and n.nombre = 'bachillerato' and g.nombre = '6o'
order by 1;

select s.id_salon, observaciones salon, tipo_grupo, g.nombre grado, 
n.nombre nivel, c.nombre curso
from salones s 
join grados g using(id_grado)
join niveles n using(id_nivel)
join cursos c using(id_curso)
where n.nombre like 'bachillerato' and g.nombre like '6o'
order by 1;

select*from pagos;
select*from alumnos;

select p.clave_alu, concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, count(*) pagos, sum(pago) from pagos p, alumnos a
where p.clave_alu = a.clave_alu 
group by 1, alumno;

select p.clave_alu, concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, count(*) pagos, sum(pago) from pagos p, alumnos a
where p.clave_alu = a.clave_alu and a.sexo = 'f'
group by 1, alumno;

select * from alumnos
where clave_alu in(select distinct clave_alu from pagos);

select * from alumnos
where clave_alu not in(select distinct clave_alu from pagos);

select * from pagos p join alumnos a on (p.clave_alu = a.clave_alu);

select * from pagos p join alumnos a on (p.clave_alu = a.clave_alu)
where a.sexo = 'f';

select * from pagos p join alumnos a using (clave_alu);

select * from pagos p natural join alumnos a;

select concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, count(*) npagos from pagos p
join alumnos a on (p.clave_alu = a.clave_alu)
group by a.clave_alu
order by 2 desc;

select * from alumnos a left join pagos p on(p.clave_alu = a.clave_alu)
order by 1 desc;



select*from niveles;

-- mostrando salones
select * from salones;

-- JOIN
select * from niveles n JOIN salones s ON(n.id_nivel = s.id_nivel);

-- LEFT JOIN. Muestra el join normal y ademas los registros de la tabla de la izquierda que no estan en el join principal
select * from niveles n LEFT JOIN salones s ON(n.id_nivel = s.id_nivel);

select * from niveles n right join salones s ON(n.id_nivel = s.id_nivel);
-- where n.id_nivel in (1,2,5,6,7); -- con esto se puede ver que los niveles 1,2,5,6 y 7 no tienen presencia en la tabla salones

-- niveles que no tienen salon
select * from niveles n LEFT JOIN salones s ON(n.id_nivel = s.id_nivel)
WHERE s.id_nivel is null;

select * from salones s right JOIN niveles n ON(n.id_nivel = s.id_nivel) -- lo mismo que el anterior
WHERE s.id_nivel is null;

-- alumnos que no han hecho pagos
select * from alumnos a left join pagos p on (a.clave_alu = p.clave_alu)
where p.clave_alu is null;

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

select*	-- es lo mismo que lo anterior
from pagos p left JOIN alumnos a ON(p.clave_alu = a.clave_alu)
where a.clave_alu is null 
order by 1 desc; 

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

select z.tipo, count(*) npersonas from
(select clave_alu ,'alumno' tipo from alumnos
union 
select clave_prof, 'profesor' tipo from profesores) z
group by tipo;

create or replace view alumnos_pagos as
select i.matricula, alumnos, count(pago) npagos, ifnull(sum(pago), 0) tpagos
from inscritos i LEFT JOIN pagos p ON(i.matricula = p.clave_alu)
group by i.matricula;



create database if not exists repaso_examen;

use repaso_examen;

drop table if exists personal;
create table personal(
	id int not null auto_increment primary key,
    nombre varchar(20) not null,
    ap_paterno varchar(20) not null,
    ap_materno varchar(20) not null,
    fnac date null,
    casas int not null,
    unique key uk_nombre_completo(nombre, ap_paterno, ap_materno)
);

drop table if exists producto;
create table producto(
	id int not null auto_increment primary key,
    nombre varchar(20) not null,
    fcreacion date null,
    costo int not null,
    pais_reg varchar(20) null,
    unique key uk_producto(nombre,fcreacion,pais_reg)
);

drop table if exists certificacion;
create table certificacion(
	id int not null auto_increment primary key,
    nombre varchar(20) not null,
    fecha date null,
    anios_val int not null,
    otorga varchar(20) null,
    id_personal int not null,
    unique key uk_certificacion(nombre,otorga,fecha),
    foreign key (id_personal) references personal(id)
    on delete cascade on update cascade
);

alter table personal add unique index uk_unico(nombre, casas);
alter table producto add unique index uk_prd(costo,pais_reg);
alter table certificacion add unique index uk_cert(nombre,id_personal,anios_val);

alter table producto drop index uk_prd;

alter table producto add column precio int null after costo;

alter table producto modify precio decimal(10,2) null;

rename table personal to empleado;

alter table certificacion drop column otorga;

alter table producto modify id int not null;
alter table producto drop primary key;

insert into producto values(1,'d',null,34,34,null),(2,'g',null,34,34,null),(3,'b',null,34,34,null),(3,'e',null,34,34,null),(4,'f',null,34,34,null);

insert into empleado (id,nombre,ap_paterno,ap_materno,casas) values (null,'d','ds','fds',2),(null,'g','dds','fasds',1),(null,'df','dfdsa','faf',2),(null,'dddsa','sagrth','trhdss',4),(null,'dsdaf','dens','fdvvvs',6);

insert into certificacion set id = 1, nombre = 'fdsdf', id_personal = '1', anios_val = 2;

delete from empleado where id = 1;

select * from certificacion;

create table producto_tmp select * from producto;
create table emple_tmp like empleado;

select * from information_schema.tables where table_schema = 'repaso_examen';

-- drop database if exists repaso_examen;

use colegio2459;

select * from alumno_salon; 
select*from salones;
select*from cursos;

-- 1.
select concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, s.observaciones salon, c.nombre curso from alumno_salon aas
join alumnos a on (aas.clave_alu = a.clave_alu)
join salones s on (aas.id_salon = s.id_salon)
join cursos c on (aas.id_curso = c.id_curso)
order by 1;

-- 2.
select*from evaluaciones;

select concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, count(*) nmaterias from evaluaciones e
join alumnos a using (clave_alu)
group by e.clave_alu
order by 2 desc, 1;

-- 3. 
select a.clave_alu , concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) alumno, e.calificacion calificaciones, c.nombre curso
from evaluaciones e
join alumnos a on (e.clave_alu = a.clave_alu)
join cursos c using(id_curso)
order by 2, 3 desc;

-- 4. 
select * from pagos;

select concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre) nombre, c.nombre curso, count(*) tpagos
from pagos p
join alumnos a on (a.clave_alu = p.clave_alu)
join cursos c on (p.id_curso = c.id_curso)
group by concat_ws(' ', a.ap_paterno, a.ap_materno, a.nombre), c.nombre
order by 3 desc, 1;

-- 5. 
select * from salones;
select * from grados;
select * from profesor_grupo;
select id_salon from salones s join grados g using (id_grado) where g.nombre = '2o'; -- salones de 2o

select distinct concat_ws(' ', p.apellido_p, p.apellido_m, p.nombres) profesor
from profesor_grupo pg
join (select id_salon from salones s join grados g using (id_grado) where g.nombre = '2o') s on (pg.id_salon = s.id_salon)
join profesores p on (pg.clave_prof = p.clave_prof) ;



-- lo mismo pero mas largo
select concat_ws(' ', p.apellido_p, p.apellido_m, p.nombres) profesor		-- consulta final mostrando solo los nombres
from																	 
(select distinct pg.clave_prof prof										
from 
	(select s.id_salon salon, s.observaciones salon_nombre, g.nombre grado 
	from salones s JOIN grados g ON (s.id_grado = g.id_grado)
	where g.nombre = '2o') x 
JOIN profesor_grupo pg ON(x.salon = pg.id_salon) ) y
JOIN profesores p ON(y.prof = p.clave_prof)
order by 1;



use colegio2459;
select * from pagos p right join alumnos a on (p.clave_alu = a.clave_alu)
where p.clave_alu is null;
select * from pagos p join alumnos a on (p.clave_alu = a.clave_alu);


-- Mostrando la central electrica con mayor capacidad
-- Contar el numero de centrales solares de tipo fotovoltaica
-- 6. Contando el numero de transformadores de todas la estaciones en total
-- 7. Total de energia intercambiada entre redes por dia
-- 8. productores que entraron en funcionamiento entre una fecha