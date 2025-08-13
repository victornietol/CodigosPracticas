-- Comando SELECT
SELECT SYSDATE(), USER(), DATABASE();   -- usando variables con SELECT para ver diferente información, los campos se separan con comas
SELECT SYSDATE(), USER(), DATABASE(), current_date(), current_time(), current_timestamp();
SELECT 5*4 AS multiplicacion, 5-4 resta, 5+4 as suma, 5/4 division;  -- también se se pueden hacer operaciones ( <operacion> as <nombre del campo>)
select 'hola mundo'as saludo;

SELECT SYSDATE(), USER(), DATABASE(), current_date(), current_time(), current_timestamp(),
5*4 AS multiplicacion, 5-4 resta, 5+4 as suma, 5/4 division,
'hola mundo'as saludo, 1, 4>5, 4<5, 4<>4, 4!=4;  -- <== también regresa valores boleanos en cuanto a comparaciones (false=0, true=1)

show tables from colegio2459;

select * from alumnos; -- mostrando todos los campos 
show columns from colegio2459.alumnos;  -- mostrando los campos de una tabla 
desc alumnos;                           -- también se puede utilizar desc

select clave_alu, nombre, ap_paterno, ap_materno, peso, estatura   -- mostrando campos especificos
from alumnos;

-- NIETO LICONA VICTOR MANUEL
select clave_alu, nombre, ap_paterno, ap_materno, peso, estatura,   
sysdate(), peso * 1000 pesogramos, (estatura*100) as estaturacm,   -- generando vistas temporales con campos permanentes
(peso/(estatura*estatura)) imc
from alumnos;

-- Clausula ALL (viene implicita en select)
select ALL * from alumnos;

-- Clausula DISTINCT (va a mostrar una sola aparacion de valores que se tenga en la tabla)
select nombre from alumnos order by 1;
select distinct nombre from alumnos order by 1;  -- DISTINCT no regresa valores repetidos
select distinct sexo from alumnos order by 1;

select distinct nombre, ap_paterno from alumnos order by 1;  -- si se combina con otro dato entonces muestra más vistas temporales aunque se repita un campo en especifico porque al unirlos hace que se repitan menos 
select distinct nombre, ap_paterno, clave_alu from alumnos order by 1;

select distinct ciudad from alumnos order by 1;