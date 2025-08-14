-- PROCEDIMIENTOS ALMACENADOS

USE proyecto_bd2_universidad;

-- Procedimiento para inscribir o retirar cursos a los que se inscriben los estudiantes. Se debe ingresar la accion a realizar (inscribir o retirar), la clave del curso y la matricula del estudiante.
delimiter //
DROP PROCEDURE IF EXISTS inscripcion_curso //
CREATE PROCEDURE inscripcion_curso(
	IN accion VARCHAR(25),
    IN clave_curso_ VARCHAR(50),
    IN estudiante_matricula VARCHAR(12)
)
BEGIN
	-- Variables del procedimiento
    declare v_id_curso int default -1;
    declare v_id_estudiante int default -1;
    -- Asignando variables
    select id_curso from cursos where clave_curso = clave_curso_ into v_id_curso;
    select id_estudiante from estudiante where matricula = estudiante_matricula into v_id_estudiante;
    -- Ejecutando procedimiento
    if(v_id_curso = -1) then
		signal sqlstate'45000'
        set message_text = 'Clave de curso incorrecto.';
	elseif(v_id_estudiante = -1) then
		signal sqlstate'45000'
        set message_text = 'Matricula incorrecta.';
	else
		if(accion = 'inscribir') then
			insert into inscrito values (null,v_id_estudiante,v_id_curso);
            select 'Curso inscrito con exito.' as Mensaje;
		elseif(accion = 'retirar') then
			delete from inscrito where fk_estudiante = v_id_estudiante and fk_cursos = v_id_curso;
			select 'Curso retirado con exito.' as Mensaje;
		else
			signal sqlstate'45000'
			set message_text = 'Accion no valida.';
		end if;
    end if;
END //
delimiter ;

-- Procedimiento para asignar calificacion a un curso de un estudiante. Se deben ingresar como parametros la calificacion, la clave del curso y la matricula del estudiante.
delimiter //
DROP PROCEDURE IF EXISTS asignar_calificacion //
CREATE PROCEDURE asignar_calificacion(
	IN calificacion_curso INT,
    IN clave_curso_ VARCHAR(50),
    IN estudiante_matricula VARCHAR(12)
)
BEGIN
	-- Variable del procedimiento
    declare v_id_inscrito int default -1;
    declare v_id_estudiante int default -1;
    declare v_id_curso int default -1;
    -- Buscando el estudiante y curso para asignar calificacion
    select id_estudiante from estudiante where matricula = estudiante_matricula into v_id_estudiante;
    select id_curso from cursos where clave_curso = clave_curso_ into v_id_curso;
    -- Ejecutando procedimiento
    if(v_id_estudiante = -1) then
		signal sqlstate'45000'
		set message_text = 'Estudiante inexistente.';
	else
		if(v_id_curso = -1) then
			signal sqlstate'45000'
			set message_text = 'Curso inexistente.';
		else
			-- Verificando si existe la inscripcion del estudiante en el curso correspondiente
            select id_inscripcion from inscrito where fk_estudiante = v_id_estudiante and fk_cursos = v_id_curso into v_id_inscrito;
            if(v_id_inscrito = -1) then
				signal sqlstate'45000'
				set message_text = 'El alumno no esta inscrito en el curso introducido.';
			else
				insert into calificaciones values (null,v_id_inscrito,calificacion_curso);
                select 'Calificacion asignada con exito' as Mensaje;
            end if;
        end if;
    end if;
END //
delimiter ;

