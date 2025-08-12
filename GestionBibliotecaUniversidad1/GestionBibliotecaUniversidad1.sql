create database biblioteca_universidad_1;
use biblioteca_universidad_1;

create table tipo_sanciones(
	id int not null auto_increment,
    descripcion varchar(200) not null,
    activo tinyint(1) not null,
    primary key (id),
    unique key uk_descripcion (descripcion)
);

create table tipo_usuario(
	id int not null auto_increment,
    nombre varchar(50),
    activo tinyint(1) not null,
    primary key (id),
    unique key uk_nombre (nombre)
);

create table usuario(
	id int not null auto_increment,
    clave varchar(20) not null,
    nombre varchar(50) not null,
    apellido_p varchar(50) not null,
    apellido_m varchar(50) not null,
    correo varchar(80) not null,
    telefono varchar(12) not null,
    activo tinyint(1) not null,
    primary key (id),
    unique key uk_clave (clave),
    unique key uk_nombre_completo (nombre, apellido_p, apellido_m)
);

create table sanciones(
	id int not null auto_increment,
    id_tipo int not null,
    id_usuario int not null,
    fecha datetime not null,
    activo tinyint(1) not null,
    primary key (id),
    foreign key (id_tipo) references tipo_usuario(id)
		on delete cascade on update cascade,
	foreign key (id_usuario) references usuario(id)
		on delete cascade on update cascade
);

create table categoria(
	id int not null auto_increment,
    nombre varchar(20) not null,
    activo tinyint(1) not null,
    primary key (id),
    unique key uk_categoria (nombre)
);

create table editorial(
	id int not null auto_increment,
    nombre varchar(70) not null,
    activo tinyint(1) not null,
    primary key (id),
    unique key uk_nombre (nombre)
);

create table libro(
	id int not null auto_increment,
    titulo varchar(100) not null,
    anio_publicacion year not null,
    no_paginas smallint unsigned not null,
    edicion varchar(20) not null,
    id_editorial int not null,
    activo tinyint(1) not null,
    primary key (id),
    foreign key (id_editorial) references editorial(id)
		on delete cascade on update cascade
);

create table autor(
	id int not null auto_increment,
    nombre varchar(50) not null,
    apellido_p varchar(50) not null,
    apellido_m varchar(50) null,
    activo tinyint(1) not null,
    primary key (id),
    unique key uk_nombre_completo (nombre, apellido_p, apellido_m)
);

create table libro_autor(
    id_libro int not null,
    id_autor int not null,
    activo tinyint(1) not null,
    primary key (id_libro, id_autor),
    foreign key (id_libro) references libro(id)
		on delete cascade on update cascade,
	foreign key (id_autor) references autor(id)
		on delete cascade on update cascade
);

create table categoria_libro(
	id_categoria int not null,
    id_libro int not null,
    activo tinyint(1) not null,
    primary key (id_categoria, id_libro),
    foreign key (id_categoria) references categoria(id)
		on delete cascade on update cascade,
	foreign key (id_libro) references libro(id)
		on delete cascade on update cascade
);

create table ejemplar_libro(
	id int not null auto_increment,
    id_libro int not null unique,
    activo tinyint(1) not null,
    primary key (id),
    foreign key (id_libro) references libro(id)
		on delete cascade on update cascade
);

create table prestamo(
	id int not null auto_increment,
    fecha_inicio datetime not null,
    fecha_fin datetime not null,
    id_usuario int not null,
    id_ejemplar int not null,
    activo tinyint(1) not null,
    primary key (id),
    foreign key (id_usuario) references usuario(id)
		on delete cascade on update cascade,
	foreign key (id_ejemplar) references ejemplar_libro(id)
		on delete cascade on update cascade
);