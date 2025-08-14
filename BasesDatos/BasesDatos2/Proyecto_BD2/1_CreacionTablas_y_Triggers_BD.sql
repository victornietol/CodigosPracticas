-- CREACION DE LA BASE DE DATOS

DROP DATABASE IF EXISTS proyecto_bd2_universidad;
CREATE DATABASE IF NOT EXISTS proyecto_bd2_universidad;

USE proyecto_bd2_universidad;



-- CREACION DE LAS TABLAS
DROP TABLE IF EXISTS carrera;
CREATE TABLE carrera(
	id_carrera INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(70) NOT NULL,
    PRIMARY KEY (id_carrera),
    UNIQUE KEY uk_carrera(nombre)
);

DROP TABLE IF EXISTS direccion;
CREATE TABLE direccion(
	id_direccion INT NOT NULL AUTO_INCREMENT,
    calle VARCHAR(100) NOT NULL,
    num_exterior INT UNSIGNED NOT NULL,
    delegacion VARCHAR(100) NOT NULL,
    estado VARCHAR(70) NOT NULL,
    codigo_postal INT(5) UNSIGNED ZEROFILL NOT NULL,
    PRIMARY KEY (id_direccion),
    UNIQUE KEY uk_direccion_completa(calle,num_exterior,delegacion,estado,codigo_postal)
);

