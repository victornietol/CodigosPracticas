use pruebas;

create table if not exists clientes_tienda(
	id_cliente int auto_increment,
    nombre varchar(100) not null,
    ciudad varchar(50) not null,
    primary key(id_cliente)
);

create table if not exists ventas_tienda(
	id_venta int auto_increment,
    id_cliente int not null,
    fecha date not null,
    valor bigint not null,
    primary key (id_venta),
    foreign key (id_cliente) references clientes_tienda(id_cliente)
);


/* DATOS */
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data_prueba.csv' 
INTO TABLE ventas_tienda
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


/* CONSULTA */
with total_por_cliente as (
	select
		c.id_cliente as id_cliente,
		c.nombre as nombre,
		coalesce(sum(v.valor), 0) as total_comprado
	from clientes_tienda as c
	left join ventas_tienda as v on (v.id_cliente = c.id_cliente)
	group by c.id_cliente, c.nombre
),
segmentos as (
	select
		id_cliente,
		nombre,
		total_comprado,
		case
			when total_comprado >= 20000 then 'oro'
			when total_comprado >= 8000 then 'plata'
			when total_comprado < 8000 and total_comprado > 0 then 'bronce'
			else 'sin compras'
		end as segmento
	from total_por_cliente
)
select
	segmento,
    count(*) as clientes,
    sum(total_comprado) as total_vendido
from segmentos
group by segmento
order by total_vendido desc;
