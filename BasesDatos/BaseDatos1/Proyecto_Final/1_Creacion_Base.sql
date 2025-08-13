-- TABLAS
DROP DATABASE IF EXISTS proyecto_bd1_2459;
CREATE DATABASE IF NOT EXISTS proyecto_bd1_2459;

USE proyecto_bd1_2459;

DROP TABLE IF EXISTS pais;
CREATE TABLE pais(
	id_pais int NOT NULL AUTO_INCREMENT,
    nombre varchar(70) NOT NULL,
    PRIMARY KEY (id_pais),
    UNIQUE KEY uk_nombre(nombre)
);

DROP TABLE IF EXISTS entidades;
CREATE TABLE entidades(
	id_entidades int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    codigo int(3) unsigned zerofill NOT NULL,
    abreviatura varchar(4) NOT NULL,
    PRIMARY KEY (id_entidades),
    UNIQUE KEY uk_nombre(nombre),
    UNIQUE KEY uk_codigo(codigo),
    UNIQUE KEY uk_abreviatura(abreviatura)
);

DROP TABLE IF EXISTS productor;
CREATE TABLE productor(
	id_productor int NOT NULL AUTO_INCREMENT,
    razon_social varchar(70) NOT NULL,
    rfc varchar(13) NOT NULL,
    produccion_med float NOT NULL,
    produccion_max float NOT NULL,
    id_entidades int NOT NULL,
	fecha_func date NOT NULL,
    PRIMARY KEY (id_productor),
    UNIQUE KEY uk_razon_social(razon_social),
    UNIQUE KEY uk_rfc(rfc),
    FOREIGN KEY (id_entidades) REFERENCES entidades(id_entidades)
    ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS centrales;
CREATE TABLE centrales(
	id_central int NOT NULL AUTO_INCREMENT,
	nombre varchar(14) NOT NULL,
	PRIMARY KEY (id_central),
	UNIQUE KEY uk_nombre(nombre)
);

DROP TABLE IF EXISTS productor_centrales;
CREATE TABLE productor_centrales(
	id int NOT NULL AUTO_INCREMENT,
    id_productor int NOT NULL,
    id_central int NOT NULL,
    fecha_fundacion date NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_productor) REFERENCES productor(id_productor)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_central) REFERENCES centrales(id_central)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS hidroelectrica;
CREATE TABLE hidroelectrica(
	id_hidroelectrica int NOT NULL AUTO_INCREMENT,
    id_productor int NOT NULL,
    id_central int NOT NULL,
    ocupacion varchar(200) NOT NULL,
    capacidad_max float NOT NULL,
    num_turbinas int NOT NULL,
    PRIMARY KEY (id_hidroelectrica),
    FOREIGN KEY (id_productor) REFERENCES productor(id_productor)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_central) REFERENCES centrales(id_central)
    ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY uk_hidro_productor(id_hidroelectrica, id_productor)
);

DROP TABLE IF EXISTS solar;
CREATE TABLE solar(
	id_solar int NOT NULL AUTO_INCREMENT,
    id_productor int NOT NULL,
    id_central int NOT NULL,
    paneles_solares float NOT NULL,
    horas_sol int NOT NULL,
    tipo varchar(13) NOT NULL,
    PRIMARY KEY (id_solar),
    FOREIGN KEY (id_productor) REFERENCES productor(id_productor)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_central) REFERENCES centrales(id_central)
    ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY uk_solar_productor(id_solar, id_productor)
);

DROP TABLE IF EXISTS nuclear;
CREATE TABLE nuclear(
	id_nuclear int NOT NULL AUTO_INCREMENT,
    id_productor int NOT NULL,
    id_central int NOT NULL,
    num_reactores int NOT NULL,
    vol_plutonio float NOT NULL,
    vol_residuos int NOT NULL,
    PRIMARY KEY (id_nuclear),
    FOREIGN KEY (id_productor) REFERENCES productor(id_productor)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_central) REFERENCES centrales(id_central)
    ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY uk_nuclear_productor(id_nuclear, id_productor)
);