DROP TABLE IF EXISTS estudiante;
CREATE TABLE estudiante(
	id_estudiante INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(70) NOT NULL,
    apellido_p VARCHAR(50) NOT NULL,
    apellido_m VARCHAR(50) NOT NULL,
    matricula VARCHAR(12) NOT NULL,
    fk_carrera INT NOT NULL,
    curp VARCHAR(18) NOT NULL,
    fk_direccion INT NOT NULL,
    telefono BIGINT UNSIGNED NOT NULL,
    correo VARCHAR(70) NOT NULL,
    fecha_nac DATE NOT NULL,
    anio_ingreso YEAR NOT NULL,
    PRIMARY KEY(id_estudiante),
    UNIQUE KEY uk_matricula(matricula),
    UNIQUE KEY uk_curp(curp),
    FOREIGN KEY (fk_carrera) REFERENCES carrera(id_carrera)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (fk_direccion) REFERENCES direccion(id_direccion)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS profesor;
CREATE TABLE profesor(
	id_profesor INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(70) NOT NULL,
    apellido_p VARCHAR(50) NOT NULL,
    apellido_m VARCHAR(50) NOT NULL,
    curp VARCHAR(18) NOT NULL,
    fk_direccion INT NOT NULL,
    telefono BIGINT UNSIGNED NOT NULL,
    correo VARCHAR(70) NOT NULL,
    fecha_nac DATE NOT NULL,
    PRIMARY KEY (id_profesor),
    UNIQUE KEY uk_curp(curp),
    FOREIGN KEY (fk_direccion) REFERENCES direccion(id_direccion)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS materia;
CREATE TABLE materia(
	id_materia INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_materia),
    UNIQUE KEY uk_materia(nombre)
);

DROP TABLE IF EXISTS ciclos;
CREATE TABLE ciclos(
	id_ciclo INT NOT NULL AUTO_INCREMENT,
    ciclo VARCHAR(25) NOT NULL,
    PRIMARY KEY (id_ciclo),
    UNIQUE KEY uk_ciclo(ciclo)
);

DROP TABLE IF EXISTS grupos;
CREATE TABLE grupos(
	id_grupo INT NOT NULL AUTO_INCREMENT,
    grupo VARCHAR(25) NOT NULL,
    UNIQUE KEY uk_grupo(grupo),
    PRIMARY KEY (id_grupo)
);

DROP TABLE IF EXISTS horario;
CREATE TABLE horario(
	id_horario INT NOT NULL AUTO_INCREMENT,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    dias_semana VARCHAR(44) NOT NULL,
    UNIQUE KEY uk_hora(hora_inicio,hora_fin,dias_semana),
    PRIMARY KEY (id_horario)
);

DROP TABLE IF EXISTS salones;
CREATE TABLE salones(
	id_salon INT NOT NULL AUTO_INCREMENT,
    salon VARCHAR(25) NOT NULL,
    UNIQUE KEY uk_salon(salon),
    PRIMARY KEY (id_salon)
);

DROP TABLE IF EXISTS cursos;
CREATE TABLE cursos(
	id_curso INT NOT NULL AUTO_INCREMENT,
    clave_curso VARCHAR(40) NULL,
    fk_profesor INT NOT NULL,
    fk_materia INT NOT NULL,
    fk_ciclos INT NOT NULL,
    fk_grupos INT NOT NULL,
    fk_horario INT NOT NULL,
    fk_salones INT NOT NULL,
    UNIQUE KEY uk_horario(fk_salones,fk_horario),
    UNIQUE KEY uk_curso(fk_materia,fk_ciclos,fk_grupos,fk_horario,fk_salones),
    FOREIGN KEY (fk_profesor) REFERENCES profesor(id_profesor)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (fk_materia) REFERENCES materia(id_materia)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (fk_ciclos) REFERENCES ciclos(id_ciclo)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (fk_grupos) REFERENCES grupos(id_grupo)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (fk_horario) REFERENCES horario(id_horario)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (fk_salones) REFERENCES salones(id_salon)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (id_curso)
);

DROP TABLE IF EXISTS inscrito;
CREATE TABLE inscrito(
	id_inscripcion INT NOT NULL AUTO_INCREMENT,
    fk_estudiante INT NOT NULL,
    fk_cursos INT NOT NULL,
    UNIQUE KEY uk_inscrito(fk_estudiante,fk_cursos),
    FOREIGN KEY (fk_estudiante) REFERENCES estudiante(id_estudiante)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (fk_cursos) REFERENCES cursos(id_curso)
    ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (id_inscripcion)
);

DROP TABLE IF EXISTS calificaciones;
CREATE TABLE calificaciones(
	id_calificacion INT NOT NULL AUTO_INCREMENT,
    fk_inscrito INT  NULL,
    calificacion VARCHAR(2) NOT NULL,
    UNIQUE KEY uk_inscripcion(fk_inscrito),
    FOREIGN KEY (fk_inscrito) REFERENCES inscrito(id_inscripcion)
    ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (id_calificacion)
);

-- Bitacora para registrar los insert, delete y update
DROP TABLE IF EXISTS bitacora;
CREATE TABLE bitacora(
	id_bitacora INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    usuario VARCHAR(50) NULL DEFAULT 'root@localhost',
    tabla VARCHAR(40) NOT NULL,
    sentencia VARCHAR(6) NOT NULL,
    accion TEXT NULL,
    PRIMARY KEY (id_bitacora)
);

-- Tabla para guardar los usuarios que pueden administrar y ver los datos de la BD
DROP TABLE IF EXISTS usuarios_BD;
CREATE TABLE usuarios_BD(
	id_usuario INT NOT NULL AUTO_INCREMENT,
    usuario VARCHAR(70) NOT NULL,
    privilegio VARCHAR(50) NOT NULL,
    contrasenia VARCHAR(70) NOT NULL,
    UNIQUE KEY uk_usuario(usuario),
    PRIMARY KEY (id_usuario)
);



-- TRIGGERS

delimiter //
DROP TRIGGER IF EXISTS bi_carrera //
CREATE TRIGGER bi_carrera
BEFORE INSERT ON carrera
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
    insert into bitacora values (null,sysdate(),user(),'carrera','insert',
    json_object('id_carrera',new.id_carrera,'nombre',new.nombre));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_carrera //
CREATE TRIGGER bu_carrera
BEFORE UPDATE ON carrera
FOR EACH ROW
BEGIN
	if(new.nombre = old.nombre) then
		signal sqlstate'45000'
        set message_text = 'El nuevo valor introducido es el mismo al valor anterior.';
	else
		set new.nombre = upper(new.nombre);
        insert into bitacora values (null,sysdate(),user(),'carrera','update',
		json_object('id_carrera',old.id_carrera,'nombre',old.nombre));
	end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_direccion //
CREATE TRIGGER bi_direccion
BEFORE INSERT ON direccion
FOR EACH ROW
BEGIN
	if(new.codigo_postal > 99999) then
		signal sqlstate'45000'
        set message_text = 'Codigo postal no valido.';
	elseif(select count(*) from direccion where calle = new.calle and 
    num_exterior = new.num_exterior and 
    delegacion = new.delegacion and 
    estado = new.estado and 
    codigo_postal = new.codigo_postal) then
		signal sqlstate'45000'
        set message_text = 'La direccion ya existe.';
	else
		set new.calle = upper(new.calle);
		set new.delegacion = upper(new.delegacion);
		set new.estado = upper(new.estado);
        insert into bitacora values (null,sysdate(),user(),'direccion','insert',
		json_object('id_direccion',new.id_direccion,'calle',new.calle,'num_exterior',new.num_exterior,'delegacion',new.delegacion,'estado',new.estado,'codigo_postal',new.codigo_postal));
		end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_direccion //
CREATE TRIGGER bu_direccion
BEFORE UPDATE ON direccion
FOR EACH ROW
BEGIN
	if(new.calle <> old.calle or 
    new.num_exterior <> old.num_exterior or
    new.delegacion <> old.delegacion or
    new.estado <> old.estado or
    new.codigo_postal <> old.codigo_postal) then
		set new.calle = upper(new.calle);
        set new.delegacion = upper(new.delegacion);
        set new.estado = upper(new.estado);
        insert into bitacora values (null,sysdate(),user(),'direccion','update',
		json_object('id_direccion',old.id_direccion,'calle',old.calle,'num_exterior',old.num_exterior,'delegacion',old.delegacion,'estado',old.estado,'codigo_postal',old.codigo_postal));
	else
		signal sqlstate'45000'
        set message_text = 'El nuevo valor introducido es el mismo al valor anterior.';
	end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_estudiante //
CREATE TRIGGER bi_estudiante
BEFORE INSERT ON estudiante
FOR EACH ROW
BEGIN
	if(new.telefono > 9999999999 or new.telefono < 999999999) then
			signal sqlstate'45000'
			set message_text = 'El telefono no es valido.';
		else 
			if( locate('@',new.correo) = 0) then
				signal sqlstate'45000'
				set message_text = 'El correo no es valido.';
			else
				if(new.fecha_nac < '1900-01-01' or new.fecha_nac > curdate()) then
					signal sqlstate'45000'
					set message_text = 'La fecha de nacimiento no es valida.';
				else
					if(new.anio_ingreso < 1950 or new.anio_ingreso > year(curdate()) ) then
						signal sqlstate'45000'
						set message_text = 'Anio de ingreso no valido.';
					else
						if(locate(',',new.nombre) > 0 or locate('.',new.nombre) > 0 or locate('0',new.nombre) > 0 or
                        locate('1',new.nombre) > 0 or locate('2',new.nombre) > 0 or locate('3',new.nombre) > 0 or 
                        locate('4',new.nombre) > 0 or locate('5',new.nombre) > 0 or locate('6',new.nombre) > 0 or
                        locate('7',new.nombre) > 0 or locate('8',new.nombre) > 0 or locate('9',new.nombre) > 0) then
							signal sqlstate'45000'
							set message_text = 'El nombre no es valido.';
						else
							if(locate(',',new.apellido_p) > 0 or locate('.',new.apellido_p) > 0 or locate('0',new.apellido_p) > 0 or
                            locate('1',new.apellido_p) > 0 or locate('2',new.apellido_p) > 0 or locate('3',new.apellido_p) > 0 or 
							locate('4',new.apellido_p) > 0 or locate('5',new.apellido_p) > 0 or locate('6',new.apellido_p) > 0 or
							locate('7',new.apellido_p) > 0 or locate('8',new.apellido_p) > 0 or locate('9',new.apellido_p) > 0) then
								signal sqlstate'45000'
								set message_text = 'El apellido_p no es valido.';
							else
								if(locate(',',new.apellido_m) > 0 or locate('.',new.apellido_m) > 0 or locate('0',new.apellido_m) > 0 or
								locate('1',new.apellido_m) > 0 or locate('2',new.apellido_m) > 0 or locate('3',new.apellido_m) > 0 or 
								locate('4',new.apellido_m) > 0 or locate('5',new.apellido_m) > 0 or locate('6',new.apellido_m) > 0 or
								locate('7',new.apellido_m) > 0 or locate('8',new.apellido_m) > 0 or locate('9',new.apellido_m) > 0) then
									signal sqlstate'45000'
									set message_text = 'El apellido_m no es valido.';
								else
									set new.nombre = upper(new.nombre);
									set new.apellido_p = upper(new.apellido_p);
									set new.apellido_m = upper(new.apellido_m);
									set new.matricula = upper(new.matricula);
									set new.curp = upper(new.curp);
                                    insert into bitacora values (null,sysdate(),user(),'estudiante','insert',
									json_object('id_estudiante',new.id_estudiante,'nombre',new.nombre,'apellido_p',new.apellido_p,'apellido_m',new.apellido_m,'matricula',new.matricula,'fk_carrera',new.fk_carrera,'curp',new.curp,'fk_direccion',new.fk_direccion,'telefono',new.telefono,'correo',new.correo,'fecha_nac',new.fecha_nac,'anio_ingreso',new.anio_ingreso));
                                end if;
                            end if;
                        end if;
                    end if;
				end if;
			end if;
		end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_estudiante //
CREATE TRIGGER bu_estudiante
BEFORE UPDATE ON estudiante
FOR EACH ROW
BEGIN
	if(new.telefono > 9999999999 or new.telefono < 999999999) then
			signal sqlstate'45000'
			set message_text = 'El telefono no es valido.';
		else 
			if( locate('@',new.correo) = 0) then
				signal sqlstate'45000'
				set message_text = 'El correo no es valido.';
			else
				if(new.fecha_nac < '1900-01-01' or new.fecha_nac > curdate()) then
					signal sqlstate'45000'
					set message_text = 'La fecha de nacimiento no es valida.';
				else
					if(new.anio_ingreso < 1950 or new.anio_ingreso > year(curdate())) then
						signal sqlstate'45000'
						set message_text = 'Anio de ingreso no valido.';
					else
						if(locate(',',new.nombre) > 0 or locate('.',new.nombre) > 0 or locate('0',new.nombre) > 0 or
                        locate('1',new.nombre) > 0 or locate('2',new.nombre) > 0 or locate('3',new.nombre) > 0 or 
                        locate('4',new.nombre) > 0 or locate('5',new.nombre) > 0 or locate('6',new.nombre) > 0 or
                        locate('7',new.nombre) > 0 or locate('8',new.nombre) > 0 or locate('9',new.nombre) > 0) then
							signal sqlstate'45000'
							set message_text = 'El nombre no es valido.';
						else
							if(locate(',',new.apellido_p) > 0 or locate('.',new.apellido_p) > 0 or locate('0',new.apellido_p) > 0 or
                            locate('1',new.apellido_p) > 0 or locate('2',new.apellido_p) > 0 or locate('3',new.apellido_p) > 0 or 
							locate('4',new.apellido_p) > 0 or locate('5',new.apellido_p) > 0 or locate('6',new.apellido_p) > 0 or
							locate('7',new.apellido_p) > 0 or locate('8',new.apellido_p) > 0 or locate('9',new.apellido_p) > 0) then
								signal sqlstate'45000'
								set message_text = 'El apellido_p no es valido.';
							else
								if(locate(',',new.apellido_m) > 0 or locate('.',new.apellido_m) > 0 or locate('0',new.apellido_m) > 0 or
								locate('1',new.apellido_m) > 0 or locate('2',new.apellido_m) > 0 or locate('3',new.apellido_m) > 0 or 
								locate('4',new.apellido_m) > 0 or locate('5',new.apellido_m) > 0 or locate('6',new.apellido_m) > 0 or
								locate('7',new.apellido_m) > 0 or locate('8',new.apellido_m) > 0 or locate('9',new.apellido_m) > 0) then
									signal sqlstate'45000'
									set message_text = 'El apellido_m no es valido.';
								else
									if(new.nombre <> old.nombre or new.apellido_p <> old.apellido_p or 
										new.apellido_m <> old.apellido_m or new.matricula <> old.matricula or
										new.fk_carrera <> old.fk_carrera or new.curp <> old.curp or
										new.fk_direccion <> old.fk_direccion or new.telefono <> old.telefono or
										new.correo <> old.correo or new.fecha_nac <> old.fecha_nac or
										new.anio_ingreso <> old.anio_ingreso) then
											set new.nombre = upper(new.nombre);
											set new.apellido_p = upper(new.apellido_p);
											set new.apellido_m = upper(new.apellido_m);
											set new.matricula = upper(new.matricula);
											set new.curp = upper(new.curp);
                                            insert into bitacora values (null,sysdate(),user(),'estudiante','update',
											json_object('id_estudiante',old.id_estudiante,'nombre',old.nombre,'apellido_p',old.apellido_p,'apellido_m',old.apellido_m,'matricula',old.matricula,'fk_carrera',old.fk_carrera,'curp',old.curp,'fk_direccion',old.fk_direccion,'telefono',old.telefono,'correo',old.correo,'fecha_nac',old.fecha_nac,'anio_ingreso',old.anio_ingreso));
										else
											signal sqlstate'45000'
											set message_text = 'El nuevo valor introducido es igual al anterior valor anterior.';
										end if;
                                end if;
                            end if;
                        end if;
                    end if;
				end if;
			end if;
		end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_profesor //
CREATE TRIGGER bi_profesor
BEFORE INSERT ON profesor
FOR EACH ROW
BEGIN
	if(new.telefono > 9999999999 or new.telefono < 999999999) then
			signal sqlstate'45000'
			set message_text = 'El telefono no es valido.';
		else 
			if( locate('@',new.correo) = 0) then
				signal sqlstate'45000'
				set message_text = 'El correo no es valido.';
			else
				if(new.fecha_nac < '1940-01-01' or new.fecha_nac > curdate()) then
					signal sqlstate'45000'
					set message_text = 'La fecha de nacimiento no es valida.';
				else
					if(locate(',',new.nombre) > 0 or locate('.',new.nombre) > 0 or locate('0',new.nombre) > 0 or
					locate('1',new.nombre) > 0 or locate('2',new.nombre) > 0 or locate('3',new.nombre) > 0 or 
					locate('4',new.nombre) > 0 or locate('5',new.nombre) > 0 or locate('6',new.nombre) > 0 or
					locate('7',new.nombre) > 0 or locate('8',new.nombre) > 0 or locate('9',new.nombre) > 0) then
						signal sqlstate'45000'
						set message_text = 'El nombre no es valido.';
					else
						if(locate(',',new.apellido_p) > 0 or locate('.',new.apellido_p) > 0 or locate('0',new.apellido_p) > 0 or
						locate('1',new.apellido_p) > 0 or locate('2',new.apellido_p) > 0 or locate('3',new.apellido_p) > 0 or 
						locate('4',new.apellido_p) > 0 or locate('5',new.apellido_p) > 0 or locate('6',new.apellido_p) > 0 or
						locate('7',new.apellido_p) > 0 or locate('8',new.apellido_p) > 0 or locate('9',new.apellido_p) > 0) then
							signal sqlstate'45000'
							set message_text = 'El apellido_p no es valido.';
						else
							if(locate(',',new.apellido_m) > 0 or locate('.',new.apellido_m) > 0 or locate('0',new.apellido_m) > 0 or
							locate('1',new.apellido_m) > 0 or locate('2',new.apellido_m) > 0 or locate('3',new.apellido_m) > 0 or 
							locate('4',new.apellido_m) > 0 or locate('5',new.apellido_m) > 0 or locate('6',new.apellido_m) > 0 or
							locate('7',new.apellido_m) > 0 or locate('8',new.apellido_m) > 0 or locate('9',new.apellido_m) > 0) then
								signal sqlstate'45000'
								set message_text = 'El apellido_m no es valido.';
							else
								set new.nombre = upper(new.nombre);
								set new.apellido_p = upper(new.apellido_p);
								set new.apellido_m = upper(new.apellido_m);
								set new.curp = upper(new.curp);
                                insert into bitacora values (null,sysdate(),user(),'profesor','insert',
								json_object('id_profesor',new.id_profesor,'nombre',new.nombre,'apellido_p',new.apellido_p,'apellido_m',new.apellido_m,'curp',new.curp,'fk_direccion',new.fk_direccion,'telefono',new.telefono,'correo',new.correo,'fecha_nac',new.fecha_nac));
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_materia //
CREATE TRIGGER bi_materia
BEFORE INSERT ON materia
FOR EACH ROW
BEGIN
	set new.nombre = upper(new.nombre);
    insert into bitacora values (null,sysdate(),user(),'materia','insert',
    json_object('id_materia',new.id_materia,'nombre',new.nombre));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_materia //
CREATE TRIGGER bu_materia
BEFORE UPDATE ON materia
FOR EACH ROW
BEGIN
	if(new.nombre = old.nombre) then
		signal sqlstate'45000'
        set message_text = 'El nuevo valor introducido es el mismo al valor anterior.';
	else
		set new.nombre = upper(new.nombre);
        insert into bitacora values (null,sysdate(),user(),'materia','update',
		json_object('id_materia',old.id_materia,'nombre',old.nombre));
	end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_ciclos //
CREATE TRIGGER bi_ciclos
BEFORE INSERT ON ciclos
FOR EACH ROW
BEGIN
	set new.ciclo = upper(new.ciclo);
    insert into bitacora values (null,sysdate(),user(),'ciclos','insert',
    json_object('id_ciclo',new.id_ciclo,'ciclo',new.ciclo));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_ciclos //
CREATE TRIGGER bu_ciclos
BEFORE UPDATE ON ciclos
FOR EACH ROW
BEGIN
	if(new.ciclo = old.ciclo) then
		signal sqlstate'45000'
        set message_text = 'El nuevo valor introducido es el mismo al valor anterior.';
	else
		set new.ciclo = upper(new.ciclo);
        insert into bitacora values (null,sysdate(),user(),'ciclos','update',
		json_object('id_ciclo',old.id_ciclo,'ciclo',old.ciclo));
	end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_grupos //
CREATE TRIGGER bi_grupos
BEFORE INSERT ON grupos
FOR EACH ROW
BEGIN
	set new.grupo = upper(new.grupo);
    insert into bitacora values (null,sysdate(),user(),'grupos','insert',
    json_object('id_grupo',new.id_grupo,'grupo',new.grupo));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_grupos //
CREATE TRIGGER bu_grupos
BEFORE UPDATE ON grupos
FOR EACH ROW
BEGIN
	if(new.grupo = old.grupo) then
		signal sqlstate'45000'
        set message_text = 'El nuevo valor introducido es el mismo al valor anterior.';
	else
		set new.grupo = upper(new.grupo);
        insert into bitacora values (null,sysdate(),user(),'grupos','update',
		json_object('id_grupo',old.id_grupo,'grupo',old.grupo));
	end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_horario //
CREATE TRIGGER bi_horario
BEFORE INSERT ON horario
FOR EACH ROW
BEGIN
	if(new.hora_inicio < '07:00:00' or new.hora_inicio > '21:00:00') then
		signal sqlstate'45000'
        set message_text = 'El horario de inicio esta fuera de rango.';
	elseif(new.hora_fin < '08:00:00' or new.hora_fin > '22:30:00') then
		signal sqlstate'45000'
        set message_text = 'El horario de fin esta fuera de rango.';
	elseif(locate('lunes',new.dias_semana) > 0 or locate('martes',new.dias_semana) > 0 or
    locate('miercoles',new.dias_semana) > 0 or locate('jueves',new.dias_semana) > 0 or
    locate('viernes',new.dias_semana) > 0 or locate('sabado',new.dias_semana) > 0 ) then
		set new.dias_semana = upper(new.dias_semana);
        insert into bitacora values (null,sysdate(),user(),'horario','insert',
		json_object('id_horario',new.id_horario,'hora_inicio',new.hora_inicio,'hora_fin',new.hora_fin,'dia_semana',new.dias_semana));
	else
		signal sqlstate'45000'
        set message_text = 'El dia no es valido.';
    end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_horario //
CREATE TRIGGER bu_horario
BEFORE UPDATE ON horario
FOR EACH ROW
BEGIN
	if(new.hora_inicio < '07:00:00' or new.hora_inicio > '21:00:00') then
		signal sqlstate'45000'
        set message_text = 'El horario de inicio esta fuera de rango.';
	elseif(new.hora_fin < '08:00:00' or new.hora_fin > '22:30:00') then
		signal sqlstate'45000'
        set message_text = 'El horario de fin esta fuera de rango.';
	elseif(locate('lunes',new.dias_semana) > 0 or locate('martes',new.dias_semana) > 0 or
    locate('miercoles',new.dias_semana) > 0 or locate('jueves',new.dias_semana) > 0 or
    locate('viernes',new.dias_semana) > 0 or locate('sabado',new.dias_semana) > 0 ) then
		if(new.hora_inicio = old.hora_inicio and new.hora_fin = old.hora_fin and new.dias_semana = old.dias_semana) then
			signal sqlstate'45000'
			set message_text = 'El nuevo valor es el mismo que el anterior.';
        else
			set new.dias_semana = upper(new.dias_semana);	
            insert into bitacora values (null,sysdate(),user(),'horario','update',
    json_object('id_horario',old.id_horario,'hora_inicio',old.hora_inicio,'hora_fin',old.hora_fin,'dia_semana',old.dias_semana));
		end if;
	else
		signal sqlstate'45000'
        set message_text = 'El dia no es valido.';
    end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_salones //
CREATE TRIGGER bi_salones
BEFORE INSERT ON salones
FOR EACH ROW
BEGIN
	set new.salon = upper(new.salon);
    insert into bitacora values (null,sysdate(),user(),'salones','insert',
    json_object('id_salon',new.id_salon,'salon',new.salon));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_salones //
CREATE TRIGGER bu_salones
BEFORE UPDATE ON salones
FOR EACH ROW
BEGIN
	if(new.salon = old.salon) then
		signal sqlstate'45000'
        set message_text = 'El nuevo valor introducido es el mismo al valor anterior.';
	else
		set new.salon = upper(new.salon);
        insert into bitacora values (null,sysdate(),user(),'salones','update',
		json_object('id_salon',old.id_salon,'salon',old.salon));
	end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_calificaciones //
CREATE TRIGGER bi_calificaciones
BEFORE INSERT ON calificaciones
FOR EACH ROW
BEGIN
	if(new.calificacion = '5' or new.calificacion = '6' or new.calificacion = '7' or
    new.calificacion = '8' or new.calificacion = '9' or new.calificacion = '10' or
    new.calificacion = 'np' ) then
		set new.calificacion = upper(new.calificacion);
        insert into bitacora values (null,sysdate(),user(),'calificaciones','insert',
		json_object('id_calificacion',new.id_calificacion,'fk_inscrito',new.fk_inscrito,'calificacion',new.calificacion));
	else
		signal sqlstate'45000'
        set message_text = 'La calificacion esta fuera del rango permitido.';
	end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_calificaciones //
CREATE TRIGGER bu_calificaciones
BEFORE UPDATE ON calificaciones
FOR EACH ROW
BEGIN
	if(new.calificacion = '5' or new.calificacion = '6' or new.calificacion = '7' or
    new.calificacion = '8' or new.calificacion = '9' or new.calificacion = '10' or
    new.calificacion = 'np' ) then
		if(new.calificacion = old.calificacion) then
			signal sqlstate'45000'
			set message_text = 'El nuevo valor introducido es el mismo al valor anterior.';
		else
			set new.calificacion = upper(new.calificacion);
            insert into bitacora values (null,sysdate(),user(),'calificaciones','update',
			json_object('id_calificacion',old.id_calificacion,'fk_inscrito',old.fk_inscrito,'calificacion',old.calificacion));
		end if;
	else
		signal sqlstate'45000'
        set message_text = 'La calificacion esta fuera del rango permitido.';
	end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_calificaciones //
CREATE TRIGGER ad_calificaciones
AFTER DELETE ON calificaciones
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'calificaciones','delete',
    json_object('id_calificacion',old.id_calificacion,'fk_inscrito',old.fk_inscrito,'calificacion',old.calificacion));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_carrera //
