CREATE DATABASE  IF NOT EXISTS `serenazgo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `serenazgo`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: serenazgo
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `delito`
--

DROP TABLE IF EXISTS `delito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delito` (
  `id_delito` int NOT NULL AUTO_INCREMENT,
  `delito` varchar(60) DEFAULT NULL,
  `tipo_delito_fk` int NOT NULL,
  PRIMARY KEY (`id_delito`),
  KEY `FK_TIPO_DELITO` (`tipo_delito_fk`),
  CONSTRAINT `FK_TIPO_DELITO` FOREIGN KEY (`tipo_delito_fk`) REFERENCES `tipo_delito` (`id_tipo_delito`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delito`
--

LOCK TABLES `delito` WRITE;
/*!40000 ALTER TABLE `delito` DISABLE KEYS */;
INSERT INTO `delito` VALUES (1,'Homicidio',1),(2,'Lesiones',1),(3,'Feminicidio',1),(4,'Robo',2),(5,'Hurto',2),(6,'Extorsi√≥n',2),(7,'Estafa',2),(8,'Apropiaci√≥n il√≠cita',2),(9,'Secuestro',3),(10,'Amenazas',3),(11,'Coacci√≥n',3),(12,'Tr√°fico il√≠cito de personas',3),(13,'Violaci√≥n',4),(14,'Actos contra el pudor',4),(15,'Prostituci√≥n forzada',4),(16,'Trata de personas con fines de explotaci√≥n sexual',4),(17,'Perturbaci√≥n de la paz',5),(18,'Resistencia a la autoridad',5),(19,'Desobediencia y resistencia a la autoridad',5),(20,'Corrupci√≥n',6),(21,'Cohecho',6),(22,'Peculado',6),(23,'Enriquecimiento il√≠cito',6),(24,'Tr√°fico il√≠cito de drogas',7),(25,'Tenencia y posesi√≥n ilegal de drogas',7),(26,'Violencia familiar',8),(27,'Abandono de familia',8);
/*!40000 ALTER TABLE `delito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `denuncia`
--

DROP TABLE IF EXISTS `denuncia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `denuncia` (
  `id_denuncia` int NOT NULL AUTO_INCREMENT,
  `detalles` varchar(500) DEFAULT NULL,
  `direccion` varchar(150) NOT NULL,
  `coordenadas` point NOT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delito_fk` int NOT NULL,
  `denunciante_fk` int DEFAULT NULL,
  `usuario_fk` int NOT NULL,
  `patrullaje_fk` int DEFAULT NULL,
  PRIMARY KEY (`id_denuncia`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `denuncia`
--

LOCK TABLES `denuncia` WRITE;
/*!40000 ALTER TABLE `denuncia` DISABLE KEYS */;
INSERT INTO `denuncia` VALUES (1,'Denuncia de robo a tienda','Calle 10 # 20-30',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0#@fffffÜR¿','2023-11-27 18:00:00',1,1,1,4),(2,'Denuncia de accidente de tr√°nsito','Avenida 15 # 25-40',_binary '\0\0\0\0\0\0\0öôôôôô(@33333sR¿','2023-11-27 17:00:00',2,1,2,4),(3,'Denuncia de violencia dom√©stica','Ruta 20 # 30-50',_binary '\0\0\0\0\0\0\0ffffff/@öôôôôR¿','2023-11-27 14:00:00',3,20,2,4),(4,'Denuncia de hurto a domicilio','Calle 25 # 35-60',_binary '\0\0\0\0\0\0\03333332@öôôôô˘Q¿','2023-11-27 18:00:00',4,15,4,4),(5,'Denuncia de incendio forestal','Avenida 30 #40-70',_binary '\0\0\0\0\0\0\0\0\0\0\0\0Ä5@33333≥Q¿','2023-11-27 14:00:00',1,1,4,4),(6,'Denuncia de contaminaci√≥n ambiental','Ruta35 #45-80',_binary '\0\0\0\0\0\0\0\Õ\Ã\Ã\Ã\Ã\Ã8@\Õ\Ã\Ã\Ã\ÃlQ¿','2023-11-27 15:00:00',1,8,18,4);
/*!40000 ALTER TABLE `denuncia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patrullaje`
--

DROP TABLE IF EXISTS `patrullaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patrullaje` (
  `id_patrullaje` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) DEFAULT NULL,
  `fk_turno` int NOT NULL,
  `fk_unidad` int NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_patrullaje`),
  KEY `fk_turno` (`fk_turno`),
  KEY `fk_unidad` (`fk_unidad`),
  CONSTRAINT `fk_turno` FOREIGN KEY (`fk_turno`) REFERENCES `turno` (`id_turno`),
  CONSTRAINT `fk_unidad` FOREIGN KEY (`fk_unidad`) REFERENCES `unidad` (`id_unidad`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patrullaje`
--

LOCK TABLES `patrullaje` WRITE;
/*!40000 ALTER TABLE `patrullaje` DISABLE KEYS */;
INSERT INTO `patrullaje` VALUES (3,'grupo',1,1,'2023-10-17 12:02:40',1),(4,'grupo de serenos',2,1,'2023-10-17 12:03:19',1),(5,'grupo de serenos',3,1,'2023-10-17 12:18:47',1),(6,'',3,3,'2023-10-18 11:27:08',1),(7,'',1,3,'2023-10-18 11:27:43',1),(8,NULL,1,5,'2023-10-18 11:27:52',1);
/*!40000 ALTER TABLE `patrullaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `id_persona` int NOT NULL AUTO_INCREMENT,
  `dni` char(8) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `fecha_naci` date NOT NULL,
  `sexo` varchar(20) NOT NULL,
  `direccion` varchar(30) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `correo` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,'12345678','Juan','Perez','1990-05-15','Masculino','Calle 123','123456789','juan.perez@email.com'),(2,'87654321','Maria','Gomez','1985-08-22','Femenino','Avenida 456','987654321','maria.gomez@email.com'),(3,'23456789','Carlos','Rodriguez','1995-02-10','Masculino','Carrera 789','456789012','carlos.rodriguez@email.com'),(4,'34567890','Laura','Lopez','1980-11-30','Femenino','Calle 567','789012345','laura.lopez@email.com'),(5,'45678901','Pedro','Garcia','1988-07-05','Masculino','Avenida 890','012345678','pedro.garcia@email.com'),(6,'56789012','Ana','Martinez','1992-09-18','Femenino','Calle 678','234567890','ana.martinez@email.com'),(7,'67890123','Javier','Sanchez','1983-04-03','Masculino','Avenida 901','345678901','javier.sanchez@email.com'),(8,'78901234','Sofia','Fernandez','1998-12-25','Femenino','Calle 789','456789012','sofia.fernandez@email.com'),(9,'89012345','Diego','Luna','1987-06-08','Masculino','Carrera 012','567890123','diego.luna@email.com'),(10,'90123456','Elena','Hernandez','1993-03-12','Femenino','Avenida 123','678901234','elena.hernandez@email.com'),(11,'11223344','Raul','Diaz','1982-01-20','Masculino','Calle 456','789012345','raul.diaz@email.com'),(12,'22334455','Clara','Ruiz','1997-07-14','Femenino','Carrera 789','890123456','clara.ruiz@email.com'),(13,'33445566','Mario','Iglesias','1986-10-05','Masculino','Avenida 234','901234567','mario.iglesias@email.com'),(14,'44556677','Isabel','Lopez','1996-04-28','Femenino','Calle 567','012345678','isabel.lopez@email.com'),(15,'55667788','Alberto','Ortega','1984-08-17','Masculino','Carrera 890','123456789','alberto.ortega@email.com'),(16,'66778899','Lucia','Santos','1994-11-09','Femenino','Avenida 567','234567890','lucia.santos@email.com'),(17,'77889900','Hugo','Castro','1989-02-28','Masculino','Calle 678','345678901','hugo.castro@email.com'),(18,'88990011','Marta','Gutierrez','1990-06-15','Femenino','Carrera 901','456789012','marta.gutierrez@email.com'),(19,'99001122','Juan','Molina','1981-03-30','Masculino','Avenida 123','567890123','juan.molina@email.com'),(20,'00112233','Luisa','Perez','1999-09-22','Femenino','Calle 456','678901234','luisa.perez@email.com');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sereno`
--

DROP TABLE IF EXISTS `sereno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sereno` (
  `id_sereno` int NOT NULL AUTO_INCREMENT,
  `dni` varchar(8) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `genero` tinyint NOT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `correo` varchar(30) DEFAULT NULL,
  `direccion` varchar(30) DEFAULT NULL,
  `nacimiento` date NOT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `fk_patrullaje` int DEFAULT NULL,
  PRIMARY KEY (`id_sereno`),
  KEY `FK_Sereno_Patrullaje` (`fk_patrullaje`),
  CONSTRAINT `FK_Sereno_Patrullaje` FOREIGN KEY (`fk_patrullaje`) REFERENCES `patrullaje` (`id_patrullaje`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sereno`
--

LOCK TABLES `sereno` WRITE;
/*!40000 ALTER TABLE `sereno` DISABLE KEYS */;
INSERT INTO `sereno` VALUES (2,'75115452','postman11','postman',1,'94509800','postmail@gmail.com','calle postman 123','1996-12-30','female1.jpg',6),(5,'75115456','test2','test2',1,'','','','2000-12-31','user.png',8),(6,'75115456','Diego','Cruz Neciosup',1,'945098054','diego@gmail.com','Calle San Jos√© 804','1996-03-14',NULL,3),(7,'75115452','dasd','dsadas',1,'','','','2001-02-06',NULL,7),(8,'45697420','dasdas','dasdas',0,'12312312','','','2004-01-04',NULL,NULL);
/*!40000 ALTER TABLE `sereno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_delito`
--

DROP TABLE IF EXISTS `tipo_delito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_delito` (
  `id_tipo_delito` int NOT NULL AUTO_INCREMENT,
  `tipo_delito` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_delito`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_delito`
--

LOCK TABLES `tipo_delito` WRITE;
/*!40000 ALTER TABLE `tipo_delito` DISABLE KEYS */;
INSERT INTO `tipo_delito` VALUES (1,'Contra la vida y la integridad personal'),(2,'Contra el patrimonio'),(3,'Contra la libertad y la seguridad'),(4,'Contra la libertad sexual'),(5,'Contra la tranquilidad p√∫blica'),(6,'Contra la administraci√≥n p√∫blica'),(7,'Contra la salud p√∫blica'),(8,'Contra la familia');
/*!40000 ALTER TABLE `tipo_delito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_unidad`
--

DROP TABLE IF EXISTS `tipo_unidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_unidad` (
  `id_tipo_unidad` int NOT NULL AUTO_INCREMENT,
  `tipo_unidad` varchar(200) NOT NULL,
  PRIMARY KEY (`id_tipo_unidad`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_unidad`
--

LOCK TABLES `tipo_unidad` WRITE;
/*!40000 ALTER TABLE `tipo_unidad` DISABLE KEYS */;
INSERT INTO `tipo_unidad` VALUES (1,'Auto'),(2,'Camioneta'),(3,'Motocicleta'),(4,'Cami√≥n');
/*!40000 ALTER TABLE `tipo_unidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_usu`
--

DROP TABLE IF EXISTS `tipo_usu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_usu` (
  `id_tipo_us` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo_us`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_usu`
--

LOCK TABLES `tipo_usu` WRITE;
/*!40000 ALTER TABLE `tipo_usu` DISABLE KEYS */;
INSERT INTO `tipo_usu` VALUES (1,'Root'),(2,'Administrador'),(3,'Operador');
/*!40000 ALTER TABLE `tipo_usu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno`
--

DROP TABLE IF EXISTS `turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turno` (
  `id_turno` int NOT NULL,
  `turno` varchar(200) NOT NULL,
  PRIMARY KEY (`id_turno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno`
--

LOCK TABLES `turno` WRITE;
/*!40000 ALTER TABLE `turno` DISABLE KEYS */;
INSERT INTO `turno` VALUES (1,'Ma√±ana'),(2,'Tarde'),(3,'Madrugada');
/*!40000 ALTER TABLE `turno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidad`
--

DROP TABLE IF EXISTS `unidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidad` (
  `id_unidad` int NOT NULL AUTO_INCREMENT,
  `placa` varchar(15) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_tipo_unidad` int DEFAULT NULL,
  `imagen` varchar(250) DEFAULT 'unidad.jpg',
  PRIMARY KEY (`id_unidad`),
  UNIQUE KEY `placa` (`placa`),
  KEY `fk_tipo_unidad` (`fk_tipo_unidad`),
  CONSTRAINT `unidad_ibfk_1` FOREIGN KEY (`fk_tipo_unidad`) REFERENCES `tipo_unidad` (`id_tipo_unidad`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidad`
--

LOCK TABLES `unidad` WRITE;
/*!40000 ALTER TABLE `unidad` DISABLE KEYS */;
INSERT INTO `unidad` VALUES (1,'abc123','carro 1',1,2,'C:UsersUSERDesktopangularserenosrcassetspolice_car.jpg'),(2,'xyz123','sin descripci√≥ne',0,1,'unidad.jpg'),(3,'abc101','prueba 2',1,1,'unidad.jpg'),(4,'abc102','prueba 2',1,1,'unidad.jpg'),(5,'abc103','prueba 2',1,1,'unidad.jpg'),(6,'xwe123','',0,3,'unidad.jpg'),(7,'rbv123','ds',1,2,'unidad.jpg');
/*!40000 ALTER TABLE `unidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `dni` varchar(8) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `nacimiento` date NOT NULL,
  `contrasena` varchar(200) NOT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `sexo` varchar(20) NOT NULL,
  `adicional` varchar(50) DEFAULT NULL,
  `foto` varchar(50) DEFAULT 'D:Proyectosfront_serenosrcassetsusers',
  `fk_tipo_us` int DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `fk_tipo_us` (`fk_tipo_us`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`fk_tipo_us`) REFERENCES `tipo_usu` (`id_tipo_us`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'12345678','Juan1','P√©rez1','1996-12-13','$2a$10$KZbuZ/STZL9PqaUSoVRuu.2RV0D/hFkTMOtqKqiZSYIWXyoetOkzO','juan@example1.com','Calle Principal 1231','9876543211','masculino','Informaci√≥n adicional','male2.jpg',1),(2,'87654321','Mar√≠a','G√≥mez','2023-10-17','$2a$10$DjDIdN7z5ewWGLE.siI27O0gvzPA91Azmm9MTooBPjXue1ChJozFG','maria@example.com','Avenida Secundaria 122','94509878563','femenino','Otra informaci√≥n','female1.jpg',3),(3,'23456789','Pedro','L√≥pez','1995-03-25','$2a$10$KZbuZ/STZL9PqaUSoVRuu.2RV0D/hFkTMOtqKqiZSYIWXyoetOkzO','pedro@example.com','Plaza Central 789','555-7777','masculino','M√°s informaci√≥n','male2.jpg',2),(4,'19191919','Karla','Nu√±ezs','1995-12-30','$2a$10$WAYJk1aoYlwyEsbUoBY7wuvzH71QjzQOwLfxfJyQwrjK1lPGWTFWy','karlas@example.com','Plazas Central 789','11111','femenino','M√°s informaci√≥n','male1.jpg',2),(18,'12345671','dasda','dsadsa','1996-01-11','$2a$10$YZwA5We80Vttr225oEl5Gu4VIVNhPyuYNVQNyWQL7sbzOx1c8Rwy2','das@gmail.com','31231','31231','masculino',NULL,'user.png',3);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'serenazgo'
--

--
-- Dumping routines for database 'serenazgo'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-27 13:45:44
