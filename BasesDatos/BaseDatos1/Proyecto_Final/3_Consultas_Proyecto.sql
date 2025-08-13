USE proyecto_bd1_2459;

-- 1. Contando cuantas estaciones, subestaciones, redes de distribucion, lineas y zonas de servicio hay de cada una
select TIPO, count(*) CANTIDAD
from
(select nombre NOMBRE, 'ESTACION PRIMARIA' TIPO from estacion
UNION
select nombre, 'SUBESTACION' TIPO from subestacion
UNION
select num_red, 'RED DE DISTRIBUCION' TIPO from red
UNION
select num_linea, 'LINEA' TIPO from linea
UNION
select nombre, 'ZONA DE SERVICIO' TIPO from zona) t
group by 1;



-- 2. Mostrando las entidades que tienen mas de 4 zonas de servicio y cuales son esas zonas
select Entidad, group_concat(Zona) Zonas, count(*) Num_Zonas from (
select z.nombre zona, e.nombre Entidad
from entidades e join zona z using(id_entidades)
order by 2,1) x
group by Entidad
having Num_zonas > 4
order by 1;



-- 3. Mostrando los países que no tienen suministradores
select p.nombre Pais from pais p left join suministrador s on (p.id_pais = s.id_pais) 
where s.id_pais is null;



-- 4. Listando los suministradores y a que pais pertenecen
select s.nombre Suministrador, p.nombre Pais
from suministrador s 
join pais p using(id_pais)
order by 1;



-- 5. Mostrando que redes intercambian energía, la cantidad de energía que intercambian entre cada una ellas, y la fecha del intercambio. Además, al final se muestra el total de energia intercambiada entre todas
select r1.num_red Red, r2.num_red Intercambia_con, format(ie.energia_inter,2) Energia, ie.fecha Fecha 
from intercambia_energia ie
join red r1 using(id_red)
join red r2 on (ie.id_intercambia_con = r2.id_red)
union 		
select 'Total', '', format(sum(energia_inter),2), '' from intercambia_energia;



-- 6. Mostrando los productores y las centrales que tienen
select Productor, RFC, group_concat(Central) Centrales from (
select c.nombre Central, p.razon_social Productor, p.rfc RFC, p.id_productor id, c.id_central idcentral
from hidroelectrica h 
join centrales c using(id_central)
join productor p using(id_productor)
union 
select c.nombre Central, p.razon_social Productor, p.rfc RFC, p.id_productor id, c.id_central idcentral
from solar s 
join centrales c using(id_central)
join productor p using(id_productor)
union 
select c.nombre Central, p.razon_social Productor, p.rfc RFC, p.id_productor id, c.id_central idcentral
from nuclear n 
join centrales c using(id_central)
join productor p using(id_productor)
union 
select c.nombre Central, p.razon_social Productor, p.rfc RFC, p.id_productor id, c.id_central idcentral
from termica t
join centrales c using(id_central)
join productor p using(id_productor)  ) x
group by Productor
order by 1;



-- 7. Mostrando al productor con mayor producción y que además entró en funcionamiento apartir del año 2000
select p.razon_social Productor, p.rfc RFC, p.produccion_med Prod_Med, p.produccion_max Prod_Max, p.fecha_func FFuncionamiento, e.nombre Entidad_Fed 
from productor p join entidades e using(id_entidades)
where (select max(produccion_max) from productor where year(fecha_func) >= 2000) = p.produccion_max;



-- 8. Mostrando los 3 productores con menor producción media y mostrando la fecha de entrada en funcionamiento de forma distinta
SET lc_time_names = 'es_Mx';
select razon_social Productor, produccion_med Prod_Media, date_format(fecha_func, 'Comenzo a operar el dia %W %d de %M del anio %Y') Fecha_funcionamiento 
from productor 
order by produccion_med
limit 3;