CREATE TRIGGER ad_carrera
AFTER DELETE ON carrera
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'carrera','delete',
    json_object('id_carrera',old.id_carrera,'nombre',old.nombre));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_ciclos //
CREATE TRIGGER ad_ciclos
AFTER DELETE ON ciclos
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'ciclos','delete',
    json_object('id_ciclo',old.id_ciclo,'ciclo',old.ciclo));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_cursos //
CREATE TRIGGER ad_cursos
AFTER DELETE ON cursos
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'cursos','delete',
    json_object('id_curso',old.id_curso,'clave_curso',old.clave_curso,'fk_profesor',old.fk_profesor,'fk_materia',old.fk_materia,'fk_ciclos',old.fk_ciclos,'fk_grupos',old.fk_grupos,'fk_horario',old.fk_horario,'fk_salones',old.fk_salones));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_direccion //
CREATE TRIGGER ad_direccion
AFTER DELETE ON direccion
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'direccion','delete',
    json_object('id_direccion',old.id_direccion,'calle',old.calle,'num_exterior',old.num_exterior,'delegacion',old.delegacion,'estado',old.estado,'codigo_postal',old.codigo_postal));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_estudiante //
CREATE TRIGGER ad_estudiante
AFTER DELETE ON estudiante
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'estudiante','delete',
    json_object('id_estudiante',old.id_estudiante,'nombre',old.nombre,'apellido_p',old.apellido_p,'apellido_m',old.apellido_m,'matricula',old.matricula,'fk_carrera',old.fk_carrera,'curp',old.curp,'fk_direccion',old.fk_direccion,'telefono',old.telefono,'correo',old.correo,'fecha_nac',old.fecha_nac,'anio_ingreso',old.anio_ingreso));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_grupos //