-- Procedimiento para mostrar el horario con las materias inscritas del estudiante indicado. Solo se ingresa la matricula del estudiante.
delimiter //
DROP PROCEDURE IF EXISTS horario_estudiante //
CREATE PROCEDURE horario_estudiante (
	IN estudiante_matricula VARCHAR(12)
)
BEGIN
	-- Buscando que exista el estudiante
	declare v_id_estudiante int default -1;
    declare tiene_inscritos int default -1;
    select id_estudiante from estudiante where matricula = estudiante_matricula into v_id_estudiante;
	if(v_id_estudiante = -1 or v_id_estudiante = null) then
		signal sqlstate'45000'
		set message_text = 'El alumno no existe.';
	else
		-- Ejecutando procedimiento
		select id_inscripcion from inscrito where fk_estudiante = v_id_estudiante limit 1 into tiene_inscritos;
        if(tiene_inscritos = -1 or tiene_inscritos = null) then
			select 'El alumno no tiene cursos inscritos'as Mensaje;
		else
            select concat(e.nombre,' ',e.apellido_p,' ',e.apellido_m) Estudiante, e.matricula Matricula, c.clave_curso Clave_Curso, concat(p.nombre,' ',p.apellido_p,' ',p.apellido_m) Profesor, m.nombre Materia, g.grupo Grupo, concat(h.dias_semana,' | ',h.hora_inicio,' - ',h.hora_fin) Horario, s.salon Salon, ci.ciclo Ciclo from inscrito i 
            join cursos c on (i.fk_cursos = c.id_curso)
            join estudiante e on (i.fk_estudiante = e.id_estudiante)
            join profesor p on (c.fk_profesor = p.id_profesor)
            join materia m on (c.fk_materia = m.id_materia)
            join ciclos ci on (c.fk_ciclos = ci.id_ciclo)
            join grupos g on (c.fk_grupos = g.id_grupo)
            join horario h on (c.fk_horario = h.id_horario)
            join salones s on (c.fk_salones = s.id_salon)
            where fk_estudiante = v_id_estudiante;
		end if;
    end if;
END //
delimiter ; 

-- Procedimiento para crear un curso indicando el profesor, materia, grupo y ciclo, el salon  y hora se asigna automaticamente
delimiter //
DROP PROCEDURE IF EXISTS crear_curso_auto //
CREATE PROCEDURE crear_curso_auto(
	IN nombre_completo_prof VARCHAR(200),
    IN curso_materia VARCHAR(50),
    IN curso_grupo VARCHAR(50),
    IN curso_ciclo VARCHAR(40)
)
BEGIN
	-- Variables del procedimeinto
	declare v_id_prof int default -1;
    declare v_id_materia int default -1;
    declare v_id_grupo int default -1;
    declare v_id_ciclo int default -1;
    declare v_id_salon int;
    declare v_id_horario int;
    declare v_salon_ocupado int default -1;
    declare v_horario_ocupado int default -1;
    declare v_prof_ocupado int default -1;
    -- Variables de cursores
    declare terminado int default 0;
    declare cursor_salon cursor for select id_salon from salones;
    declare cursor_horario cursor for select id_horario from horario;
    declare continue handler for not found set terminado = 1;
    select id_profesor from profesor where concat(nombre,' ',apellido_p,' ',apellido_m) = nombre_completo_prof into v_id_prof;
    select id_materia from materia where nombre = curso_materia into v_id_materia;
    select id_grupo from grupos where grupo = curso_grupo into v_id_grupo;
    select id_ciclo from ciclos where ciclo = curso_ciclo into v_id_ciclo;
    if(v_id_prof = -1 or v_id_prof = null) then
		signal sqlstate'45000'
		set message_text = 'El profesor no existe.';
	else
		if(v_id_materia = -1 or v_id_materia = null) then
			signal sqlstate'45000'
			set message_text = 'La materia no existe.';
		else
			if(v_id_grupo = -1 or v_id_grupo = null) then
				signal sqlstate'45000'
				set message_text = 'El grupo no existe.';
			else
				if(v_id_ciclo = -1 or v_id_ciclo = null) then
					insert into ciclos values (null,curso_ciclo);
                end if;
                select id_ciclo from ciclos where ciclo = curso_ciclo into v_id_ciclo; 
                
                -- Recorriendo salones y verificando si el salon esta en cursos
                open cursor_salon;
					leerSalones: loop
						fetch cursor_salon into v_id_salon; -- guardando valor del id_salon
						if(terminado = 1) then
							-- Si no encuentra salones con horarios disponibles
							leave leerSalones;
						end if;
                        -- Verificando si el salon esta en cursos
                        select count(*) from cursos where fk_salones = v_id_salon into v_salon_ocupado;
                        if(v_salon_ocupado = 0) then
							-- si el salon no esta ocupado se le asigna el primer horario existente
                            set v_id_horario = 1;
                            insert into cursos values (null,null,v_id_prof,v_id_materia,v_id_ciclo,v_id_grupo,v_id_horario,v_id_salon);
                            leave leerSalones;
						else
							-- salon ocupado (asignarle el primer horario que no tenga salon)
                            open cursor_horario;
								leerHorarios: loop
									fetch cursor_horario into v_id_horario;
                                    if(terminado = 1) then
										set v_horario_ocupado = -1;
                                        set terminado = 0;
										leave leerHorarios;
                                    end if;
                                    select count(*) from cursos where fk_horario = v_id_horario and fk_salones = v_id_salon into v_horario_ocupado;
                                    if(v_horario_ocupado = 0) then
										-- si el horario no esta ocupado
                                        select count(*) from cursos where fk_profesor = v_id_prof and fk_horario = v_id_horario into v_prof_ocupado;
                                        if(v_prof_ocupado = 0) then
											-- si el profesor esta libre
											insert into cursos values (null,null,v_id_prof,v_id_materia,v_id_ciclo,v_id_grupo,v_id_horario,v_id_salon);
											set terminado = 1;
											leave leerHorarios;
										else
											set v_horario_ocupado = -1;
                                        end if;
									else	
										set v_horario_ocupado = -1;
                                    end if;
                                end loop leerHorarios;
                            close cursor_horario;
                            
                        end if;
                        
					end loop leerSalones;
                close cursor_salon;
                
			end if;
        end if;
    end if;