-- 9. Listando los productores y a que estaciones le entregaron energía. Además se muestra la cantidad total de energía entregada por cada productor
select p.razon_social Productor, group_concat(e.nombre) Estaciones, sum(ee.energia_entregada) Total_energia 
from entregar_energia ee 
join productor p using(id_productor)
join estacion e using(id_estacion)
group by p.razon_social
order by 3 desc;



-- 10. Mostrando las subestaciones que distribuyeron a distintas zonas en el mes de agosto entre el año 2018 y 2020 
select s.nombre Subestacion, z.nombre Zona, d.fecha_inic Fecha 
from distribuye d
join subestacion s using(id_subestacion)
join zona z using(id_zona)
where date_format(fecha_inic, '%M') = 'agosto'
and year(fecha_inic) between 2018 and 2020 
order by 3;



-- 11. Mostrando la longitud total de cada red al sumar la longitud de las lineas que tiene cada red. También se muestra a que compañías pertenece cada red
select r.num_red Red, l.longitud_tot Longitud_Total, group_concat(c.nombre) Companias from red_compania rd
join (
select id_red, num_linea, format(sum(longitud),2) longitud_tot 
from linea 
group by id_red) l on (rd.id_red = l.id_red)
join compania c on (rd.id_compania = c.id_compania)
join red r on (rd.id_red = r.id_red)
group by r.num_red
order by 1;



-- 12. Mostrando cual es la zona con el consumedio medio más alto de la categoria de consumidores empresas en el mes de noviembre sin importar el año
SET lc_time_names = 'es_Mx';
select z.nombre Zona, cc.nombre Tipo_Consumidor, ic.consumo_medio Consumo_medio, date_format(ic.fecha,'%d de %M del %Y') Fecha
from info_consumidor ic
join consumidores_cat cc using(id_consumidor)
join zona z using(id_zona)
where (select max(consumo_medio) from info_consumidor
where (select id_consumidor from consumidores_cat where nombre = 'EMPRESAS') = id_consumidor 
and date_format(fecha, '%M') = 'noviembre') = consumo_medio;



-- 13. Mostrando el número total de consumidores de cada categoria del año 2019 y del mes de marzo
SET lc_time_names = 'es_Mx';
select cc.nombre Tipo_Consumidor, sum(ic.num_consumidores) Total_consumidores, date_format(ic.fecha,'%M de %Y') Mes_Anio from info_consumidor ic
join consumidores_cat cc using(id_consumidor)
where (select id_consumidor from consumidores_cat where nombre = 'PARTICULARES') = ic.id_consumidor
and year(ic.fecha) = 2019
and date_format(ic.fecha,'%M') = 'marzo'
union
select cc.nombre Tipo_Consumidor, sum(ic.num_consumidores) Total_consumidores, date_format(ic.fecha,'%M de %Y') Mes_Anio from info_consumidor ic
join consumidores_cat cc using(id_consumidor)
where (select id_consumidor from consumidores_cat where nombre = 'EMPRESAS') = ic.id_consumidor
and year(ic.fecha) = 2019
and date_format(ic.fecha,'%M') = 'marzo'
union
select cc.nombre Tipo_Consumidor, sum(ic.num_consumidores) Total_consumidores, date_format(ic.fecha,'%M de %Y') Mes_Anio from info_consumidor ic
join consumidores_cat cc using(id_consumidor)
where (select id_consumidor from consumidores_cat where nombre = 'INSTITUCIONES') = ic.id_consumidor
and year(ic.fecha) = 2019
and date_format(ic.fecha,'%M') = 'marzo';



-- 14. Mostrando en que año se tiene el consumedio medio total más bajo de la categoria instituciones apoyandose en la creación de una vista para poder obtener el resultado final
create or replace view consumo_anio as
select *, year(fecha) anio, cast(sum(consumo_medio) as decimal(10,2) ) con_med_t 
from info_consumidor 
where (select id_consumidor from consumidores_cat where nombre = 'INSTITUCIONES') = id_consumidor
group by year(fecha);