CREATE TRIGGER ad_grupos
AFTER DELETE ON grupos
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'grupos','delete',
    json_object('id_grupo',old.id_grupo,'grupo',old.grupo));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_horario //
CREATE TRIGGER ad_horario
AFTER DELETE ON horario
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'horario','delete',
    json_object('id_horario',old.id_horario,'hora_inicio',old.hora_inicio,'hora_fin',old.hora_fin,'dia_semana',old.dias_semana));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_inscrito //
CREATE TRIGGER ad_inscrito
AFTER DELETE ON inscrito
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'inscrito','delete',
    json_object('id_inscripcion',old.id_inscripcion,'fk_estudiante',old.fk_estudiante,'fk_cursos',old.fk_cursos));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_materia //
CREATE TRIGGER ad_materia
AFTER DELETE ON materia
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'materia','delete',
    json_object('id_materia',old.id_materia,'nombre',old.nombre));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_profesor //
CREATE TRIGGER ad_profesor
AFTER DELETE ON profesor
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'profesor','delete',
    json_object('id_profesor',old.id_profesor,'nombre',old.nombre,'apellido_p',old.apellido_p,'apellido_m',old.apellido_m,'curp',old.curp,'fk_direccion',old.fk_direccion,'telefono',old.telefono,'correo',old.correo,'fecha_nac',old.fecha_nac));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_salones //