DROP TABLE IF EXISTS termica;
CREATE TABLE termica(
	id_termica int NOT NULL AUTO_INCREMENT,
    id_productor int NOT NULL,
    id_central int NOT NULL,
    num_hornos int NOT NULL,
    vol_carbon float NOT NULL,
    vol_gases float NOT NULL,
    PRIMARY KEY (id_termica),
    FOREIGN KEY (id_productor) REFERENCES productor(id_productor)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_central) REFERENCES centrales(id_central)
    ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY uk_termica_productor(id_termica, id_productor)
);

DROP TABLE IF EXISTS suministrador;
CREATE TABLE suministrador(
	id_suministrador int NOT NULL AUTO_INCREMENT,
    nombre varchar(100) NOT NULL,
    id_pais int NOT NULL,
    PRIMARY KEY (id_suministrador),
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS transportista;
CREATE TABLE transportista(
	id_transportista int NOT NULL AUTO_INCREMENT,
    razon_social varchar(70) NOT NULL,
    rfc varchar(13) NOT NULL,
    PRIMARY KEY (id_transportista),
    UNIQUE KEY uk_razon_social(razon_social),
    UNIQUE KEY uk_rfc(rfc)
);

DROP TABLE IF EXISTS porte;
CREATE TABLE porte(
	id_porte int NOT NULL AUTO_INCREMENT,
    id_transportista int NOT NULL,
    descripcion varchar(250) DEFAULT 'TRANSPORTE PLUTONIO',
    fecha_registro datetime NOT NULL,
    fecha_realizacion datetime NOT NULL,
    PRIMARY KEY (id_porte),
    FOREIGN KEY (id_transportista) REFERENCES transportista(id_transportista)
    ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS ventas;
CREATE TABLE ventas(
	id_venta int NOT NULL AUTO_INCREMENT,
    id_suministrador int NOT NULL,
    id_nuclear int NOT NULL,
    id_porte int NOT NULL,
    descripcion varchar(250) DEFAULT 'VENTA PLUTONIO',
    cantidad_plutonio float NOT NULL,
    fecha datetime NOT NULL,
    PRIMARY KEY (id_venta),
    FOREIGN KEY (id_suministrador) REFERENCES suministrador(id_suministrador)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_nuclear) REFERENCES nuclear(id_nuclear)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_porte) REFERENCES porte(id_porte)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    UNIQUE KEY uk_venta_porte(id_venta, id_porte)
);

DROP TABLE IF EXISTS estacion;
CREATE TABLE estacion(
	id_estacion int NOT NULL AUTO_INCREMENT,
    nombre varchar(70) NOT NULL,
    num_transformadores int NOT NULL,
    PRIMARY KEY (id_estacion),
    UNIQUE KEY uk_nombre(nombre)
);

DROP TABLE IF EXISTS entregar_energia;
CREATE TABLE entregar_energia(
	id int NOT NULL AUTO_INCREMENT,
    id_productor int NOT NULL,
    id_estacion int NOT NULL, 
    energia_entregada int NOT NULL,
    fecha date NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_productor) REFERENCES productor(id_productor)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_estacion) REFERENCES estacion(id_estacion)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS red;
CREATE TABLE red(
	id_red int NOT NULL AUTO_INCREMENT,
    id_estacion int NOT NULL,
    num_red int NOT NULL,
    PRIMARY KEY (id_red),
    FOREIGN KEY (id_estacion) REFERENCES estacion(id_estacion)
    ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY uk_n_red(num_red)
);

DROP TABLE IF EXISTS intercambia_energia;
CREATE TABLE intercambia_energia(
	id int NOT NULL AUTO_INCREMENT,
    id_red int NOT NULL,
    id_intercambia_con int NOT NULL,
    energia_inter float NOT NULL,
    fecha date NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_red) REFERENCES red(id_red)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_intercambia_con) REFERENCES red(id_red)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    UNIQUE KEY uk_redes_intercambio_dia(id_red, id_intercambia_con, fecha)
);

DROP TABLE IF EXISTS compania;
CREATE TABLE compania(
	id_compania int NOT NULL AUTO_INCREMENT,
    nombre varchar(70) NOT NULL,
    PRIMARY KEY (id_compania),
    UNIQUE KEY uk_nombre(nombre)
);

