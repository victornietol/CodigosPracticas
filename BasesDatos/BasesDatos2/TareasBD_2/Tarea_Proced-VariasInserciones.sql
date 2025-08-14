-- TAREA
use tarea1_bd;

-- create table pruebas_dir like direccion;
/*
-- Trigger para que cada vez que haya un insert se guarde el usuario que realizo el cambio y la fecha
delimiter //
drop trigger if exists registro_insert_miembroRespaldo //
create trigger registro_insert_miembroRespaldo 
before insert on miembro_respaldo
for each row
begin
	set new.nombre_usuario = user();
    set new.fecha_modificacion = curdate();
end; //
delimiter ;
*/

-- Procedimiento almacenado para insertar varios usuarios
delimiter //
drop procedure if exists insert_varios //
create procedure insert_varios(num int,inserciones text)
begin
	-- variables para insercion en miembro
	declare nombre varchar(70);
    declare ap_pat varchar(45);
    declare ap_mat varchar(45);
    declare adeudo float;
    declare adeudo_str varchar(100);
    declare anio_nac date;
    declare anio_nac_str varchar(100);
    -- variables para insercion de la direccion de cada miembro
    declare calle varchar(30);
    declare num_ext int;
    declare num_ext_str varchar(100);
    declare cod_postal int;
    declare cod_postal_str varchar(100);
    declare colonia varchar(50);
    declare delegacion varchar(70);
    -- variables para controlar los ciclos e inserciones
    declare cont_inserciones int default 1;
    declare cont_campos int default 1;
    declare cont_commit int default 1; -- contador para el commit
    
    -- bucle para cada insercion, manejado por num de inserciones 
    while cont_inserciones <= num do
		set nombre = substring_index(substring_index(inserciones,',',cont_campos), ',',-1);
        set cont_campos = cont_campos + 1;
        
        set ap_pat = substring_index(substring_index(inserciones,',',cont_campos), ',',-1);
        set cont_campos = cont_campos + 1;
        
        set ap_mat = substring_index(substring_index(inserciones,',',cont_campos), ',',-1);
        set cont_campos = cont_campos + 1;
        
        set adeudo_str = substring_index(substring_index(inserciones,',',cont_campos), ',',-1);
        set adeudo = cast(adeudo_str as float);
        set cont_campos = cont_campos + 1;
        
        set anio_nac_str = substring_index(substring_index(inserciones,',',cont_campos), ',',-1);
        set anio_nac = cast(anio_nac_str as date);
        set cont_campos = cont_campos + 1;
        
        set calle = substring_index(substring_index(inserciones,',',cont_campos), ',',-1);
        set cont_campos = cont_campos +1 ;
        
        set num_ext_str = substring_index(substring_index(inserciones,',',cont_campos), ',',-1);
        set num_ext = cast(num_ext_str as signed);
        set cont_campos = cont_campos + 1;
        
        set cod_postal_str = substring_index(substring_index(inserciones,',',cont_campos), ',',-1);
        set cod_postal = cast(cod_postal_str as signed);
        set cont_campos = cont_campos + 1;

        set colonia = substring_index(substring_index(inserciones,',',cont_campos), ',',-1);
        set cont_campos = cont_campos +1 ;

        set delegacion = substring_index(substring_index(inserciones,',',cont_campos), ',',-1);
        set cont_campos = cont_campos +1 ;
        
        
		set cont_inserciones = cont_inserciones +1;
        
        -- si el conteo de inserciones es igual a 3 se hace commit
        insert into direccion(calle,numero_exterior,codigo_postal,colonia,delegacion) values (calle,num_ext,cod_postal,colonia,delegacion);
        insert into miembro(nombre,ap_paterno,ap_materno,adeudo,anio_nacimiento,fk_direccion) values (nombre,ap_pat,ap_mat,adeudo,anio_nac,(select id_direccion from pruebas_dir order by id_direccion desc limit 1));
        if cont_commit = 3 then
			commit;
            set cont_commit = 0;
        end if;
        
        set cont_commit = cont_commit +1;
    end while;
    
    -- se hace commit al finalizar el ciclo para aplicar lo restante
    commit;
end //
delimiter ;

