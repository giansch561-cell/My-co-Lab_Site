/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.6-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: mycolab_biblioteca
-- ------------------------------------------------------
-- Server version	11.8.6-MariaDB-0+deb13u1 from Debian

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `livros`
--

DROP TABLE IF EXISTS `livros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `livros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(10) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `subtitulo` varchar(255) DEFAULT NULL,
  `autor` varchar(255) DEFAULT NULL,
  `editora` varchar(255) DEFAULT NULL,
  `ano` varchar(50) DEFAULT NULL,
  `idioma` varchar(50) DEFAULT NULL,
  `isbn` varchar(50) DEFAULT NULL,
  `categoria_principal` varchar(100) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livros`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `livros` WRITE;
/*!40000 ALTER TABLE `livros` DISABLE KEYS */;
INSERT INTO `livros` VALUES
(1,'0001','Die wundersame Welt der Pilze','The Wonderful World of Mushrooms and Other Fungi','Helen L. Pursey','Albatros Verlag AG','1977','Alemão','0-600-36248-5','Micologia geral','indexado','Introdução geral à biologia, classificação, cogumelos comestíveis e venenosos.'),
(2,'0002','Pilze selbst anbauen','In Haus und Garten','Nicola Krämer; Jolanda Englbrecht','Ulmer','2021','Alemão','978-3-8001-0393-5','Cultivo de cogumelos','indexado','Guia prático de cultivo doméstico, substratos, espécies, spawn, colheita e conservação.'),
(3,'0003','Speisepilze selbst anbauen','Für drinnen und draußen','Stefanie Goldscheider','BLV / Gräfe und Unzer Verlag','2021','Alemão','978-3-8354-1805-9','Cultivo de cogumelos comestíveis','indexado','Manual prático para cultivo interior e exterior, espécies, problemas, colheita e processamento.'),
(4,'0004','Cogumelos do Norte de Portugal e Galiza',NULL,'Marisa Castro; Vítor López Román','MEL Editores','2009','Português','978-989-635-067-3','Identificação de espécies','indexado','Guia regional de espécies do Norte de Portugal e Galiza.'),
(5,'0005','Cogumelos','Como identificar, classificar e apanhar cogumelos. Guia de cogumelos venenosos e comestíveis.','Edmund Garnweidner','Everest Editora','1999','Português','972-750-418-3','Identificação e segurança','indexado','Guia de identificação, toxicologia, colheita, conservação e cultivo básico.'),
(6,'0006','Como produzir cogumelos',NULL,'António Ferreira Borges','Litexa Editora','2006','Português','978-972-578-176-0','Produção de cogumelos','indexado','Livro prático sobre produção de cogumelos, com foco em Agaricus e Pleurotus.'),
(7,'0007','Pilzführer','Sicher bestimmen, gefahrlos geniessen',NULL,NULL,NULL,'Alemão',NULL,'Identificação e segurança','indexado','Guia de campo para identificação segura e consumo sem risco.');
/*!40000 ALTER TABLE `livros` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `temas_indice`
--

DROP TABLE IF EXISTS `temas_indice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `temas_indice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `livro_codigo` varchar(10) NOT NULL,
  `tema` varchar(255) NOT NULL,
  `pagina_inicio` int(11) DEFAULT NULL,
  `pagina_fim` int(11) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `palavras_chave` text DEFAULT NULL,
  `prioridade` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `livro_codigo` (`livro_codigo`),
  CONSTRAINT `temas_indice_ibfk_1` FOREIGN KEY (`livro_codigo`) REFERENCES `livros` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temas_indice`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `temas_indice` WRITE;
/*!40000 ALTER TABLE `temas_indice` DISABLE KEYS */;
INSERT INTO `temas_indice` VALUES
(1,'0001','Einleitung',6,15,'Introdução','introdução,fungos,pilze','alta'),
(2,'0001','Hauptgruppen der Pilze',16,39,'Classificação','grupos,classificação,biologia','muito alta'),
(3,'0001','Eßbare Pilze',40,64,'Comestibilidade','comestíveis,identificação','muito alta'),
(4,'0001','Giftpilze',65,79,'Segurança','venenosos,tóxicos,identificação','muito alta'),
(5,'0002','Grundlagen',12,23,'Fundamentos','cultivo,fungos,substrato,spawn','muito alta'),
(6,'0002','Kultur auf Stroh',24,53,'Cultivo','palha,substrato,cultivo','muito alta'),
(7,'0002','Kultur auf Kaffee',54,55,'Cultivo','café,borras,cultivo','alta'),
(8,'0002','Kultur auf Holz',56,111,'Cultivo','madeira,troncos,shiitake','muito alta'),
(9,'0006','O que são os cogumelos',17,20,'Biologia','fungos,micélio,hifas,esporos','muito alta'),
(10,'0006','Produção de sementes de cogumelos',21,24,'Cultivo','spawn,semente,inóculo,micélio','muito alta'),
(11,'0006','Produção de Agaricus sp.',25,54,'Produção','agaricus,substrato,compostagem,cobertura','alta'),
(12,'0006','Produção de Pleurotus sp.',75,89,'Produção','pleurotus,cultivo,substrato','muito alta');
/*!40000 ALTER TABLE `temas_indice` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-06-21 14:16:58