DROP TABLE IF EXISTS red_compania;
CREATE TABLE red_compania(
id int NOT NULL AUTO_INCREMENT,
id_red int NOT NULL,
id_compania int NOT NULL,
fecha_pertenencia date NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id_red) REFERENCES red(id_red)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (id_compania) REFERENCES compania(id_compania)
ON DELETE CASCADE ON UPDATE CASCADE,
UNIQUE KEY uk_red_comp_f(id_red, id_compania, fecha_pertenencia)
);

DROP TABLE IF EXISTS linea;
CREATE TABLE linea(
	id_linea int NOT NULL AUTO_INCREMENT,
    id_red int NOT NULL,
    num_linea int NOT NULL,
    longitud float unsigned NOT NULL,
    PRIMARY KEY (id_linea),
    FOREIGN KEY (id_red) REFERENCES red(id_red)
    ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY uk_linea(num_linea, id_red)
);

DROP TABLE IF EXISTS subestacion;
CREATE TABLE subestacion(
	id_subestacion int NOT NULL AUTO_INCREMENT,
    id_linea int NOT NULL,
    nombre varchar(50) NOT NULL,
    PRIMARY KEY (id_subestacion),
    FOREIGN KEY (id_linea) REFERENCES linea(id_linea)
    ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE INDEX idx_subestacion_n(id_subestacion, nombre)
);

DROP TABLE IF EXISTS zona;
CREATE TABLE zona(
	id_zona int NOT NULL AUTO_INCREMENT,
    id_entidades int NOT NULL,
    nombre varchar(50) NOT NULL,
    PRIMARY KEY (id_zona),
    FOREIGN KEY (id_entidades) REFERENCES entidades(id_entidades)
    ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY uk_nombre(nombre),
	UNIQUE INDEX idx_zona_n(id_zona, nombre)
);

DROP TABLE IF EXISTS distribuye;
CREATE TABLE distribuye(
	id int NOT NULL AUTO_INCREMENT,
	id_subestacion int NOT NULL,
    id_zona int NOT NULL,
    fecha_inic date NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_subestacion) REFERENCES subestacion(id_subestacion)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_zona) REFERENCES zona(id_zona)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS consumidores_cat;
CREATE TABLE consumidores_cat(
	id_consumidor int NOT NULL AUTO_INCREMENT,
    nombre varchar(13) NOT NULL,
    PRIMARY KEY (id_consumidor),
    UNIQUE KEY uk_nombre(nombre)
);

DROP TABLE IF EXISTS info_consumidor;
CREATE TABLE info_consumidor(
	id_zona int NOT NULL,
    id_consumidor int NOT NULL,
    consumo_medio float NOT NULL,
    num_consumidores int NOT NULL,
    fecha date NOT NULL,
    FOREIGN KEY (id_zona) REFERENCES zona(id_zona)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_consumidor) REFERENCES consumidores_cat(id_consumidor)
    ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY uk_zona_consumidor_fecha(id_zona, id_consumidor, fecha)
);

DROP TABLE IF EXISTS bitacora_ventas;
CREATE TABLE bitacora(
	id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha datetime NOT NULL,
    usuario varchar(70) NOT NULL,
    tabla varchar(50) NOT NULL,
    sentencia varchar(70) NOT NULL,
    accion text NULL
);


-- TRIGGERS Y FUNCIONES

