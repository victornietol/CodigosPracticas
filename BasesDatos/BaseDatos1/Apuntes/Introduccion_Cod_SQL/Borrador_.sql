select * from grados;
select * from niveles;
select * from evaluaciones;
select * from estados;
select * from alumnos;
select * from productor;
use prueba;

CREATE TABLE `productor` (
  `id_productor` INT NOT NULL AUTO_INCREMENT,
  `razon_social` VARCHAR(45) NOT NULL,
  `id_central` INT NOT NULL,
  PRIMARY KEY (`id_productor`),
  foreign key (`id_central`) references `centrales`(`id_central`)
  );
  
  CREATE TABLE `centrales` (
  `id_central` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_central`));
  
  CREATE TABLE `hidroelctrica` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_central` INT NOT NULL,
  `id_productor` INT NOT NULL,
  `ocupacion` varchar(50) not null,
  `capacidad_max` varchar(50) NOT NULL,
  `num_tur` int not null,
  PRIMARY KEY (`id`),
  foreign key (`id_central`) references `centrales`(`id_central`),
  foreign key (`id_productor`) references `productor`(`id_productor`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  unique key `uk_productor` (`id_productor`)
  );
  
    CREATE TABLE `nuclear` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_central` INT NOT NULL,
  `id_productor` INT NOT NULL,
  `onum_reactores` int not null,
  `vol_plutonio` varchar(50) NOT NULL,
  `num_residuos` int not null,
  PRIMARY KEY (`id`),
  foreign key (`id_central`) references `centrales`(`id_central`),
  foreign key (`id_productor`) references `productor`(`id_productor`)
  );
  
  insert into centrales values (null, 'HIDROELECTRICA'), (null, 'NUCLEAR');
  insert into productor values (null, 'NOMBRE 1', 1), (NULL, 'NOMBRE 2', 1), (NULL, 'NOMBRE 3', 2);
  insert into hidroelctrica values (null, 1, 1, 'UNA OCUOACIN', '10L', 10), 
  (null, 1, 2, 'UOTRA OCUPACION', '20L', 34);
  insert into nuclear values (null, 2, 3, 4, '40cm', 100);
  
select * from productor;
select * from centrales;
select * from hidroelctrica;
select * from nuclear;


select p.razon_social empresa, c.nombre tipo, p.id_productor from
productor p 
JOIN centrales c ON (p.id_central = c.id_central);

select * from productor p 
join  hidroelctrica h on (p.id_productor = h.id_productor);

select * from productor p 
join nuclear n on (p.id_productor = n.id_productor);
