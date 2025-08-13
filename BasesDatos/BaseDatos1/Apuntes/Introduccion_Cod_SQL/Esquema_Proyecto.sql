use proyecto_bd1_2459;

show tables from information_schema; 
select * from information_schema.tables;

-- TABLAS
select * from information_schema.tables where table_schema = 'proyecto_bd1_2459';

-- TRIGGERS
select * from information_schema.triggers where trigger_schema = 'proyecto_bd1_2459';

-- CONSTRAINSTS
select * from information_schema.table_constraints where constraint_schema = 'proyecto_bd1_2459';

-- VIEWS
select * from information_schema.views where table_schema = 'proyecto_bd1_2459';

-- INDICES
select * from information_schema.statistics where table_schema = 'proyecto_bd1_2459';