-- call insert_varios(2,'uno,dos,tres,4,2024-02-02,uno,dos,tres,4,2025-02-02');
-- select * from pruebas_dir;
-- select * from pruebas;
-- select id_miembro from pruebas order by id_miembro desc limit 1;


call insert_varios(10,'Javier,González,López,356.78,1990-05-12,Reforma,123,12345,Condesa,Ciudad de México,María,Martínez,García,124.45,1985-08-23,Insurgentes,456,54321,Roma,Ciudad de México,Alejandro,Pérez,Hernández,789.12,1978-02-17,Juárez,789,67890,Polanco,Ciudad de México,Laura,Sánchez,Rodríguez,234.56,1993-11-05,Hidalgo,321,98765,Nápoles,Ciudad de México,Carlos,López,Martínez,789.01,1982-04-09,Madero,654,5678,Del Valle,Ciudad de México,Ana,García,Gómez,567.89,1975-07-15,Benito Juárez,987,45678,Doctores,Ciudad de México,Pedro,Hernández,Pérez,123.40,1998-09-21,Gante,852,34567,Tlalpan,Ciudad de México,Sofía,Díaz,Sánchez,901.23,1987-06-03,Reforma,741,23456,Condesa,Ciudad de México,Juan,Flores,González,456.70,1996-03-14,Insurgentes,159,87654,Roma,Ciudad de México,Luisa,Ramírez,Martínez,234.56,1980-10-27,Juárez,357,76543,Polanco,Ciudad de México');

call insert_varios(10,'Pablo,Torres,Hernández,890.12,1991-12-30,Hidalgo,258,65432,Nápoles,Ciudad de México,Elena,Gutiérrez,Gómez,123.45,1972-08-18,Madero,963,5432,Del Valle,Ciudad de México,Miguel,Mendoza,Pérez,345.67,1995-05-07,Benito Juárez,654,43210,Doctores,Ciudad de México,Martha,Díaz,Sánchez,678.90,1988-01-20,Gante,852,32109,Tlalpan,Ciudad de México,Jorge,Núñez,Martínez,901.23,1977-09-11,Reforma,741,21098,Condesa,Ciudad de México,Gabriela,Ruiz,González,234.56,1994-07-04,Insurgentes,159,10987,Roma,Ciudad de México,Fernando,Ortiz,Hernández,890.12,1981-02-15,Juárez,357,09876,Polanco,Ciudad de México,Alicia,Gómez,Gómez,567.89,1976-12-26,Hidalgo,963,98765,Nápoles,Ciudad de México,Ricardo,López,Pérez,123.40,1999-10-09,Madero,852,87651,Del Valle,Ciudad de México,Beatriz,García,Sánchez,901.23,1986-04-01,Benito Juárez,654,76543,Doctores,Ciudad de México');

call insert_varios(10,'Rodrigo,Hernández,Martínez,456.70,1997-11-22,Gante,852,65432,Tlalpan,Ciudad de México,Verónica,Sánchez,González,123.45,1973-03-05,Reforma,741,54321,Condesa,Ciudad de México,Cristina,Martínez,Hernández,890.12,1990-08-28,Insurgentes,15920,43210,Roma,Ciudad de México,Mónica,Pérez,Pérez,567.89,1992-01-08,Hidalgo,963,21098,Nápoles,Ciudad de México,Gustavo,González,Hernández,123.40,1974-09-29,Madero,852,10980,Del Valle,Ciudad de México,Ana,Sánchez,Sánchez,901.23,1983-05-12,Benito Juárez,654,09876,Doctores,Ciudad de México,Fabiola,Hernández,González,456.70,1998-02-03,Gante,852,98765,Tlalpan,Ciudad de México,Emilio,Martínez,Martínez,123.45,1971-10-16,Reforma,741,87654,Condesa,Ciudad de México,Patricia,Gómez,Gómez,890.12,1984-07-07,Insurgentes,159,76543,Roma,Ciudad de México,David,Pérez,Hernández,234.56,1978-04-29,Juárez,357,65432,Polanco,Ciudad de México');

call insert_varios(1,'Marta,Sánchez,García,567.89,1993-12-20,eje central,963,54321,Nápoles,Ciudad de México');