delimiter //
DROP TRIGGER IF EXISTS delete_ventas //
CREATE TRIGGER delete_ventas
AFTER DELETE ON ventas
FOR EACH ROW
BEGIN
	insert into bitacora values
    (null, sysdate(), user(), 'ventas', 'delete', JSON_OBJECT('id_ventas',old.id_venta, 'fecha',old.fecha, 'cantidad_plutonio',old.cantidad_plutonio, 'descripcion',old.descripcion, 'id_suministrador',old.id_suministrador, 'id_nuclear',old.id_nuclear, 'id_porte',old.id_porte));
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS update_ventas //
CREATE TRIGGER update_ventas
BEFORE UPDATE ON ventas
FOR EACH ROW
BEGIN
	insert into bitacora values
    (null, sysdate(), user(), 'ventas', 'update', JSON_OBJECT('old_id_ventas',old.id_venta, 'old_fecha',old.fecha, 'old_cantidad_plutonio',old.cantidad_plutonio, 'old_descripcion',old.descripcion, 'old_id_suministrador',old.id_suministrador, 'old_id_nuclear',old.id_nuclear, 'old_id_porte',old.id_porte, 'new_id_ventas',new.id_venta, 'new_fecha',new.fecha, 'new_cantidad_plutonio',new.cantidad_plutonio, 'new_descripcion',new.descripcion, 'new_id_suministrador',new.id_suministrador, 'new_id_nuclear',new.id_nuclear, 'new_id_porte',new.id_porte));
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS af_productor //
CREATE TRIGGER ad_productor
AFTER DELETE ON productor
FOR EACH ROW
BEGIN
	insert into bitacora values
    (null, sysdate(), user(), 'productor', 'delete', JSON_OBJECT('id_productor',old.id_productor, 'razon_social',old.razon_social, 'rfc',old.rfc, 'produccion_med',old.produccion_med, 'produccion_max',old.produccion_max, 'fecha_func',old.fecha_func, 'id_entidades',old.id_entidades));
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_productor //
CREATE TRIGGER bu_productor
BEFORE UPDATE ON productor
FOR EACH ROW
BEGIN
	insert into bitacora values
    (null, sysdate(), user(), 'productor', 'update', JSON_OBJECT('old_id_productor',old.id_productor, 'old_razon_social',old.razon_social, 'old_rfc',old.rfc, 'old_produccion_med',old.produccion_med, 'old_produccion_max',old.produccion_max, 'old_fecha_func',old.fecha_func, 'old_id_entidades',old.id_entidades, 'new_id_productor',new.id_productor, 'new_razon_social',new.razon_social, 'new_rfc',new.rfc, 'new_produccion_med',new.produccion_med, 'new_produccion_max',new.produccion_max, 'new_fecha_func',new.fecha_func, 'new_id_entidades',new.id_entidades));
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_centrales //
CREATE TRIGGER ad_centrales
AFTER DELETE ON centrales
FOR EACH ROW
BEGIN
	insert into bitacora values
    (null, sysdate(), user(), 'centrales', 'delete', JSON_OBJECT('id_central',old.id_central, 'nombre',old.nombre));
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_centrales //
CREATE TRIGGER bu_centrales
BEFORE UPDATE ON centrales
FOR EACH ROW
BEGIN
	insert into bitacora values
    (null, sysdate(), user(), 'centrales', 'update', JSON_OBJECT('old_id_central',old.id_central, 'old_nombre',old.nombre, 'new_id_central',new.id_central, 'new_nombre',new.nombre));
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_estacion //
CREATE TRIGGER ad_estacion
AFTER DELETE ON estacion
FOR EACH ROW
BEGIN
	insert into bitacora values
    (null, sysdate(), user(), 'estacion', 'delete', JSON_OBJECT('id_estacion',old.id_estacion, 'nombre',old.nombre, 'num_transformadores',old.num_transformadores));
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_estacion //
CREATE TRIGGER bu_estacion
BEFORE UPDATE ON estacion
FOR EACH ROW
BEGIN
	insert into bitacora values
    (null, sysdate(), user(), 'estacion', 'update', JSON_OBJECT('old_id_estacion',old.id_estacion, 'old_nombre',old.nombre, 'old_num_transformadores',old.num_transformadores, 'new_id_estacion',new.id_estacion, 'new_nombre',new.nombre, 'new_num_transformadores',new.num_transformadores));
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_productor //
CREATE TRIGGER bi_productor
BEFORE INSERT ON productor
FOR EACH ROW
BEGIN
	set new.razon_social = upper(new.razon_social);
    set new.rfc = upper(new.rfc);
    if(new.produccion_max < 0) then
		signal sqlstate'45000'
        set message_text = 'Valor de cantidad máxima incorrecto';
	end if;
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_centrales //
CREATE TRIGGER bi_centrales
BEFORE INSERT ON centrales
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
	if(new.nombre <> 'HIDROELECTRICA') then 
		if(new.nombre <> 'SOLAR') then
			if(new.nombre <>'NUCLEAR') then 
				if(new.nombre <> 'TERMICA') then
					signal sqlstate'45000'
					set message_text = 'Nombre de central inválido';
				end if;
			end if;
		end if;
	end if;
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_transportista //
CREATE TRIGGER bi_transportista
BEFORE INSERT ON transportista
FOR EACH ROW
BEGIN
	set new.razon_social = upper(new.razon_social);
    set new.rfc = upper(new.rfc);
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_entidades //
CREATE TRIGGER bi_entidades
BEFORE INSERT ON entidades
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
    set new.abreviatura = upper(new.abreviatura);
    if(new.codigo > 999) then
		signal sqlstate'45000'
		set message_text = 'El codigo permite solo tres digitos';
	end if;
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_suministrador //
CREATE TRIGGER bi_suministrador
BEFORE INSERT ON suministrador
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_porte //
CREATE TRIGGER bi_porte
BEFORE INSERT ON porte
FOR EACH ROW
BEGIN
	if(new.fecha_registro > new.fecha_realizacion) then
		signal sqlstate'45000'
        set message_text = 'Fecha de realizacion inválida';
	end if;
    if(new.descripcion is not null) then
		set new.descripcion = upper(new.descripcion);
	elseif(new.descripcion is null) then
		set new.descripcion = 'TRANSPORTE PLUTONIO';
	end if;
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_porte //
CREATE TRIGGER bu_porte
BEFORE UPDATE ON porte
FOR EACH ROW
BEGIN
	if(new.fecha_registro > new.fecha_realizacion) then
		signal sqlstate'45000'
        set message_text = 'Nueva fecha de registro inválida';
	elseif(new.fecha_registro > old.fecha_realizacion) then
		signal sqlstate'45000'
        set message_text = 'Nueva fecha de registro inválida';
	elseif(new.fecha_realizacion < old.fecha_registro) then
		signal sqlstate'45000'
        set message_text = 'Nueva fecha de realización inválida';
	end if;
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_ventas //
CREATE TRIGGER bi_ventas
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
    if(new.descripcion is not null) then
		set new.descripcion = upper(new.descripcion);
	elseif(new.descripcion is null) then
		set new.descripcion = 'VENTA PLUTONIO';
	end if;
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_estacion //
CREATE TRIGGER bi_estacion
BEFORE INSERT ON estacion
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
    if(new.num_transformadores < 0) then
		signal sqlstate'45000'
        set message_text = 'Número de transformadores inválido';
	end if;
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_pais //
CREATE TRIGGER bi_pais
BEFORE INSERT ON pais
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_consumidores_c //
CREATE TRIGGER bi_consumidores_c
BEFORE INSERT ON consumidores_cat
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
	if(new.nombre <> 'PARTICULARES') then 
		if(new.nombre <> 'EMPRESAS') then
			if(new.nombre <>'INSTITUCIONES') then 
				signal sqlstate'45000'
				set message_text = 'Nombre de tipo de consumidor inválido';
			end if;
		end if;
	end if;
