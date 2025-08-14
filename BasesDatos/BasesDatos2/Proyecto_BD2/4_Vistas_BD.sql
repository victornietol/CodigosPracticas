-- VISTAS

USE proyecto_bd2_universidad;

-- Vista que muestra los cursos que se dan los lunes
CREATE OR REPLACE VIEW cursos_lunes AS
SELECT c.clave_curso Clave_curso, m.nombre Materia, concat(p.nombre,' ',p.apellido_p,' ',p.apellido_m) Profesor, g.grupo Grupo, concat(h.dias_semana,' | ',h.hora_inicio,' - ',h.hora_fin) Horario, s.salon Salon, ci.ciclo Ciclo FROM cursos c 
JOIN profesor p ON (c.fk_profesor = p.id_profesor)
JOIN materia m ON (c.fk_materia = m.id_materia)
JOIN ciclos ci ON (c.fk_ciclos = ci.id_ciclo)
JOIN grupos g ON (c.fk_grupos = g.id_grupo)
JOIN horario h ON (c.fk_horario = h.id_horario)
JOIN salones s ON (c.fk_salones = s.id_salon)
WHERE locate('lunes',h.dias_semana) > 0;

-- Vista que muestra los cursos que se dan los martes
CREATE OR REPLACE VIEW cursos_martes AS
SELECT c.clave_curso Clave_curso, m.nombre Materia, concat(p.nombre,' ',p.apellido_p,' ',p.apellido_m) Profesor, g.grupo Grupo, concat(h.dias_semana,' | ',h.hora_inicio,' - ',h.hora_fin) Horario, s.salon Salon, ci.ciclo Ciclo FROM cursos c 
JOIN profesor p ON (c.fk_profesor = p.id_profesor)
JOIN materia m ON (c.fk_materia = m.id_materia)
JOIN ciclos ci ON (c.fk_ciclos = ci.id_ciclo)
JOIN grupos g ON (c.fk_grupos = g.id_grupo)
JOIN horario h ON (c.fk_horario = h.id_horario)
JOIN salones s ON (c.fk_salones = s.id_salon)
WHERE locate('martes',h.dias_semana) > 0;

-- Vista que muestra los cursos que se dan los miercoles
CREATE OR REPLACE VIEW cursos_miercoles AS
SELECT c.clave_curso Clave_curso, m.nombre Materia, concat(p.nombre,' ',p.apellido_p,' ',p.apellido_m) Profesor, g.grupo Grupo, concat(h.dias_semana,' | ',h.hora_inicio,' - ',h.hora_fin) Horario, s.salon Salon, ci.ciclo Ciclo FROM cursos c 
JOIN profesor p ON (c.fk_profesor = p.id_profesor)
JOIN materia m ON (c.fk_materia = m.id_materia)
JOIN ciclos ci ON (c.fk_ciclos = ci.id_ciclo)
JOIN grupos g ON (c.fk_grupos = g.id_grupo)
JOIN horario h ON (c.fk_horario = h.id_horario)
JOIN salones s ON (c.fk_salones = s.id_salon)
WHERE locate('miercoles',h.dias_semana) > 0;

-- Vista que muestra los cursos que se dan los jueves
CREATE OR REPLACE VIEW cursos_jueves AS
SELECT c.clave_curso Clave_curso, m.nombre Materia, concat(p.nombre,' ',p.apellido_p,' ',p.apellido_m) Profesor, g.grupo Grupo, concat(h.dias_semana,' | ',h.hora_inicio,' - ',h.hora_fin) Horario, s.salon Salon, ci.ciclo Ciclo FROM cursos c 
JOIN profesor p ON (c.fk_profesor = p.id_profesor)
JOIN materia m ON (c.fk_materia = m.id_materia)
JOIN ciclos ci ON (c.fk_ciclos = ci.id_ciclo)
JOIN grupos g ON (c.fk_grupos = g.id_grupo)
JOIN horario h ON (c.fk_horario = h.id_horario)
JOIN salones s ON (c.fk_salones = s.id_salon)
WHERE locate('jueves',h.dias_semana) > 0;

