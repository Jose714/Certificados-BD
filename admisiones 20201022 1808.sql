-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.28-rc-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema admisiones
--

CREATE DATABASE IF NOT EXISTS admisiones;
USE admisiones;

--
-- Definition of table `documentos`
--

DROP TABLE IF EXISTS `documentos`;
CREATE TABLE `documentos` (
  `doc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doc_nombre` varchar(100) NOT NULL,
  `doc_descripcion` longtext,
  `doc_imagen` varchar(100) DEFAULT NULL,
  `doc_costo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `documentos`
--

/*!40000 ALTER TABLE `documentos` DISABLE KEYS */;
INSERT INTO `documentos` (`doc_id`,`doc_nombre`,`doc_descripcion`,`doc_imagen`,`doc_costo`) VALUES 
 (1,'Certificado de estudio',NULL,NULL,'12500'),
 (2,'Certificado de notas',NULL,NULL,'12500'),
 (3,'Certificado academico extendido',NULL,NULL,'12500'),
 (4,'Certificado academico extendido SALUD',NULL,NULL,'12500'),
 (5,'Certificado de giro adicional ICETEX',NULL,NULL,'12500'),
 (6,'Certificado de terminacion de materias',NULL,NULL,'12500'),
 (7,'Certificado para sorteo de rural',NULL,NULL,'12500'),
 (8,'Certificado de egresado',NULL,NULL,'12500'),
 (9,'Boletin',NULL,NULL,'12500');
/*!40000 ALTER TABLE `documentos` ENABLE KEYS */;


--
-- Definition of table `historial_acciones`
--

DROP TABLE IF EXISTS `historial_acciones`;
CREATE TABLE `historial_acciones` (
  `his_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `his_fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `his_usuario` int(10) unsigned NOT NULL,
  `his_pagina_visitada` varchar(45) NOT NULL,
  `his_ip` varchar(45) NOT NULL,
  `his_pagina_referencia` longtext NOT NULL,
  PRIMARY KEY (`his_id`),
  KEY `FK_historial_acciones_1` (`his_usuario`),
  CONSTRAINT `FK_historial_acciones_1` FOREIGN KEY (`his_usuario`) REFERENCES `usuarios` (`usr_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `historial_acciones`
--

/*!40000 ALTER TABLE `historial_acciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_acciones` ENABLE KEYS */;


--
-- Definition of table `solicitudes`
--

DROP TABLE IF EXISTS `solicitudes`;
CREATE TABLE `solicitudes` (
  `sol_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sol_tipo_documento` int(10) unsigned NOT NULL,
  `sol_fecha_solicitud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sol_estado` int(10) unsigned NOT NULL,
  `sol_solicitante` int(10) unsigned NOT NULL,
  `sol_observacion` longtext,
  `sol_documento_adjunto` varchar(100) DEFAULT NULL,
  `sol_soporte_pago` varchar(100) DEFAULT NULL,
  `sol_factura` varchar(100) DEFAULT NULL,
  `sol_valor_total` varchar(45) NOT NULL,
  `sol_ultima_modificacion` datetime DEFAULT NULL,
  `sol_responsable` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`sol_id`),
  KEY `FK_solicitudes_1` (`sol_solicitante`),
  KEY `FK_solicitudes_2` (`sol_tipo_documento`),
  CONSTRAINT `FK_solicitudes_1` FOREIGN KEY (`sol_solicitante`) REFERENCES `usuarios` (`usr_id`),
  CONSTRAINT `FK_solicitudes_2` FOREIGN KEY (`sol_tipo_documento`) REFERENCES `documentos` (`doc_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `solicitudes`
--

/*!40000 ALTER TABLE `solicitudes` DISABLE KEYS */;
/*!40000 ALTER TABLE `solicitudes` ENABLE KEYS */;


--
-- Definition of table `solicitudes_semestres`
--

DROP TABLE IF EXISTS `solicitudes_semestres`;
CREATE TABLE `solicitudes_semestres` (
  `sxs_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sxs_id_solicitud` int(10) unsigned NOT NULL,
  `sxs_semestre` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sxs_id`),
  KEY `FK_solicitudes_semestres_1` (`sxs_id_solicitud`),
  CONSTRAINT `FK_solicitudes_semestres_1` FOREIGN KEY (`sxs_id_solicitud`) REFERENCES `solicitudes` (`sol_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `solicitudes_semestres`
--

/*!40000 ALTER TABLE `solicitudes_semestres` DISABLE KEYS */;
/*!40000 ALTER TABLE `solicitudes_semestres` ENABLE KEYS */;


--
-- Definition of table `tipos_usuarios`
--

DROP TABLE IF EXISTS `tipos_usuarios`;
CREATE TABLE `tipos_usuarios` (
  `tip_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tip_nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`tip_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipos_usuarios`
--

/*!40000 ALTER TABLE `tipos_usuarios` DISABLE KEYS */;
INSERT INTO `tipos_usuarios` (`tip_id`,`tip_nombre`) VALUES 
 (1,'Jefe admisiones'),
 (2,'Asistente admisiones'),
 (3,'Caja'),
 (4,'Estudiante'),
 (5,'Egresado');
/*!40000 ALTER TABLE `tipos_usuarios` ENABLE KEYS */;


--
-- Definition of table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `usr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usr_correo` varchar(100) NOT NULL,
  `usr_clave` varchar(45) NOT NULL,
  `usr_nombre` varchar(45) NOT NULL,
  `usr_tipo` int(10) unsigned NOT NULL,
  `usr_telefono` varchar(45) DEFAULT NULL,
  `usr_estado` int(10) unsigned DEFAULT '0' COMMENT 'Activo - Inactivo',
  `usr_ultimo_acceso` datetime DEFAULT NULL,
  `usr_cedula` varchar(45) DEFAULT NULL,
  `usr_codigo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`usr_id`),
  KEY `FK_usuarios_1` (`usr_tipo`),
  CONSTRAINT `FK_usuarios_1` FOREIGN KEY (`usr_tipo`) REFERENCES `tipos_usuarios` (`tip_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuarios`
--

/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`usr_id`,`usr_correo`,`usr_clave`,`usr_nombre`,`usr_tipo`,`usr_telefono`,`usr_estado`,`usr_ultimo_acceso`,`usr_cedula`,`usr_codigo`) VALUES 
 (1,'jomejia@unac.edu.co','7110eda4d09e062aa5e4a390b0a572ac0d2c0220','Jhon Oderman',4,'3006075800',1,NULL,'1051820890','20131064190'),
 (2,'admisiones@unac.edu.co','7110eda4d09e062aa5e4a390b0a572ac0d2c0220','Sara',1,NULL,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