end; //
delimiter ;

delimiter //
DROP FUNCTION IF EXISTS verificar_inter_red //
create function verificar_inter_red(idred varchar(10), idintercambia varchar(10))
returns int
reads sql data 
deterministic
begin
    declare resultado int;
    declare id_red1 varchar(10);
    declare id_red2 varchar(10);
    
    select id_estacion into id_red1 from red where id_red = idred;
    select id_estacion into id_red2 from red where id_red = idintercambia;
    
    if(id_red1 <> id_red2) then
		set resultado = 0;
	elseif(id_red1 = id_red2) then
		set resultado = 1;
	end if;
    
    return resultado;
end //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_inter_e //
CREATE TRIGGER bi_inter_e
BEFORE INSERT ON intercambia_energia
FOR EACH ROW
BEGIN
	if(new.energia_inter < 0) then
		signal sqlstate'45000'
        set message_text = 'Cantidad de energía inválida';
	end if;
    if(new.id_red = new.id_intercambia_con) then
		signal sqlstate'45000'
        set message_text = 'Una red no puede intercambiar energía con ella misma';
	end if;
    if(verificar_inter_red(new.id_red, new.id_intercambia_con) =0 ) then
		signal sqlstate'45000'
		set message_text = 'No es posible el intercambio entre redes de estaciones diferentes';
    end if;
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_subestacion //
CREATE TRIGGER bi_subestacion
BEFORE INSERT ON subestacion
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_zona //
CREATE TRIGGER bi_zona
BEFORE INSERT ON zona
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
end; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_compania //
CREATE TRIGGER bi_compania
BEFORE INSERT ON compania
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
end; //
delimiter ;

