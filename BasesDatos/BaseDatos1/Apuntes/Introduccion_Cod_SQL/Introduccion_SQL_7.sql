use libros2459;
show tables;
desc editorial;
select * from editorial;

-- insertando datos
insert into editorial values (null,'Sexto piso', 'CDMX'), (null,'Fondo de cultura economica', 'CDMX'),(null,'Trillas', 'MTY');

-- cambiar tabla desde el servidor
alter table editorial add unique index uk_rfc (rfc),
add comentarios text null;
