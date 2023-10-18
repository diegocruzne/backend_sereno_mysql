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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sereno`
--

LOCK TABLES `sereno` WRITE;
/*!40000 ALTER TABLE `sereno` DISABLE KEYS */;
INSERT INTO `sereno` VALUES (2,'75115452','postman1','postman',1,'94509800','postmail@gmail.com','calle postman 123','1996-12-30',NULL,NULL),(3,'75115452','postman2','postman2',1,'94509800','postmail@gmail.com','calle postman 123','1996-12-30',NULL,NULL),(4,'75115452','test_nombre','test_apellidos',0,'123','test@gmail.com','calle 123','2002-12-31',NULL,NULL),(5,'75115456','test2','test2',1,'','','','2000-12-31',NULL,NULL);
/*!40000 ALTER TABLE `sereno` ENABLE KEYS */;
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
INSERT INTO `tipo_unidad` VALUES (1,'Auto'),(2,'Camioneta'),(3,'Motocicleta'),(4,'Camión');
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
INSERT INTO `turno` VALUES (1,'Mañana'),(2,'Tarde'),(3,'Madrugada');
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
INSERT INTO `unidad` VALUES (1,'abc123','carro 2',1,2,'C:UsersUSERDesktopangularserenosrcassetspolice_car.jpg'),(2,'xyz123','sin descripcióne',0,1,'unidad.jpg'),(3,'abc101','prueba 2',0,1,'unidad.jpg'),(4,'abc102','prueba 2',1,1,'unidad.jpg'),(5,'abc103','prueba 2',1,1,'unidad.jpg'),(6,'xwe123','',0,3,'unidad.jpg'),(7,'rbv123','',0,2,'unidad.jpg');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'12345678','Juan1','Pérez1','1996-12-13','$2a$10$o/GHMkLW5SaCNBUt.PsHAehniih57XI97uWqWJvs.hIVPy1E6Ehlu','juan@example1.com','Calle Principal 1231','9876543211','masculino','Información adicional','male2.jpg',1),(2,'87654321','María','Gómez','2023-10-17','$2a$10$s97Km.1rmDmNsJQ2MduSOuhIoSNxmRIz.u9pKG0kGreXorqTQItLK','marias@example.com','Avenida Secundaria 123','94509878563','femenino','Otra información','female1.jpg',2),(3,'23456789','Pedro','López','1995-03-25','$2a$10$EU0G2yYMiEX.I28.41.yQ.c0TNzVV7GuRJztSZGkoIPzylJu5hJBe','pedro@example.com','Plaza Central 789','555-7777','Masculino','Más información','male2.jpg',1);
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

-- Dump completed on 2023-10-18 12:21:28