CREATE TRIGGER ad_salones
AFTER DELETE ON salones
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'salones','delete',
    json_object('id_salon',old.id_salon,'salon',old.salon));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_cursos //
CREATE TRIGGER bi_cursos
BEFORE INSERT ON cursos
FOR EACH ROW
BEGIN
	set new.clave_curso = concat('C',new.id_curso,'-',new.fk_profesor,new.fk_materia,new.fk_ciclos,new.fk_grupos,new.fk_horario,new.fk_salones);
	insert into bitacora values (null,sysdate(),user(),'cursos','insert',
    json_object('id_curso',new.id_curso,'clave_curso',new.clave_curso,'fk_profesor',new.fk_profesor,'fk_materia',new.fk_materia,'fk_ciclos',new.fk_ciclos,'fk_grupos',new.fk_grupos,'fk_horario',new.fk_horario,'fk_salones',new.fk_salones));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_cursos //
CREATE TRIGGER bu_cursos
BEFORE UPDATE ON cursos
FOR EACH ROW
BEGIN
	set new.clave_curso = concat('C',new.id_curso,'-',new.fk_profesor,new.fk_materia,new.fk_ciclos,new.fk_grupos,new.fk_horario,new.fk_salones);
	insert into bitacora values (null,sysdate(),user(),'cursos','update',
    json_object('id_curso',old.id_curso,'clave_curso',old.clave_curso,'fk_profesor',old.fk_profesor,'fk_materia',old.fk_materia,'fk_ciclos',old.fk_ciclos,'fk_grupos',old.fk_grupos,'fk_horario',old.fk_horario,'fk_salones',old.fk_salones));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_inscrito //