delimiter // 
DROP TRIGGER IF EXISTS bi_linea //
CREATE TRIGGER bi_linea
BEFORE INSERT ON linea
FOR EACH ROW
BEGIN
	if(new.num_linea > 999999) then
		signal sqlstate'45000'
        set message_text = 'El número de linea no debe ser mayor a 6 digitos';
	end if;
END; //
delimiter ;

delimiter //
DROP FUNCTION IF EXISTS verificar_intercambio //
create function verificar_intercambio(idproductor varchar(10), fecha_c date, new_energia int)
returns float
reads sql data 
deterministic
begin
    declare suma_energia float;
    declare suma_total float;
    declare prod_max float;
    declare resultado float;
    
    select sum(energia_entregada) into suma_energia
    from entregar_energia
    where id_productor = idproductor and fecha = fecha_c;
    
    if(suma_energia is null) then
		set resultado = null;
	elseif(suma_energia is not null) then
		set suma_total = suma_energia + new_energia;
    
		select distinct produccion_max into prod_max
		from entregar_energia ee join productor p using (id_productor)
		where p.id_productor = idproductor;
        
        set resultado = prod_max - suma_total;
	end if;
    return resultado;
end //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_entregar_energia //
CREATE TRIGGER bi_entregar_energia
BEFORE INSERT ON entregar_energia
FOR EACH ROW
BEGIN
	if(verificar_intercambio(new.id_productor, new.fecha, new.energia_entregada) < 0) then
		signal sqlstate'45000'
        set message_text = 'Cantidad de energía entregada inválida';
	elseif(verificar_intercambio(new.id_productor, new.fecha, new.energia_entregada) is null) then
		set new.energia_entregada = new.energia_entregada; 
	elseif(verificar_intercambio(new.id_productor, new.fecha, new.energia_entregada) >= 0) then
		set new.energia_entregada = new.energia_entregada; 
	end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_solar //
CREATE TRIGGER bi_solar
BEFORE INSERT ON solar
FOR EACH ROW
BEGIN
	set new.tipo = upper(new.tipo);
	if(new.tipo <> 'FOTOVOLTAICA') then 
		if(new.tipo <> 'TERMODINAMICA') then
			signal sqlstate'45000'
			set message_text = 'Tipo de inválido';
		end if;
	end if;
end; //
delimiter ;


-- VISTAS

CREATE OR REPLACE VIEW productores_basicos AS
select razon_social empresa, rfc, produccion_med p_media, produccion_max p_maxima, fecha_func ffuncionamiento, e.nombre entidad_fed
from productor p JOIN entidades e ON(p.id_entidades = e.id_entidades);

CREATE OR REPLACE VIEW compras AS
select fecha, cantidad_plutonio cant_plutonio, s.nombre vendedor, x.nombre comprador
from ventas v 
JOIN suministrador s ON (v.id_suministrador = s.id_suministrador)
JOIN (select n.id_productor id_productor, p.razon_social nombre, n.id_nuclear id_nuclear from nuclear n JOIN productor p ON(n.id_productor = p.id_productor) ) x ON (v.id_nuclear = x.id_nuclear );

CREATE OR REPLACE VIEW red_v AS
select num_red numero_red, e.nombre estacion
from red r JOIN estacion e ON (r.id_estacion = e.id_estacion);

CREATE OR REPLACE VIEW zona_v AS
select z.nombre zona, e.nombre entidad_fed, e.codigo codigo
from zona z JOIN entidades e ON (z.id_entidades = e.id_entidades);

CREATE OR REPLACE VIEW informacion_consumidor AS
select z.nombre zona, cc.nombre tipo_consumidor, ic.consumo_medio consumo_med, ic.num_consumidores n_consumidores
from info_consumidor ic
join (select id_zona, nombre from zona) z on (ic.id_zona=z.id_zona)
join (select id_consumidor, nombre from consumidores_cat) cc on (ic.id_consumidor=cc.id_consumidor);