END //
delimiter ;

-- Procedimiento para insertar un nuevo estudiante, recibe como parametros los campos de la tabla estudiante y la tabla direccion. Si la direccion no existe en la tabla direccion entonces se inserta en su respectiva tabla
delimiter //
DROP PROCEDURE IF EXISTS insertar_estudiante //
CREATE PROCEDURE insertar_estudiante(
	IN e_nombre VARCHAR(70),
    IN apellido_p VARCHAR(50),
    IN apellido_m VARCHAR(50),
    IN matricula VARCHAR(12),
    IN e_carrera VARCHAR(100),
    IN curp VARCHAR(18),
    IN telefono INT,
    IN correo VARCHAR(70),
    IN fecha_nac DATE,
    IN anio_ingreso YEAR,
    -- direccion
    IN dir_calle VARCHAR(100),
    IN dir_num_exterior INT,
    IN dir_delegacion VARCHAR(100),
    IN dir_estado VARCHAR(70),
    IN dir_codigo_postal INT
)
BEGIN
	declare v_id_direccion int default -1;
    declare v_id_carrera int default -1;
    select id_direccion from direccion where calle = dir_calle and num_exterior = dir_num_exterior and delegacion = dir_delegacion and estado = dir_estado and codigo_postal = dir_codigo_postal into v_id_direccion;
    select id_carrera from carrera where nombre = e_carrera into v_id_carrera;
    -- Verificando que exista la direccion, si no existe se ingresa
    if(v_id_direccion = -1 or v_id_direccion = null) then
		insert into direccion values (null,dir_calle,dir_num_exterior,dir_delegacion,dir_estado,dir_codigo_postal);
        select id_direccion from direccion where calle = dir_calle and num_exterior = dir_num_exterior and delegacion = dir_delegacion and estado = dir_estado and codigo_postal = dir_codigo_postal into v_id_direccion;
    end if;
    -- Verificado que la carrera exista
    if(v_id_carrera = -1 or v_id_carrera = null) then
		signal sqlstate'45000'
		set message_text = 'La carrera no existe.';
	else
		-- Insertando estudiante
		select 'Estudiante agregado correctamente';
		insert into estudiante values (null,e_nombre,apellido_p,apellido_m,matricula,v_id_carrera,curp,v_id_direccion,telefono,correo,fecha_nac,anio_ingreso);
	end if;
