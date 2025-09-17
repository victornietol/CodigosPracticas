create database prueba_100k_rows;
use prueba_100k_rows;

create table usuarios(
	id int auto_increment primary key,
    nombre varchar(100) not null,
    apellido_p varchar(100) not null,
    apellido_m varchar(100) not null,
    email varchar(100) not null,
    telefono varchar(100) not null,
    ciudad varchar(100) not null
);

create index idx_nombre on usuarios(nombre);
create index idx_nombre_id_apellido on usuarios(id, nombre, apellido_p);
create index idx_email on usuarios(email);
create index idx_telefono on usuarios(telefono);

SHOW VARIABLES LIKE 'secure_file_priv';
SHOW VARIABLES LIKE 'local_infile';

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data_fake_100k.csv'
into table usuarios
fields terminated by ','
lines terminated by '\n'
ignore 1 rows
(nombre, apellido_p, apellido_m, email, telefono, ciudad);

select nombre from usuarios;
select id, nombre, apellido_p from usuarios;
select email from usuarios;
select telefono from usuarios;
select * from usuarios;