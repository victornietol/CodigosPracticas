create database if not exists prueba_bd;

use prueba_bd;
select * from escritor;
select * from libro;

CREATE TABLE escritor (
id_escritor INT NOT NULL auto_increment primary key, 
nombre VARCHAR(30) NULL, 
apellidos VARCHAR(40)  NULL, 
direccion VARCHAR(100) NULL,
alias VARCHAR(30) NULL DEFAULT 'NA'
) ;

drop table libro;
CREATE TABLE libro(
	id_libro INT NOT NULL auto_increment PRIMARY KEY,
    id_escritor INT NOT NULL,
    titulo VARCHAR(200)  NULL UNIQUE,
    contenido TEXT NULL,
    FOREIGN KEY (id_escritor) REFERENCES escritor(id_escritor) 
    ON DELETE cascade ON UPDATE CASCADE 
);

insert into escritor (id_escritor) values (null),(null),(null),(null);
insert into libro (id_libro, id_escritor) values (null, 1),(null, 2),(null, 2),(null, 3);

delete from escritor where id_escritor = '2';
update escritor set id_escritor = id_escritor + 10;