END //
delimiter ;

-- Procedimiento para insertar un nuevo profesor, recibe como parametros los campos de la tabla profesor y la tabla direccion. Si la direccion no existe en la tabla direccion entonces se inserta en su respectiva tabla
delimiter //
DROP PROCEDURE IF EXISTS insertar_profesor //
CREATE PROCEDURE insertar_profesor(
	IN nombre VARCHAR(70),
    IN apellido_p VARCHAR(50),
    IN apellido_m VARCHAR(50),
    IN curp VARCHAR(18),
    IN telefono INT,
    IN correo VARCHAR(70),
    IN fecha_nac DATE,
    -- direccion
    IN dir_calle VARCHAR(100),
    IN dir_num_exterior INT,
    IN dir_delegacion VARCHAR(100),
    IN dir_estado VARCHAR(70),
    IN dir_codigo_postal INT
)
BEGIN
	declare v_id_direccion int default -1;
    select id_direccion from direccion where calle = dir_calle and num_exterior = dir_num_exterior and delegacion = dir_delegacion and estado = dir_estado and codigo_postal = dir_codigo_postal into v_id_direccion;
    -- Verificando que exista la direccion, si no existe se ingresa
    if(v_id_direccion = -1 or v_id_direccion = null) then
		insert into direccion values (null,dir_calle,dir_num_exterior,dir_delegacion,dir_estado,dir_codigo_postal);
        select id_direccion from direccion where calle = dir_calle and num_exterior = dir_num_exterior and delegacion = dir_delegacion and estado = dir_estado and codigo_postal = dir_codigo_postal into v_id_direccion;
    end if;
    -- Ingresando profesor
    select 'Profesor agregado correctamente';
	insert into profesor values (null,nombre,apellido_p,apellido_m,curp,v_id_direccion,telefono,correo,fecha_nac);
END //
delimiter ;

-- Procedimiento para agregar un curso ingresando el nombre completo del profesor, nombre de la materia, el ciclo, el grupo, la hora de inicio, la hora de termino, los dias, y el salon. Estos datos ingresados ya deben estar en sus respectivas tablas en la BD, de lo contrario se mostrará un error.
delimiter //
DROP PROCEDURE IF EXISTS insertar_curso_manual //
CREATE PROCEDURE insertar_curso_manual(
	IN curso_prof VARCHAR(300),
    IN curso_materia VARCHAR(100),
    IN curso_ciclo VARCHAR(100),
    IN curso_grupo VARCHAR(100),
    IN curso_h_inicio TIME,
    IN curso_h_fin TIME,
    IN curso_h_dias VARCHAR(200),
    IN curso_salon VARCHAR(100)
)
BEGIN
	-- Variables del procedimiento
	declare v_id_prof int default -1;
    declare v_id_materia int default -1;
    declare v_id_ciclo int default -1;
    declare v_id_grupo int default -1;
    declare v_id_horario int default -1;
    declare v_id_salon int default -1;
    -- Manejo de errores para horario ya ocupado
    declare exit handler for sqlstate '23000'
    begin
		select 'Horario no disponible' as Mensaje;
    end;
    -- Obteniendo los indices
    select id_profesor from profesor p where concat(p.nombre,' ',p.apellido_p,' ',apellido_m) = curso_prof into v_id_prof;
    select id_materia from materia where nombre = curso_materia into v_id_materia;
    select id_ciclo from ciclos where ciclo = curso_ciclo into v_id_ciclo;
    select id_grupo from grupos where grupo = curso_grupo into v_id_grupo;
    select id_horario from horario where hora_inicio = curso_h_inicio and hora_fin = curso_h_fin and dias_semana = curso_h_dias into v_id_horario;
    select id_salon from salones where salon = curso_salon into v_id_salon;
    -- Ejecutando procedimiento
    if(v_id_prof = -1 or v_id_prof = null) then
		signal sqlstate'45000'
		set message_text = 'El profesor no existe.';
    else
		if(v_id_materia = -1 or v_id_materia = null) then
			signal sqlstate'45000'
			set message_text = 'La materia no existe.';
		else
			if(v_id_ciclo = -1 or v_id_ciclo = null) then
				signal sqlstate'45000'
				set message_text = 'El ciclo no existe.';
			else
				if(v_id_grupo = -1 or v_id_grupo = null) then
					signal sqlstate'45000'
					set message_text = 'El grupo no existe.';
				else
					if(v_id_horario = -1 or v_id_horario = null) then
						signal sqlstate'45000'
						set message_text = 'El horario no existe.';
					else
						if(v_id_salon = -1 or v_id_salon = null) then
							signal sqlstate'45000'
							set message_text = 'El salon no existe.';
						else
                            -- Verificando que el profesor se encuentre libre en el horario indicado
                            if( (select count(*) from cursos where fk_profesor = v_id_prof and fk_horario = v_id_horario) = 0 ) then
								insert into cursos values (null,null,v_id_prof,v_id_materia,v_id_ciclo,v_id_grupo,v_id_horario,v_id_salon);
                                select 'Curso agregado con exito' as Mensaje;
							else
								signal sqlstate'45000'
								set message_text = 'El profesor ya tiene curso en el horario indicado.';
                            end if;
						end if;
					end if;
				end if;
			end if;
		end if;
    end if;