-- Vista que muestra los cursos que se dan los viernes
CREATE OR REPLACE VIEW cursos_viernes AS
SELECT c.clave_curso Clave_curso, m.nombre Materia, concat(p.nombre,' ',p.apellido_p,' ',p.apellido_m) Profesor, g.grupo Grupo, concat(h.dias_semana,' | ',h.hora_inicio,' - ',h.hora_fin) Horario, s.salon Salon, ci.ciclo Ciclo FROM cursos c 
JOIN profesor p ON (c.fk_profesor = p.id_profesor)
JOIN materia m ON (c.fk_materia = m.id_materia)
JOIN ciclos ci ON (c.fk_ciclos = ci.id_ciclo)
JOIN grupos g ON (c.fk_grupos = g.id_grupo)
JOIN horario h ON (c.fk_horario = h.id_horario)
JOIN salones s ON (c.fk_salones = s.id_salon)
WHERE locate('viernes',h.dias_semana) > 0;

-- Vista que muestra los cursos que se dan los sabado
CREATE OR REPLACE VIEW cursos_sabado AS
SELECT c.clave_curso Clave_curso, m.nombre Materia, concat(p.nombre,' ',p.apellido_p,' ',p.apellido_m) Profesor, g.grupo Grupo, concat(h.dias_semana,' | ',h.hora_inicio,' - ',h.hora_fin) Horario, s.salon Salon, ci.ciclo Ciclo FROM cursos c 
JOIN profesor p ON (c.fk_profesor = p.id_profesor)
JOIN materia m ON (c.fk_materia = m.id_materia)
JOIN ciclos ci ON (c.fk_ciclos = ci.id_ciclo)
JOIN grupos g ON (c.fk_grupos = g.id_grupo)
JOIN horario h ON (c.fk_horario = h.id_horario)
JOIN salones s ON (c.fk_salones = s.id_salon)
WHERE locate('sabado',h.dias_semana) > 0;

-- Vista que cuenta cuantos cursos tienen los profesores
CREATE OR REPLACE VIEW numero_cursos_profesor AS
SELECT concat(p.nombre,' ',p.apellido_p,' ',p.apellido_m) Profesor, count(concat(p.nombre,' ',p.apellido_p,' ',p.apellido_m)) Num_cursos FROM cursos c 
JOIN profesor p ON (c.fk_profesor = p.id_profesor)
GROUP BY concat(p.nombre,' ',p.apellido_p,' ',p.apellido_m);

-- Vista que cuenta cuantos cursos inscritos tienen los alumnos y muestra el promedio de sus calificaciones
CREATE OR REPLACE VIEW numero_cursos_estudiante AS
SELECT x.Estudiante, count(x.Estudiante) Num_cursos, avg(ca.calificacion) Promedio FROM ( SELECT concat(e.nombre,' ',e.apellido_p,' ',e.apellido_m) Estudiante, e.matricula Matricula, ca.nombre Carrera, i.id_inscripcion id_inscripcion FROM inscrito i 
JOIN cursos c ON (i.fk_cursos = c.id_curso)
JOIN estudiante e ON (i.fk_estudiante = e.id_estudiante)
JOIN carrera ca ON (e.fk_carrera = ca.id_carrera) ) x
JOIN calificaciones ca ON (x.id_inscripcion = ca.fk_inscrito)
GROUP BY x.Estudiante;

-- Vista que muestra cuantos estudiantes hay por materia
CREATE OR REPLACE VIEW estudiantes_materia AS
SELECT m.nombre Materia, count(i.fk_estudiante) Num_estudiantes FROM inscrito i 
JOIN cursos c ON (i.fk_cursos = c.id_curso)
JOIN materia m ON (c.fk_materia = m.id_materia)
GROUP BY m.nombre;

-- Vista que muestra cuantos estudiantes hay por carrera
CREATE OR REPLACE VIEW estudiantes_carrera AS
SELECT c.nombre Carrera, count(e.fk_carrera) Num_estudiantes FROM estudiante e 
JOIN carrera c ON (e.fk_carrera = c.id_carrera)
GROUP BY e.fk_carrera;

-- Vista que muestra cuantos estudiantes que hay por grupo
CREATE OR REPLACE VIEW estudiantes_grupo AS
SELECT g.grupo Grupo, count(i.fk_estudiante) Num_estudiantes FROM inscrito i 
JOIN cursos c ON (i.fk_cursos = c.id_curso)
JOIN grupos g ON (c.fk_grupos = g.id_grupo)
GROUP BY c.fk_grupos;

-- Vista que cuenta los estudiantes hay en la base
CREATE OR REPLACE VIEW total_estudiantes AS
SELECT count(id_estudiante) Num_estudiantes FROM estudiante;

-- Vista que cuenta los profesores que hay en la base
CREATE OR REPLACE VIEW total_profesores AS
SELECT count(id_profesor) Num_profesores FROM profesor;