select ca.anio Anio, ca.con_med_t Consumo_Med_Total , cc.nombre Tipo_Consumidor 
from consumo_anio ca
join consumidores_cat cc on(ca.id_consumidor = cc.id_consumidor)
where (select min(con_med_t) from consumo_anio) = con_med_t;



-- 15. Mostrando las lineas que tienen una longitud mayor a 45000 con sus respectivas redes y estaciones con las que tienen relación
select l.num_linea Linea, l.longitud Longitud_linea, x.num_red Red, x.estacion Estacion from linea l
join (select r.id_red id_red, r.num_red num_red, e.nombre estacion from red r join estacion e using(id_estacion) ) x
using(id_red)
where longitud > 45000;



-- 16. Mostrando la central nuclear con mayor volumen de residuos y a que productor pertenece
select c.nombre Central, n.vol_residuos Volumen_Residuos, p.razon_social Productor 
from nuclear n 
join productor p using(id_productor)
join centrales c using(id_central)
where (select max(vol_residuos) from nuclear) = n.vol_residuos;



-- 17. Mostrando los portes con fecha de realización entre julio y septiembre. Además, al final se muestra el total de portes realizados en ese periodo
select p.id_porte Num_porte, t.razon_social Transportista, p.descripcion Descripcion, p.fecha_realizacion Realizado 
from porte p
join transportista t using(id_transportista)
where date_format(fecha_realizacion,'%m') >= 7 and date_format(fecha_realizacion,'%m') <= 9
union
select '','','',''
union
select '','','Total de portes:',count(id_porte) from porte
where date_format(fecha_realizacion,'%m') >= 7 and date_format(fecha_realizacion,'%m') <= 9;



-- 18. Mostrando los datos de la venta con menor cantidad de plutonio  
select x.num_venta Num_venta, x.vendedor Vendedor, p.razon_social Comprador, c.nombre Central, x.id_porte Num_porte, t.razon_social Transportista, x.descripcion Descripcion, x.cantidad_plutonio Cant_plutonio, x.fecha FCompra, x.fecha_realizacion FRealizacion_Transporte
from (
select id_venta num_venta, nombre vendedor, id_central, id_productor, id_porte, id_transportista, v.descripcion descripcion, cantidad_plutonio, fecha, fecha_realizacion 
from ventas v
join suministrador s using(id_suministrador)
join nuclear n using(id_nuclear)
join porte p using(id_porte)
where (select min(cantidad_plutonio) from ventas) = cantidad_plutonio) x
join centrales c on (x.id_central = c.id_central)
join productor p on (x.id_productor = p.id_productor)
join transportista t on (x.id_transportista = t.id_transportista);



-- 19. Mostrando la central que ha comprado una mayor cantidad de plutonio y el total de plutinio de esas compras. Se utiliza la creación de una vista para almacenar el número de compras de cada central y el total de plutonio de las compras, después con la ayuda de esta vista se obtiene el resultado final de la consulta
create or replace view total_plutonio as
select id_nuclear, descripcion, count(id_nuclear) n_compras, cast(sum(cantidad_plutonio) as decimal(10,2)) plut_total from ventas
group by id_nuclear;

select c.nombre Central, p.razon_social Pertenece_a, z.n_compras Num_compras, z.plut_total Plutonio_Total, z.descripcion Descripcion 
from (
select tp.*, n.id_productor, n.id_central from total_plutonio tp
join nuclear n using(id_nuclear)
where (
select min(plut_total) p_t_min from (
select cast(sum(cantidad_plutonio) as decimal(10,2)) plut_total from ventas
group by id_nuclear) x
) = plut_total ) z
join productor p on (z.id_productor = p.id_productor)
join centrales c on (z.id_central = c.id_central);



-- 20. Mostrando las 5 zonas que cuentan con un mayor número de subestaciones que las atienden
select z.nombre Zona, count(*) Num_subest, group_concat(s.nombre) Subestaciones 
from distribuye d
join zona z using (id_zona)
join subestacion s using (id_subestacion)
group by d.id_zona
order by count(*) desc
limit 5;