END //
delimiter ;

-- Procedimiento para eliminar un estudiante de la tabla estudiantes indicando solo su matricula. Al eliminarlo se indica cuantos cursos inscritos tenia
delimiter //
DROP PROCEDURE IF EXISTS eliminar_estudiante //
CREATE PROCEDURE eliminar_estudiante(
	IN matricula_estudiante VARCHAR(15)
)
BEGIN
	declare v_id_estudiante int default -1;
    declare numero_inscripciones int;
	select id_estudiante from estudiante where matricula = matricula_estudiante into v_id_estudiante;
    if(v_id_estudiante = -1 or v_id_estudiante = null) then
		signal sqlstate'45000'
        set message_text = 'El alumno no existe';
	else
		select count(*) from inscrito where fk_estudiante = v_id_estudiante into numero_inscripciones;
		delete from estudiante where id_estudiante = v_id_estudiante;
        select concat('Estudiante eliminado correctamente, el estudiante contaba con ',numero_inscripciones,' inscripciones.') as Mensaje;
    end if;
END //
delimiter ;

-- Procedimiento para eliminar un profesor de la tabla profesores indicando su nombre completo. Al eliminarlo se indica cuantos cursos impartia.
delimiter //
DROP PROCEDURE IF EXISTS eliminar_profesor //
CREATE PROCEDURE eliminar_profesor(
	IN nombre_prof VARCHAR(200)
)
BEGIN
	declare v_id_prof int default -1;
    declare numero_cursos int;
	select id_profesor from profesor where concat(nombre,' ',apellido_p,' ',apellido_m) = nombre_prof into v_id_prof;
    if(v_id_prof = -1 or v_id_prof = null) then
		signal sqlstate'45000'
        set message_text = 'El profesor no existe';
	else
		-- eliminando sus cursos primero y contando cuantos tenia
        select count(*) from cursos where fk_profesor = v_id_prof into numero_cursos;
		delete from cursos where fk_profesor = v_id_prof;
		delete from profesor where id_profesor = v_id_prof;
        select concat('Profesor eliminado correctamente, el profesor contaba con ',numero_cursos,' cursos.') as Mensaje;
    end if;
END //
delimiter ;