CREATE TRIGGER bi_inscrito
BEFORE INSERT ON inscrito
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'inscrito','insert',
    json_object('id_inscripcion',new.id_inscripcion,'fk_estudiante',new.fk_estudiante,'fk_cursos',new.fk_cursos));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_inscrito //
CREATE TRIGGER bu_inscrito
BEFORE UPDATE ON inscrito
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'inscrito','update',
    json_object('id_inscripcion',old.id_inscripcion,'fk_estudiante',old.fk_estudiante,'fk_cursos',old.fk_cursos));
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bi_usuarios_bd //
CREATE TRIGGER bi_usuarios_bd
BEFORE INSERT ON usuarios_bd
FOR EACH ROW
BEGIN
	if (select count(*) from usuarios_bd where usuario = new.usuario) = 0 then
		insert into bitacora values (null,sysdate(),user(),'usuarios_bd','insert',
		json_object('id_usuario',new.id_usuario,'usuario',new.usuario,'privilegio',new.privilegio,'contrasenia',new.contrasenia));
	else
		signal sqlstate'45000'
        set message_text = 'El usuario ya existe.';
    end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS bu_usuarios_bd //
CREATE TRIGGER bu_usuarios_bd
BEFORE UPDATE ON usuarios_bd
FOR EACH ROW
BEGIN
	if (select count(*) from usuarios_bd where usuario = new.usuario) = 0 then
		insert into bitacora values (null,sysdate(),user(),'usuarios_bd','update',
		json_object('id_usuario',old.id_usuario,'usuario',old.usuario,'privilegio',old.privilegio,'contrasenia',old.contrasenia));
	else
		signal sqlstate'45000'
        set message_text = 'El usuario ya existe.';
    end if;
END; //
delimiter ;

delimiter //
DROP TRIGGER IF EXISTS ad_usuarios_bd //
CREATE TRIGGER ad_usuarios_bd
AFTER DELETE ON usuarios_bd
FOR EACH ROW
BEGIN
	insert into bitacora values (null,sysdate(),user(),'usuarios_bd','delete',
    json_object('id_usuario',old.id_usuario,'usuario',old.usuario,'privilegio',old.privilegio,'contrasenia',old.contrasenia));
END; //
delimiter ;