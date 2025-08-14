-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: tarea1_bd
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autores` (
  `id_autor` int NOT NULL AUTO_INCREMENT,
  `nacionalidad` varchar(70) NOT NULL,
  `nombre` varchar(70) NOT NULL,
  `ap_paterno` varchar(45) NOT NULL,
  `ap_materno` varchar(45) NOT NULL,
  `nombre_usuario` varchar(70) NOT NULL COMMENT 'Usuario que realizo la modificacion',
  `fecha_modificacion` date NOT NULL COMMENT 'Fecha de modificacion del registro',
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'China','Winifield','Gritland','Crock','Victor Nieto','2024-02-21'),(2,'Russia','Gaye','Alexsandrov','Flatte','Victor Nieto','2024-02-21'),(3,'Libya','Leone','Slator','McClaren','Victor Nieto','2024-02-21'),(4,'Indonesia','Sofie','Fashion','Scullin','Victor Nieto','2024-02-21'),(5,'Russia','Luisa','Winman','Joppich','Victor Nieto','2024-02-21'),(6,'Czech Republic','Borg','Skypp','Brooke','Victor Nieto','2024-02-21'),(7,'Indonesia','Monti','Hedditeh','Petren','Victor Nieto','2024-02-21'),(8,'Mexico','Aurthur','Boyne','Beatens','Victor Nieto','2024-02-21'),(9,'Indonesia','Almeria','Mitchenson','Clelland','Victor Nieto','2024-02-21'),(10,'Francia','St. Clair','Roofe','Shalne','Victor Nieto','2024-02-21'),(11,'Burkina_Faso','Gallen','Lusgdin','Zollie','Victor Nieto','2024-02-21'),(12,'Mexico','Kingsmill','Sheering','Mose','Victor Nieto','2024-02-21'),(13,'French Southern Territories','Sharia','Humblestone','Brandon','Victor Nieto','2024-02-21'),(14,'Madagascar','Brideaux','Cash','Trey','Victor Nieto','2024-02-21'),(15,'Nigeria','Patrica','Routhorn','Gilla','Victor Nieto','2024-02-21');
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccion` (
  `id_direccion` int NOT NULL AUTO_INCREMENT,
  `calle` varchar(30) NOT NULL,
  `numero_exterior` int NOT NULL,
  `numero_interior` int DEFAULT NULL,
  `codigo_postal` int NOT NULL,
  `colonia` varchar(50) NOT NULL,
  `delegacion` varchar(70) NOT NULL,
  `nombre_usuario` varchar(70) NOT NULL COMMENT 'Usuario que realizo la modificacion',
  `fecha_modificacion` date NOT NULL COMMENT 'Fecha de modificacion del registro',
  PRIMARY KEY (`id_direccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccion`
--

LOCK TABLES `direccion` WRITE;
/*!40000 ALTER TABLE `direccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libros`
--

DROP TABLE IF EXISTS `libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros` (
  `id_libros` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `genero` varchar(45) NOT NULL,
  `anio_publicacion` date NOT NULL,
  `editorial` varchar(70) NOT NULL,
  `clasificacion` varchar(20) NOT NULL,
  `costo` float NOT NULL,
  `prestamos_id_prestamos` int NOT NULL,
  `nombre_usuario` varchar(70) NOT NULL COMMENT 'Usuario que realizo la modificacion',
  `fecha_modificacion` date NOT NULL COMMENT 'Fecha de modificacion del registro',
  PRIMARY KEY (`id_libros`),
  KEY `prestamos_id_prestamos` (`prestamos_id_prestamos`),
  CONSTRAINT `libros_ibfk_1` FOREIGN KEY (`prestamos_id_prestamos`) REFERENCES `prestamos` (`id_prestamos`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros`
--

LOCK TABLES `libros` WRITE;
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` VALUES (1,'La sombra del viento','Dañado','Misterio','2001-04-27','Planeta','Adultos',22.99,8,'Victor Nieto','2024-02-21'),(2,'Harry Potter y la piedra filosofal','Disponible','Fantasía','1997-06-26','Bloomsbury Publishing','Niños',19.99,3,'Victor Nieto','2024-02-21'),(3,'Cien años de soledad','Prestado','Ficción','1967-05-30','Editorial Sudamericana','Adultos',25.99,12,'Victor Nieto','2024-02-21'),(4,'El código Da Vinci','Disponible','Misterio','2003-03-18','Doubleday','Adultos',15.5,7,'Victor Nieto','2024-02-21'),(5,'El alquimista','Disponible','Novela','1988-11-25','HarperCollins','Adolescentes',12.75,9,'Victor Nieto','2024-02-21'),(6,'1984','Disponible','Ciencia ficción','1949-06-08','Secker & Warburg','Adultos',18.25,6,'Victor Nieto','2024-02-21'),(7,'El principito','Prestado','Literatura infantil','1943-04-06','Reynal & Hitchcock','Niños',14.99,14,'Victor Nieto','2024-02-21'),(8,'Los juegos del hambre','Prestado','Ciencia ficción','2008-09-14','Scholastic Corporation','Adolescentes',20.75,2,'Victor Nieto','2024-02-21'),(9,'Romeo y Julieta','Dañado','Tragedia','1597-01-20','Thomas Cotes','Adolescentes',13.25,4,'Victor Nieto','2024-02-21'),(10,'Orgullo y prejuicio','Disponible','Clásico','1813-01-28','T. Egerton, Whitehall','Adultos',10,11,'Victor Nieto','2024-02-21'),(11,'Las crónicas de Narnia','Prestado','Fantasía','1950-10-16','Geoffrey Bles','Niños',27,5,'Victor Nieto','2024-02-21'),(12,'El señor de los anillos','Disponible','Fantasía','1954-07-29','George Allen & Unwin','Adolescentes',30.5,15,'Victor Nieto','2024-02-21'),(13,'Crónica de una muerte anunciada','Disponible','Ficción','1981-09-05','La Oveja Negra','Adolescentes',16.8,10,'Victor Nieto','2024-02-21'),(14,'El nombre del viento','Disponible','Fantasía','2007-03-27','Daw Books','Adultos',18.95,1,'Victor Nieto','2024-02-21'),(15,'El gran Gatsby','Disponible','Ficción','1925-04-10','Charles Scribner Sons','Adultos',21.5,13,'Victor Nieto','2024-02-21');
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libros_autores`
--

DROP TABLE IF EXISTS `libros_autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros_autores` (
  `id_libro` int NOT NULL AUTO_INCREMENT,
  `autores_id_autor` int NOT NULL,
  `libros_id_libros` int NOT NULL,
  `nombre_usuario` varchar(70) NOT NULL COMMENT 'Usuario que realizo la modificacion',
  `fecha_modificacion` date NOT NULL COMMENT 'Fecha de modificacion del registro',
  PRIMARY KEY (`id_libro`),
  KEY `autores_id_autor` (`autores_id_autor`),
  KEY `libros_id_libros` (`libros_id_libros`),
  CONSTRAINT `libros_autores_ibfk_1` FOREIGN KEY (`autores_id_autor`) REFERENCES `autores` (`id_autor`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `libros_autores_ibfk_2` FOREIGN KEY (`libros_id_libros`) REFERENCES `libros` (`id_libros`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros_autores`
--

LOCK TABLES `libros_autores` WRITE;
/*!40000 ALTER TABLE `libros_autores` DISABLE KEYS */;
INSERT INTO `libros_autores` VALUES (1,7,11,'Victor Nieto','2024-02-21'),(2,3,8,'Victor Nieto','2024-02-21'),(3,14,5,'Victor Nieto','2024-02-21'),(4,2,9,'Victor Nieto','2024-02-21'),(5,10,6,'Victor Nieto','2024-02-21'),(6,1,15,'Victor Nieto','2024-02-21'),(7,13,4,'Victor Nieto','2024-02-21'),(8,12,7,'Victor Nieto','2024-02-21'),(9,5,10,'Victor Nieto','2024-02-21'),(10,8,3,'Victor Nieto','2024-02-21'),(11,6,12,'Victor Nieto','2024-02-21'),(12,11,2,'Victor Nieto','2024-02-21'),(13,4,13,'Victor Nieto','2024-02-21'),(14,9,1,'Victor Nieto','2024-02-21'),(15,15,14,'Victor Nieto','2024-02-21');
/*!40000 ALTER TABLE `libros_autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `miembro`
--

DROP TABLE IF EXISTS `miembro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `miembro` (
  `id_miembro` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(70) NOT NULL,
  `ap_paterno` varchar(45) NOT NULL,
  `ap_materno` varchar(45) NOT NULL,
  `adeudo` float NOT NULL,
  `anio_nacimiento` date NOT NULL,
  `nombre_usuario` varchar(70) NOT NULL COMMENT 'Usuario que realizo la modificacion',
  `fecha_modificacion` date NOT NULL COMMENT 'Fecha de modificacion del registro',
  `fk_direccion` int DEFAULT NULL,
  PRIMARY KEY (`id_miembro`),
  KEY `fk_direccion` (`fk_direccion`),
  CONSTRAINT `miembro_ibfk_1` FOREIGN KEY (`fk_direccion`) REFERENCES `direccion` (`id_direccion`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `miembro`
--

LOCK TABLES `miembro` WRITE;
/*!40000 ALTER TABLE `miembro` DISABLE KEYS */;
INSERT INTO `miembro` VALUES (1,'Javier','Suárez','Pérez',103.34,'2002-12-11','Victor Nieto','2024-02-21',NULL),(2,'María','García','López',50.2,'1990-05-02','Victor Nieto','2024-02-21',NULL),(3,'Pedro','Martínez','Gómez',75.6,'1992-09-15','Victor Nieto','2024-02-21',NULL),(4,'Laura','Hernández','Rodríguez',20.1,'1985-10-07','Victor Nieto','2024-02-21',NULL),(5,'Carlos','Pérez','Sánchez',30.75,'1988-04-20','Victor Nieto','2024-02-21',NULL),(6,'Ana','González','Fernández',90,'1983-11-25','Victor Nieto','2024-02-21',NULL),(7,'Sofía','Díaz','Jiménez',15.4,'1995-01-30','Victor Nieto','2024-02-21',NULL),(8,'Luis','Ruiz','Vargas',45.3,'1998-03-08','Victor Nieto','2024-02-21',NULL),(9,'Diego','Flores','López',60.8,'1993-06-18','Victor Nieto','2024-02-21',NULL),(10,'Andrea','Gómez','Hernández',25,'1987-10-22','Victor Nieto','2024-02-21',NULL),(11,'Ana','López','García',150.2,'1989-05-15','Victor Nieto','2024-02-21',NULL),(12,'Pedro','Martínez','Hernández',80.5,'1995-08-20','Victor Nieto','2024-02-21',NULL),(13,'María','González','Rodríguez',45.7,'1980-03-10','Victor Nieto','2024-02-21',NULL),(14,'Juan','Sánchez','Pérez',30,'1992-11-25','Victor Nieto','2024-02-21',NULL),(15,'Laura','Díaz','Fernández',60.9,'1987-09-02','Victor Nieto','2024-02-21',NULL);
/*!40000 ALTER TABLE `miembro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamos` (
  `id_prestamos` int NOT NULL AUTO_INCREMENT,
  `fecha_inic` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `miembro_id_miembro` int NOT NULL,
  `nombre_usuario` varchar(70) NOT NULL COMMENT 'Usuario que realizo la modificacion',
  `fecha_modificacion` date NOT NULL COMMENT 'Fecha de modificacion del registro',
  PRIMARY KEY (`id_prestamos`),
  KEY `miembro_id_miembro` (`miembro_id_miembro`),
  CONSTRAINT `prestamos_ibfk_1` FOREIGN KEY (`miembro_id_miembro`) REFERENCES `miembro` (`id_miembro`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamos`
--

LOCK TABLES `prestamos` WRITE;
/*!40000 ALTER TABLE `prestamos` DISABLE KEYS */;
INSERT INTO `prestamos` VALUES (1,'2022-06-15','2022-07-20',9,'Victor Nieto','2024-02-21'),(2,'2022-06-15','2023-05-05',5,'Victor Nieto','2024-02-21'),(3,'2023-08-25','2023-09-30',13,'Victor Nieto','2024-02-21'),(4,'2022-12-01','2023-01-15',3,'Victor Nieto','2024-02-21'),(5,'2023-09-05','2023-11-20',8,'Victor Nieto','2024-02-21'),(6,'2022-10-20','2023-01-05',7,'Victor Nieto','2024-02-21'),(7,'2023-04-15','2023-08-15',14,'Victor Nieto','2024-02-21'),(8,'2023-07-01','2023-08-15',2,'Victor Nieto','2024-02-21'),(9,'2023-02-10','2023-04-30',12,'Victor Nieto','2024-02-21'),(10,'2023-05-20','2023-07-25',6,'Victor Nieto','2024-02-21'),(11,'2022-11-10','2023-01-20',4,'Victor Nieto','2024-02-21'),(12,'2022-11-10','2023-03-10',11,'Victor Nieto','2024-02-21'),(13,'2023-06-25','2023-09-15',10,'Victor Nieto','2024-02-21'),(14,'2022-08-05','2022-10-10',1,'Victor Nieto','2024-02-21'),(15,'2022-09-15','2022-11-25',15,'Victor Nieto','2024-02-21');
/*!40000 ALTER TABLE `prestamos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_libros_disponibles`
--

DROP TABLE IF EXISTS `vista_libros_disponibles`;
/*!50001 DROP VIEW IF EXISTS `vista_libros_disponibles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_libros_disponibles` AS SELECT 
 1 AS `Estado`,
 1 AS `TOTAL`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vista_libros_disponibles`
--

/*!50001 DROP VIEW IF EXISTS `vista_libros_disponibles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_libros_disponibles` AS select `libros`.`estado` AS `Estado`,count(0) AS `TOTAL` from `libros` where (`libros`.`estado` = 'Disponible') group by `libros`.`estado` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-28 19:39:58