-- Procedimiento para mostrar los registros de la bitacora segun la fecha y la sentencia indicada. Si se ingresa null en ambos campos se muestran todos los registros.
delimiter //
DROP PROCEDURE IF EXISTS mostrar_bitacora //
CREATE PROCEDURE mostrar_bitacora(
	IN fecha_ DATE,
    IN sentencia_ VARCHAR(25)
)
BEGIN
	if( fecha_ is null and sentencia_ is null ) then
		-- Muestra todos los registros
        select 'todos';
		select fecha Fecha, usuario Usuario, upper(tabla) Tabla, upper(sentencia) Sentencia, accion Accion from bitacora;
	elseif( fecha_ is null and sentencia_ is not null ) then
		-- Muestra los registros con la sentencia indicada
        select 'sentencia';
		select fecha Fecha, usuario Usuario, upper(tabla) Tabla, upper(sentencia) Sentencia, accion Accion from bitacora where sentencia = sentencia_;
	elseif( fecha_ is not null and sentencia_ is null ) then
		-- Mestra todos los registros de la fecha indicada
        select 'fecha';
		select fecha Fecha, usuario Usuario, upper(tabla) Tabla, upper(sentencia) Sentencia, accion Accion from bitacora where year(fecha) = year(fecha_) and month(fecha) = month(fecha_) and day(fecha) = day (fecha_);
	else
		-- Muestra todos los registros de la fecha y sentencia indicada
        select 'fecha y hora';
		select fecha Fecha, usuario Usuario, upper(tabla) Tabla, upper(sentencia) Sentencia, accion Accion from bitacora where year(fecha) = year(fecha_) and month(fecha) = month(fecha_) and day(fecha) = day (fecha_) and sentencia = sentencia_;
    end if;
END //
delimiter ;

-- Procedimiento para actualizar una calificacion de un curso inscrito por un estudiante
delimiter //
DROP PROCEDURE IF EXISTS actualizar_calificacion //
CREATE PROCEDURE actualizar_calificacion(
	IN matricula_estudiante VARCHAR(20),
    IN clave_curso_ VARCHAR(30),
    IN calificacion_ INT
)
BEGIN
	declare v_id_estudiante int default -1;
    declare v_id_curso int default -1;
    declare v_id_inscrito int default -1;
    -- Verificando que exista el curso y el estudiante
    select id_estudiante from estudiante where matricula = matricula_estudiante into v_id_estudiante;
    select id_curso from cursos where clave_curso = clave_curso_ into v_id_curso;
    if(v_id_estudiante = -1 or v_id_estudiante is null) then
		signal sqlstate'45000'
        set message_text = 'El estudiante no existe.';
    else
		if(v_id_curso = -1 or v_id_curso is null) then
			signal sqlstate'45000'
			set message_text = 'El curso no existe.';
		else
			-- Buscando que el alumno este inscrito en ese curso
            select id_inscripcion from inscrito where fk_estudiante = v_id_estudiante and fk_cursos = v_id_curso into v_id_inscrito;
            if(v_id_inscrito = -1 or v_id_inscrito is null) then
				signal sqlstate'45000'
				set message_text = 'El estudiante no esta inscrito en ese curso.';
			else
				update calificaciones set calificacion = calificacion_ where fk_inscrito = v_id_inscrito;
                select 'Se actualizo la calificacion correctamente.' as Mensaje;
            end if;
        end if;
    end if;
END //
delimiter ;

-- Procedimiento para mostrar las calificaciones de el estudiante que se introduce como parametro
delimiter //
DROP PROCEDURE IF EXISTS calificaciones_estudiante //
CREATE PROCEDURE calificaciones_estudiante(
	IN matricula_ VARCHAR(25)
)
BEGIN
	declare v_id_estudiante int default -1;
	declare v_id_inscrito int default -1;
    declare nombre_completo varchar(200);
    declare cal int;
    select id_estudiante from estudiante where matricula = matricula_ into v_id_estudiante;
    select id_inscripcion from inscrito where fk_estudiante = v_id_estudiante into v_id_inscrito;
	if(v_id_estudiante = -1 or v_id_estudiante is null) then
		signal sqlstate'45000'
		set message_text = 'El estudiante no existe.';
	else
		if(v_id_inscrito = -1 or v_id_inscrito is null) then
			signal sqlstate'45000'
			set message_text = 'El estudiante no tiene cursos inscritos.';
		else
            select concat(e.nombre,' ',e.apellido_p,' ',e.apellido_m) Estudiante, c.clave_curso Clave_Curso, m.nombre Materia, ca.calificacion Calificacion from calificaciones ca 
            join inscrito i on (ca.fk_inscrito = i.id_inscripcion)
            join cursos c on (i.fk_cursos = c.id_curso)
            join estudiante e on (i.fk_estudiante = e.id_estudiante)
            join materia m on (c.fk_materia = m.id_materia)
            where e.id_estudiante = v_id_estudiante;
		end if;
    end if;
END //
delimiter ;

-- Procedimiento almacenado para crear un nuevo usuario para administrar la BD o solo visualizar datos dependiendo el privilegio que se introduzca. Solo existe los tipos de privilegio "admin" y "lector"
delimiter //
DROP PROCEDURE IF EXISTS crear_usuario_BD //
CREATE PROCEDURE crear_usuario_BD(
	IN usuario_ VARCHAR(70),
    IN contrasenia_ VARCHAR(70),
    IN privilegio_ VARCHAR(20)
)
BEGIN
	set privilegio_ = lower(privilegio_);
	if( (select count(*) from usuarios_bd where usuario = usuario_) = 0 ) then
		-- El usuario no existe
        if(privilegio_ = 'admin') then
			-- creando usuario
			set @consulta = concat('create user ','''',usuario_,'''','@''localhost'' identified by ''',contrasenia_,''';');
			prepare stmt from @consulta;
			execute stmt;
			deallocate prepare stmt;
            -- asignando permisos
			set @consulta = concat('GRANT ALL PRIVILEGES ON proyecto_bd2_universidad.* TO ','''',usuario_,'''','@''localhost'';');
            prepare stmt from @consulta;
			execute stmt;
			deallocate prepare stmt;
            -- insertando en la tabla usuarios_bd
            insert into usuarios_bd values (null,usuario_,privilegio_,contrasenia_);
            select concat('Usuario ''',usuario_,''' creado con exito.') as Mensaje;
        elseif(privilegio_ = 'lector') then
			-- creando usuario
			set @consulta = concat('create user ','''',usuario_,'''','@''localhost'' identified by ''',contrasenia_,''';');
			prepare stmt from @consulta;
			execute stmt;
			deallocate prepare stmt;
            -- asignando permisos
            set @consulta = concat('GRANT SELECT ON proyecto_bd2_universidad.* TO ','''',usuario_,'''','@''localhost'';');
            prepare stmt from @consulta;
			execute stmt;
			deallocate prepare stmt;
            -- insertando en la tabla usuarios_bd
            insert into usuarios_bd values (null,usuario_,privilegio_,contrasenia_);
            select concat('Usuario ''',usuario_,''' creado con exito.') as Mensaje;
        else
			signal sqlstate'45000'
			set message_text = 'Privilegio no valido.';
        end if;
    else
		signal sqlstate'45000'
        set message_text = 'El usuario ya existe.';
    end if;
END //
delimiter ;

-- Procedimiento para eliminar un usuario de la BD
delimiter //
DROP PROCEDURE IF EXISTS eliminar_usuario_BD //
CREATE PROCEDURE eliminar_usuario_BD(
	IN usuario_ VARCHAR(70)
)
BEGIN
	if( (select count(*) from usuarios_bd where usuario = usuario_) > 0 ) then
		-- El usuario si existe
        set @consulta = concat('drop user ','''',usuario_,'''','@''localhost'';');
		prepare stmt from @consulta;
		execute stmt;
		deallocate prepare stmt;
        delete from usuarios_bd where usuario = usuario_;
        select concat('Usuario ''',usuario_,''' eliminado con exito.') as Mensaje;
    else
		signal sqlstate'45000'
        set message_text = 'El usuario no existe.';
    end if;
END //
delimiter ;