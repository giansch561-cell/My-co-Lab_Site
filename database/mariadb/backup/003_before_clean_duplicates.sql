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
-- Table structure for table `modulos_estudo`
--

DROP TABLE IF EXISTS `modulos_estudo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modulos_estudo` (
  `codigo` varchar(10) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `fase` varchar(100) DEFAULT NULL,
  `objetivo` text DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulos_estudo`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `modulos_estudo` WRITE;
/*!40000 ALTER TABLE `modulos_estudo` DISABLE KEYS */;
INSERT INTO `modulos_estudo` VALUES
('M001','O que são fungos?','Fase 1 — Fundamentos da Micologia','Perceber a definição de fungo e o reino dos fungos.'),
('M002','O que é um cogumelo?','Fase 1 — Fundamentos da Micologia','Distinguir fungo, micélio e corpo frutífero.'),
('M003','Ciclo de vida dos fungos','Fase 1 — Fundamentos da Micologia','Perceber esporos, hifas, micélio e frutificação.'),
('M004','Morfologia','Fase 1 — Fundamentos da Micologia','Reconhecer partes visíveis dos cogumelos.'),
('M005','Classificação','Fase 1 — Fundamentos da Micologia','Perceber níveis básicos de classificação.'),
('M006','Fisiologia','Fase 1 — Fundamentos da Micologia','Perceber crescimento, nutrição, temperatura e humidade.'),
('M007','Ecologia','Fase 1 — Fundamentos da Micologia','Perceber decompositores, micorrizas e parasitas.');
/*!40000 ALTER TABLE `modulos_estudo` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `modulos_fontes`
--

DROP TABLE IF EXISTS `modulos_fontes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modulos_fontes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modulo_codigo` varchar(10) DEFAULT NULL,
  `livro_codigo` varchar(10) DEFAULT NULL,
  `tema_id` int(11) DEFAULT NULL,
  `prioridade` varchar(50) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modulo_codigo` (`modulo_codigo`),
  KEY `livro_codigo` (`livro_codigo`),
  KEY `tema_id` (`tema_id`),
  CONSTRAINT `modulos_fontes_ibfk_1` FOREIGN KEY (`modulo_codigo`) REFERENCES `modulos_estudo` (`codigo`),
  CONSTRAINT `modulos_fontes_ibfk_2` FOREIGN KEY (`livro_codigo`) REFERENCES `livros` (`codigo`),
  CONSTRAINT `modulos_fontes_ibfk_3` FOREIGN KEY (`tema_id`) REFERENCES `temas_indice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulos_fontes`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `modulos_fontes` WRITE;
/*!40000 ALTER TABLE `modulos_fontes` DISABLE KEYS */;
/*!40000 ALTER TABLE `modulos_fontes` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temas_indice`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `temas_indice` WRITE;
/*!40000 ALTER TABLE `temas_indice` DISABLE KEYS */;
INSERT INTO `temas_indice` VALUES
(13,'0001','Einleitung',6,15,'Introdução','introdução,pilze,fungos,micologia','alta'),
(14,'0001','Hauptgruppen der Pilze',16,39,'Classificação','grupos principais,classificação,fungos,pilze','muito alta'),
(15,'0001','Eßbare Pilze',40,64,'Comestibilidade','cogumelos comestíveis,edible mushrooms,essbare pilze,identificação','muito alta'),
(16,'0001','Giftpilze',65,79,'Segurança','cogumelos venenosos,giftpilze,toxicidade,intoxicação','muito alta'),
(17,'0001','Pilze in Wirklichkeit und Legende',80,95,'História e cultura','história,cultura,lendas,mitologia,pilze','média'),
(18,'0001','Stichwortverzeichnis',96,NULL,'Índice remissivo','índice,stichwortverzeichnis,referência','baixa'),
(19,'0001','Einleitung',6,15,'Introdução','introdução,pilze,fungos,micologia','alta'),
(20,'0001','Hauptgruppen der Pilze',16,39,'Classificação','grupos principais,classificação,fungos,pilze','muito alta'),
(21,'0001','Eßbare Pilze',40,64,'Comestibilidade','cogumelos comestíveis,edible mushrooms,essbare pilze,identificação','muito alta'),
(22,'0001','Giftpilze',65,79,'Segurança','cogumelos venenosos,giftpilze,toxicidade,intoxicação','muito alta'),
(23,'0001','Pilze in Wirklichkeit und Legende',80,95,'História e cultura','história,cultura,lendas,mitologia,pilze','média'),
(24,'0001','Stichwortverzeichnis',96,NULL,'Índice remissivo','índice,stichwortverzeichnis,referência','baixa'),
(25,'0002','Grundlagen',12,23,'Fundamentos','fundamentos,fungos,pilze,cultivo,substrato,spawn','muito alta'),
(26,'0002','Kultur auf Stroh',24,53,'Cultivo','palha,stroh,substrato,cultivo,austernpilz','muito alta'),
(27,'0002','Kultur auf Kaffee',54,55,'Cultivo','café,kaffee,borras de café,substrato','alta'),
(28,'0002','Kultur auf Holz',56,111,'Cultivo','madeira,holz,troncos,shiitake,nameko','muito alta'),
(29,'0002','Kultur auf Kompost',112,133,'Cultivo','composto,kompost,champignon,agaricus','alta'),
(30,'0002','Fertigkulturen',134,151,'Cultivo doméstico','culturas prontas,fertigkulturen,kits de cultivo','alta'),
(31,'0002','Brut selbst herstellen',152,157,'Produção de spawn','spawn,pilzbrut,inóculo,laboratório,esterilidade','muito alta'),
(32,'0002','Ernte',158,158,'Colheita','colheita,ernte,ponto de colheita','alta'),
(33,'0002','Lagerung',159,159,'Pós-colheita','armazenamento,lagerung,conservação','alta'),
(34,'0002','Trocknung',159,160,'Conservação','secagem,trocknung,desidratação','alta'),
(35,'0002','Rezepte',161,176,'Receitas','receitas,rezepte,cozinha,cogumelos','baixa'),
(36,'0001','Einleitung',6,15,'Introdução','introdução,pilze,fungos,micologia','alta'),
(37,'0001','Hauptgruppen der Pilze',16,39,'Classificação','grupos principais,classificação,fungos,pilze','muito alta'),
(38,'0001','Eßbare Pilze',40,64,'Comestibilidade','cogumelos comestíveis,edible mushrooms,essbare pilze,identificação','muito alta'),
(39,'0001','Giftpilze',65,79,'Segurança','cogumelos venenosos,giftpilze,toxicidade,intoxicação','muito alta'),
(40,'0001','Pilze in Wirklichkeit und Legende',80,95,'História e cultura','história,cultura,lendas,mitologia,pilze','média'),
(41,'0001','Stichwortverzeichnis',96,NULL,'Índice remissivo','índice,stichwortverzeichnis,referência','baixa'),
(42,'0002','Grundlagen',12,23,'Fundamentos','fundamentos,fungos,pilze,cultivo,substrato,spawn','muito alta'),
(43,'0002','Kultur auf Stroh',24,53,'Cultivo','palha,stroh,substrato,cultivo,austernpilz','muito alta'),
(44,'0002','Kultur auf Kaffee',54,55,'Cultivo','café,kaffee,borras de café,substrato','alta'),
(45,'0002','Kultur auf Holz',56,111,'Cultivo','madeira,holz,troncos,shiitake,nameko','muito alta'),
(46,'0002','Kultur auf Kompost',112,133,'Cultivo','composto,kompost,champignon,agaricus','alta'),
(47,'0002','Fertigkulturen',134,151,'Cultivo doméstico','culturas prontas,fertigkulturen,kits de cultivo','alta'),
(48,'0002','Brut selbst herstellen',152,157,'Produção de spawn','spawn,pilzbrut,inóculo,laboratório,esterilidade','muito alta'),
(49,'0002','Ernte',158,158,'Colheita','colheita,ernte,ponto de colheita','alta'),
(50,'0002','Lagerung',159,159,'Pós-colheita','armazenamento,lagerung,conservação','alta'),
(51,'0002','Trocknung',159,160,'Conservação','secagem,trocknung,desidratação','alta'),
(52,'0002','Rezepte',161,176,'Receitas','receitas,rezepte,cozinha,cogumelos','baixa'),
(53,'0003','Leben und Wachsen',10,18,'Biologia','vida,crescimento,fungos,pilze,nutrição,reprodução,ecologia','muito alta'),
(54,'0003','Grundlagen der Pilzzucht',19,31,'Fundamentos de cultivo','cultivo,condições de crescimento,sazonalidade,micélio,spawn','muito alta'),
(55,'0003','Übersicht der Anbaumethoden',32,42,'Métodos de cultivo','métodos,cultivo interior,cultivo exterior,equipamentos,kits','muito alta'),
(56,'0003','Anbau im Freien',43,53,'Cultivo exterior','exterior,jardim,madeira,palha,canteiros','alta'),
(57,'0003','Probleme',54,59,'Problemas e sanidade','problemas,pragas,doenças,contaminação,cultivo','alta'),
(58,'0003','Frühlingspilze',60,67,'Espécies','espécies primavera,frühling,sazonalidade','média'),
(59,'0003','Sommerpilze',68,73,'Espécies','espécies verão,sommer,sazonalidade','média'),
(60,'0003','Herbstpilze',74,86,'Espécies','espécies outono,herbst,sazonalidade','média'),
(61,'0003','Winterpilze',87,99,'Espécies','espécies inverno,winter,sazonalidade','média'),
(62,'0003','Ernte und Verarbeitung',100,107,'Colheita e pós-colheita','colheita,processamento,limpeza,preparação,secagem','alta'),
(63,'0001','Einleitung',6,15,'Introdução','introdução,pilze,fungos,micologia','alta'),
(64,'0001','Hauptgruppen der Pilze',16,39,'Classificação','grupos principais,classificação,fungos,pilze','muito alta'),
(65,'0001','Eßbare Pilze',40,64,'Comestibilidade','cogumelos comestíveis,edible mushrooms,essbare pilze,identificação','muito alta'),
(66,'0001','Giftpilze',65,79,'Segurança','cogumelos venenosos,giftpilze,toxicidade,intoxicação','muito alta'),
(67,'0001','Pilze in Wirklichkeit und Legende',80,95,'História e cultura','história,cultura,lendas,mitologia,pilze','média'),
(68,'0001','Stichwortverzeichnis',96,NULL,'Índice remissivo','índice,stichwortverzeichnis,referência','baixa'),
(69,'0002','Grundlagen',12,23,'Fundamentos','fundamentos,fungos,pilze,cultivo,substrato,spawn','muito alta'),
(70,'0002','Kultur auf Stroh',24,53,'Cultivo','palha,stroh,substrato,cultivo,austernpilz','muito alta'),
(71,'0002','Kultur auf Kaffee',54,55,'Cultivo','café,kaffee,borras de café,substrato','alta'),
(72,'0002','Kultur auf Holz',56,111,'Cultivo','madeira,holz,troncos,shiitake,nameko','muito alta'),
(73,'0002','Kultur auf Kompost',112,133,'Cultivo','composto,kompost,champignon,agaricus','alta'),
(74,'0002','Fertigkulturen',134,151,'Cultivo doméstico','culturas prontas,fertigkulturen,kits de cultivo','alta'),
(75,'0002','Brut selbst herstellen',152,157,'Produção de spawn','spawn,pilzbrut,inóculo,laboratório,esterilidade','muito alta'),
(76,'0002','Ernte',158,158,'Colheita','colheita,ernte,ponto de colheita','alta'),
(77,'0002','Lagerung',159,159,'Pós-colheita','armazenamento,lagerung,conservação','alta'),
(78,'0002','Trocknung',159,160,'Conservação','secagem,trocknung,desidratação','alta'),
(79,'0002','Rezepte',161,176,'Receitas','receitas,rezepte,cozinha,cogumelos','baixa'),
(80,'0003','Leben und Wachsen',10,18,'Biologia','vida,crescimento,fungos,pilze,nutrição,reprodução,ecologia','muito alta'),
(81,'0003','Grundlagen der Pilzzucht',19,31,'Fundamentos de cultivo','cultivo,condições de crescimento,sazonalidade,micélio,spawn','muito alta'),
(82,'0003','Übersicht der Anbaumethoden',32,42,'Métodos de cultivo','métodos,cultivo interior,cultivo exterior,equipamentos,kits','muito alta'),
(83,'0003','Anbau im Freien',43,53,'Cultivo exterior','exterior,jardim,madeira,palha,canteiros','alta'),
(84,'0003','Probleme',54,59,'Problemas e sanidade','problemas,pragas,doenças,contaminação,cultivo','alta'),
(85,'0003','Frühlingspilze',60,67,'Espécies','espécies primavera,frühling,sazonalidade','média'),
(86,'0003','Sommerpilze',68,73,'Espécies','espécies verão,sommer,sazonalidade','média'),
(87,'0003','Herbstpilze',74,86,'Espécies','espécies outono,herbst,sazonalidade','média'),
(88,'0003','Winterpilze',87,99,'Espécies','espécies inverno,winter,sazonalidade','média'),
(89,'0003','Ernte und Verarbeitung',100,107,'Colheita e pós-colheita','colheita,processamento,limpeza,preparação,secagem','alta'),
(90,'0004','Introdução ao mundo dos fungos',NULL,NULL,'Micologia geral','fungos,cogumelos,micologia,biologia','muito alta'),
(91,'0004','Identificação de espécies',NULL,NULL,'Identificação','identificação,espécies,nome científico,nome comum','muito alta'),
(92,'0004','Cogumelos comestíveis',NULL,NULL,'Comestibilidade','comestíveis,alimentação,espécies','alta'),
(93,'0004','Cogumelos tóxicos',NULL,NULL,'Segurança','tóxicos,venenosos,intoxicação,segurança','muito alta'),
(94,'0004','Espécies do Norte de Portugal',NULL,NULL,'Espécies regionais','Portugal,Norte de Portugal,espécies,hábitat','alta'),
(95,'0004','Espécies da Galiza',NULL,NULL,'Espécies regionais','Galiza,espécies,hábitat,distribuição','alta'),
(96,'0004','Utilização culinária',NULL,NULL,'Culinária','cozinha,receitas,uso culinário,cogumelos','média'),
(97,'0001','Einleitung',6,15,'Introdução','introdução,pilze,fungos,micologia','alta'),
(98,'0001','Hauptgruppen der Pilze',16,39,'Classificação','grupos principais,classificação,fungos,pilze','muito alta'),
(99,'0001','Eßbare Pilze',40,64,'Comestibilidade','cogumelos comestíveis,edible mushrooms,essbare pilze,identificação','muito alta'),
(100,'0001','Giftpilze',65,79,'Segurança','cogumelos venenosos,giftpilze,toxicidade,intoxicação','muito alta'),
(101,'0001','Pilze in Wirklichkeit und Legende',80,95,'História e cultura','história,cultura,lendas,mitologia,pilze','média'),
(102,'0001','Stichwortverzeichnis',96,NULL,'Índice remissivo','índice,stichwortverzeichnis,referência','baixa'),
(103,'0002','Grundlagen',12,23,'Fundamentos','fundamentos,fungos,pilze,cultivo,substrato,spawn','muito alta'),
(104,'0002','Kultur auf Stroh',24,53,'Cultivo','palha,stroh,substrato,cultivo,austernpilz','muito alta'),
(105,'0002','Kultur auf Kaffee',54,55,'Cultivo','café,kaffee,borras de café,substrato','alta'),
(106,'0002','Kultur auf Holz',56,111,'Cultivo','madeira,holz,troncos,shiitake,nameko','muito alta'),
(107,'0002','Kultur auf Kompost',112,133,'Cultivo','composto,kompost,champignon,agaricus','alta'),
(108,'0002','Fertigkulturen',134,151,'Cultivo doméstico','culturas prontas,fertigkulturen,kits de cultivo','alta'),
(109,'0002','Brut selbst herstellen',152,157,'Produção de spawn','spawn,pilzbrut,inóculo,laboratório,esterilidade','muito alta'),
(110,'0002','Ernte',158,158,'Colheita','colheita,ernte,ponto de colheita','alta'),
(111,'0002','Lagerung',159,159,'Pós-colheita','armazenamento,lagerung,conservação','alta'),
(112,'0002','Trocknung',159,160,'Conservação','secagem,trocknung,desidratação','alta'),
(113,'0002','Rezepte',161,176,'Receitas','receitas,rezepte,cozinha,cogumelos','baixa'),
(114,'0003','Leben und Wachsen',10,18,'Biologia','vida,crescimento,fungos,pilze,nutrição,reprodução,ecologia','muito alta'),
(115,'0003','Grundlagen der Pilzzucht',19,31,'Fundamentos de cultivo','cultivo,condições de crescimento,sazonalidade,micélio,spawn','muito alta'),
(116,'0003','Übersicht der Anbaumethoden',32,42,'Métodos de cultivo','métodos,cultivo interior,cultivo exterior,equipamentos,kits','muito alta'),
(117,'0003','Anbau im Freien',43,53,'Cultivo exterior','exterior,jardim,madeira,palha,canteiros','alta'),
(118,'0003','Probleme',54,59,'Problemas e sanidade','problemas,pragas,doenças,contaminação,cultivo','alta'),
(119,'0003','Frühlingspilze',60,67,'Espécies','espécies primavera,frühling,sazonalidade','média'),
(120,'0003','Sommerpilze',68,73,'Espécies','espécies verão,sommer,sazonalidade','média'),
(121,'0003','Herbstpilze',74,86,'Espécies','espécies outono,herbst,sazonalidade','média'),
(122,'0003','Winterpilze',87,99,'Espécies','espécies inverno,winter,sazonalidade','média'),
(123,'0003','Ernte und Verarbeitung',100,107,'Colheita e pós-colheita','colheita,processamento,limpeza,preparação,secagem','alta'),
(124,'0004','Introdução ao mundo dos fungos',NULL,NULL,'Micologia geral','fungos,cogumelos,micologia,biologia','muito alta'),
(125,'0004','Identificação de espécies',NULL,NULL,'Identificação','identificação,espécies,nome científico,nome comum','muito alta'),
(126,'0004','Cogumelos comestíveis',NULL,NULL,'Comestibilidade','comestíveis,alimentação,espécies','alta'),
(127,'0004','Cogumelos tóxicos',NULL,NULL,'Segurança','tóxicos,venenosos,intoxicação,segurança','muito alta'),
(128,'0004','Espécies do Norte de Portugal',NULL,NULL,'Espécies regionais','Portugal,Norte de Portugal,espécies,hábitat','alta'),
(129,'0004','Espécies da Galiza',NULL,NULL,'Espécies regionais','Galiza,espécies,hábitat,distribuição','alta'),
(130,'0004','Utilização culinária',NULL,NULL,'Culinária','cozinha,receitas,uso culinário,cogumelos','média'),
(131,'0005','O que é um cogumelo?',10,11,'Biologia','fungos,cogumelo,micélio,carpóforo','muito alta'),
(132,'0005','Vida associada às árvores',12,13,'Ecologia','árvores,micorrizas,simbiose,floresta','alta'),
(133,'0005','Cogumelos parasitas',14,15,'Ecologia','parasitas,árvores,doenças','média'),
(134,'0005','Eliminadores de resíduos',16,17,'Ecologia','sapróbios,decomposição,matéria orgânica','alta'),
(135,'0005','Crescimento dos cogumelos',18,19,'Biologia','crescimento,micélio,frutificação','alta'),
(136,'0005','Onde crescem?',20,21,'Habitat','habitat,floresta,prado,campo','alta'),
(137,'0005','Quando crescem?',28,29,'Fenologia','época,sazonalidade,chuva,temperatura','alta'),
(138,'0005','Formação do carpóforo',32,33,'Biologia','carpóforo,corpo frutífero,frutificação','muito alta'),
(139,'0005','Identificação correta',34,37,'Identificação','identificação,píleo,lâminas,poros,pé,anel','muito alta'),
(140,'0005','Cogumelos tóxicos',38,44,'Segurança','tóxicos,venenosos,intoxicação,amanitina,muscarina','muito alta'),
(141,'0005','Conselhos práticos de identificação',48,49,'Identificação','conselhos práticos,identificação,apanha','alta'),
(142,'0005','Cogumelos com tubos e poros',50,69,'Identificação','tubos,poros,boletos,boletus','alta'),
(143,'0005','Cogumelos com lâminas e anel',70,91,'Identificação','lâminas,anel,amanita,agaricus','alta'),
(144,'0005','Cogumelos com lâminas sem anel',92,117,'Identificação','lâminas,sem anel,russula,lactarius','alta'),
(145,'0005','Outros cogumelos',118,124,'Identificação','outros cogumelos,formas especiais','média'),
(146,'0005','Medidas preventivas',140,143,'Segurança','prevenção,colheita segura,regras,proteção','muito alta'),
(147,'0005','Metais pesados e radioatividade',144,145,'Segurança alimentar','metais pesados,radioatividade,contaminação','alta'),
(148,'0005','Preparação e valor nutritivo',146,148,'Culinária e nutrição','preparação,valor nutritivo,cozinha','média'),
(149,'0005','Conservação, secagem e congelação',149,150,'Pós-colheita','conservação,secagem,congelação,armazenamento','alta'),
(150,'0005','Cultivo em palha e madeira',150,152,'Cultivo','cultivo,palha,madeira,troncos,substrato','alta'),
(151,'0001','Einleitung',6,15,'Introdução','introdução,pilze,fungos,micologia','alta'),
(152,'0001','Hauptgruppen der Pilze',16,39,'Classificação','grupos principais,classificação,fungos,pilze','muito alta'),
(153,'0001','Eßbare Pilze',40,64,'Comestibilidade','cogumelos comestíveis,edible mushrooms,essbare pilze,identificação','muito alta'),
(154,'0001','Giftpilze',65,79,'Segurança','cogumelos venenosos,giftpilze,toxicidade,intoxicação','muito alta'),
(155,'0001','Pilze in Wirklichkeit und Legende',80,95,'História e cultura','história,cultura,lendas,mitologia,pilze','média'),
(156,'0001','Stichwortverzeichnis',96,NULL,'Índice remissivo','índice,stichwortverzeichnis,referência','baixa'),
(157,'0002','Grundlagen',12,23,'Fundamentos','fundamentos,fungos,pilze,cultivo,substrato,spawn','muito alta'),
(158,'0002','Kultur auf Stroh',24,53,'Cultivo','palha,stroh,substrato,cultivo,austernpilz','muito alta'),
(159,'0002','Kultur auf Kaffee',54,55,'Cultivo','café,kaffee,borras de café,substrato','alta'),
(160,'0002','Kultur auf Holz',56,111,'Cultivo','madeira,holz,troncos,shiitake,nameko','muito alta'),
(161,'0002','Kultur auf Kompost',112,133,'Cultivo','composto,kompost,champignon,agaricus','alta'),
(162,'0002','Fertigkulturen',134,151,'Cultivo doméstico','culturas prontas,fertigkulturen,kits de cultivo','alta'),
(163,'0002','Brut selbst herstellen',152,157,'Produção de spawn','spawn,pilzbrut,inóculo,laboratório,esterilidade','muito alta'),
(164,'0002','Ernte',158,158,'Colheita','colheita,ernte,ponto de colheita','alta'),
(165,'0002','Lagerung',159,159,'Pós-colheita','armazenamento,lagerung,conservação','alta'),
(166,'0002','Trocknung',159,160,'Conservação','secagem,trocknung,desidratação','alta'),
(167,'0002','Rezepte',161,176,'Receitas','receitas,rezepte,cozinha,cogumelos','baixa'),
(168,'0003','Leben und Wachsen',10,18,'Biologia','vida,crescimento,fungos,pilze,nutrição,reprodução,ecologia','muito alta'),
(169,'0003','Grundlagen der Pilzzucht',19,31,'Fundamentos de cultivo','cultivo,condições de crescimento,sazonalidade,micélio,spawn','muito alta'),
(170,'0003','Übersicht der Anbaumethoden',32,42,'Métodos de cultivo','métodos,cultivo interior,cultivo exterior,equipamentos,kits','muito alta'),
(171,'0003','Anbau im Freien',43,53,'Cultivo exterior','exterior,jardim,madeira,palha,canteiros','alta'),
(172,'0003','Probleme',54,59,'Problemas e sanidade','problemas,pragas,doenças,contaminação,cultivo','alta'),
(173,'0003','Frühlingspilze',60,67,'Espécies','espécies primavera,frühling,sazonalidade','média'),
(174,'0003','Sommerpilze',68,73,'Espécies','espécies verão,sommer,sazonalidade','média'),
(175,'0003','Herbstpilze',74,86,'Espécies','espécies outono,herbst,sazonalidade','média'),
(176,'0003','Winterpilze',87,99,'Espécies','espécies inverno,winter,sazonalidade','média'),
(177,'0003','Ernte und Verarbeitung',100,107,'Colheita e pós-colheita','colheita,processamento,limpeza,preparação,secagem','alta'),
(178,'0004','Introdução ao mundo dos fungos',NULL,NULL,'Micologia geral','fungos,cogumelos,micologia,biologia','muito alta'),
(179,'0004','Identificação de espécies',NULL,NULL,'Identificação','identificação,espécies,nome científico,nome comum','muito alta'),
(180,'0004','Cogumelos comestíveis',NULL,NULL,'Comestibilidade','comestíveis,alimentação,espécies','alta'),
(181,'0004','Cogumelos tóxicos',NULL,NULL,'Segurança','tóxicos,venenosos,intoxicação,segurança','muito alta'),
(182,'0004','Espécies do Norte de Portugal',NULL,NULL,'Espécies regionais','Portugal,Norte de Portugal,espécies,hábitat','alta'),
(183,'0004','Espécies da Galiza',NULL,NULL,'Espécies regionais','Galiza,espécies,hábitat,distribuição','alta'),
(184,'0004','Utilização culinária',NULL,NULL,'Culinária','cozinha,receitas,uso culinário,cogumelos','média'),
(185,'0005','O que é um cogumelo?',10,11,'Biologia','fungos,cogumelo,micélio,carpóforo','muito alta'),
(186,'0005','Vida associada às árvores',12,13,'Ecologia','árvores,micorrizas,simbiose,floresta','alta'),
(187,'0005','Cogumelos parasitas',14,15,'Ecologia','parasitas,árvores,doenças','média'),
(188,'0005','Eliminadores de resíduos',16,17,'Ecologia','sapróbios,decomposição,matéria orgânica','alta'),
(189,'0005','Crescimento dos cogumelos',18,19,'Biologia','crescimento,micélio,frutificação','alta'),
(190,'0005','Onde crescem?',20,21,'Habitat','habitat,floresta,prado,campo','alta'),
(191,'0005','Quando crescem?',28,29,'Fenologia','época,sazonalidade,chuva,temperatura','alta'),
(192,'0005','Formação do carpóforo',32,33,'Biologia','carpóforo,corpo frutífero,frutificação','muito alta'),
(193,'0005','Identificação correta',34,37,'Identificação','identificação,píleo,lâminas,poros,pé,anel','muito alta'),
(194,'0005','Cogumelos tóxicos',38,44,'Segurança','tóxicos,venenosos,intoxicação,amanitina,muscarina','muito alta'),
(195,'0005','Conselhos práticos de identificação',48,49,'Identificação','conselhos práticos,identificação,apanha','alta'),
(196,'0005','Cogumelos com tubos e poros',50,69,'Identificação','tubos,poros,boletos,boletus','alta'),
(197,'0005','Cogumelos com lâminas e anel',70,91,'Identificação','lâminas,anel,amanita,agaricus','alta'),
(198,'0005','Cogumelos com lâminas sem anel',92,117,'Identificação','lâminas,sem anel,russula,lactarius','alta'),
(199,'0005','Outros cogumelos',118,124,'Identificação','outros cogumelos,formas especiais','média'),
(200,'0005','Medidas preventivas',140,143,'Segurança','prevenção,colheita segura,regras,proteção','muito alta'),
(201,'0005','Metais pesados e radioatividade',144,145,'Segurança alimentar','metais pesados,radioatividade,contaminação','alta'),
(202,'0005','Preparação e valor nutritivo',146,148,'Culinária e nutrição','preparação,valor nutritivo,cozinha','média'),
(203,'0005','Conservação, secagem e congelação',149,150,'Pós-colheita','conservação,secagem,congelação,armazenamento','alta'),
(204,'0005','Cultivo em palha e madeira',150,152,'Cultivo','cultivo,palha,madeira,troncos,substrato','alta'),
(205,'0006','Introdução',11,12,'Introdução','introdução,produção,cogumelos','média'),
(206,'0006','Os cogumelos ao longo dos tempos',13,16,'História','história,cultura,cogumelos','média'),
(207,'0006','O que são os cogumelos',17,20,'Biologia','fungos,micélio,hifas,esporos,basídios','muito alta'),
(208,'0006','Produção de sementes de cogumelos',21,24,'Cultivo','spawn,semente,inóculo,micélio,meio de cultura','muito alta'),
(209,'0006','Produção de Agaricus sp.',25,54,'Produção','agaricus,substrato,compostagem,cobertura,rega,colheita,conservação','alta'),
(210,'0006','Substrato e compostagem',25,32,'Substrato','substrato,composto,compostagem,fermentação,pasteurização','muito alta'),
(211,'0006','Condições ambientais de cultivo',33,36,'Ambiente','temperatura,humidade,co2,ventilação,incubação,frutificação','muito alta'),
(212,'0006','Camada de cobertura',37,40,'Cultivo','cobertura,casing,frutificação,retenção de água,microclima','alta'),
(213,'0006','Regas',41,42,'Maneio','rega,água,humidade,evaporação','alta'),
(214,'0006','Sanidade e tratamentos',43,45,'Sanidade','sanidade,doenças,pragas,tratamentos,prevenção','média'),
(215,'0006','Produções',46,46,'Produção','produção,rendimento,flush,colheitas','média'),
(216,'0006','Maneio após a colheita',47,49,'Pós-colheita','colheita,pós-colheita,qualidade,manuseamento','alta'),
(217,'0006','Técnicas de conservação',50,53,'Conservação','conservação,refrigeração,secagem,armazenamento,atmosfera modificada','alta'),
(218,'0006','Pragas e doenças',55,69,'Sanidade','pragas,doenças,contaminação,agaricus','alta'),
(219,'0006','Composição química e valor nutritivo',70,74,'Nutrição','composição química,valor nutritivo,nutrição','média'),
(220,'0006','Produção de Pleurotus sp.',75,89,'Produção','pleurotus,substrato,cultivo,condições ambientais,pragas,valor nutritivo','muito alta'),
(221,'0006','Bibliografia utilizada',91,91,'Referência','bibliografia,fontes,referências','baixa'),
(222,'0001','Einleitung',6,15,'Introdução','introdução,pilze,fungos,micologia','alta'),
(223,'0001','Hauptgruppen der Pilze',16,39,'Classificação','grupos principais,classificação,fungos,pilze','muito alta'),
(224,'0001','Eßbare Pilze',40,64,'Comestibilidade','cogumelos comestíveis,edible mushrooms,essbare pilze,identificação','muito alta'),
(225,'0001','Giftpilze',65,79,'Segurança','cogumelos venenosos,giftpilze,toxicidade,intoxicação','muito alta'),
(226,'0001','Pilze in Wirklichkeit und Legende',80,95,'História e cultura','história,cultura,lendas,mitologia,pilze','média'),
(227,'0001','Stichwortverzeichnis',96,NULL,'Índice remissivo','índice,stichwortverzeichnis,referência','baixa'),
(228,'0002','Grundlagen',12,23,'Fundamentos','fundamentos,fungos,pilze,cultivo,substrato,spawn','muito alta'),
(229,'0002','Kultur auf Stroh',24,53,'Cultivo','palha,stroh,substrato,cultivo,austernpilz','muito alta'),
(230,'0002','Kultur auf Kaffee',54,55,'Cultivo','café,kaffee,borras de café,substrato','alta'),
(231,'0002','Kultur auf Holz',56,111,'Cultivo','madeira,holz,troncos,shiitake,nameko','muito alta'),
(232,'0002','Kultur auf Kompost',112,133,'Cultivo','composto,kompost,champignon,agaricus','alta'),
(233,'0002','Fertigkulturen',134,151,'Cultivo doméstico','culturas prontas,fertigkulturen,kits de cultivo','alta'),
(234,'0002','Brut selbst herstellen',152,157,'Produção de spawn','spawn,pilzbrut,inóculo,laboratório,esterilidade','muito alta'),
(235,'0002','Ernte',158,158,'Colheita','colheita,ernte,ponto de colheita','alta'),
(236,'0002','Lagerung',159,159,'Pós-colheita','armazenamento,lagerung,conservação','alta'),
(237,'0002','Trocknung',159,160,'Conservação','secagem,trocknung,desidratação','alta'),
(238,'0002','Rezepte',161,176,'Receitas','receitas,rezepte,cozinha,cogumelos','baixa'),
(239,'0003','Leben und Wachsen',10,18,'Biologia','vida,crescimento,fungos,pilze,nutrição,reprodução,ecologia','muito alta'),
(240,'0003','Grundlagen der Pilzzucht',19,31,'Fundamentos de cultivo','cultivo,condições de crescimento,sazonalidade,micélio,spawn','muito alta'),
(241,'0003','Übersicht der Anbaumethoden',32,42,'Métodos de cultivo','métodos,cultivo interior,cultivo exterior,equipamentos,kits','muito alta'),
(242,'0003','Anbau im Freien',43,53,'Cultivo exterior','exterior,jardim,madeira,palha,canteiros','alta'),
(243,'0003','Probleme',54,59,'Problemas e sanidade','problemas,pragas,doenças,contaminação,cultivo','alta'),
(244,'0003','Frühlingspilze',60,67,'Espécies','espécies primavera,frühling,sazonalidade','média'),
(245,'0003','Sommerpilze',68,73,'Espécies','espécies verão,sommer,sazonalidade','média'),
(246,'0003','Herbstpilze',74,86,'Espécies','espécies outono,herbst,sazonalidade','média'),
(247,'0003','Winterpilze',87,99,'Espécies','espécies inverno,winter,sazonalidade','média'),
(248,'0003','Ernte und Verarbeitung',100,107,'Colheita e pós-colheita','colheita,processamento,limpeza,preparação,secagem','alta'),
(249,'0004','Introdução ao mundo dos fungos',NULL,NULL,'Micologia geral','fungos,cogumelos,micologia,biologia','muito alta'),
(250,'0004','Identificação de espécies',NULL,NULL,'Identificação','identificação,espécies,nome científico,nome comum','muito alta'),
(251,'0004','Cogumelos comestíveis',NULL,NULL,'Comestibilidade','comestíveis,alimentação,espécies','alta'),
(252,'0004','Cogumelos tóxicos',NULL,NULL,'Segurança','tóxicos,venenosos,intoxicação,segurança','muito alta'),
(253,'0004','Espécies do Norte de Portugal',NULL,NULL,'Espécies regionais','Portugal,Norte de Portugal,espécies,hábitat','alta'),
(254,'0004','Espécies da Galiza',NULL,NULL,'Espécies regionais','Galiza,espécies,hábitat,distribuição','alta'),
(255,'0004','Utilização culinária',NULL,NULL,'Culinária','cozinha,receitas,uso culinário,cogumelos','média'),
(256,'0005','O que é um cogumelo?',10,11,'Biologia','fungos,cogumelo,micélio,carpóforo','muito alta'),
(257,'0005','Vida associada às árvores',12,13,'Ecologia','árvores,micorrizas,simbiose,floresta','alta'),
(258,'0005','Cogumelos parasitas',14,15,'Ecologia','parasitas,árvores,doenças','média'),
(259,'0005','Eliminadores de resíduos',16,17,'Ecologia','sapróbios,decomposição,matéria orgânica','alta'),
(260,'0005','Crescimento dos cogumelos',18,19,'Biologia','crescimento,micélio,frutificação','alta'),
(261,'0005','Onde crescem?',20,21,'Habitat','habitat,floresta,prado,campo','alta'),
(262,'0005','Quando crescem?',28,29,'Fenologia','época,sazonalidade,chuva,temperatura','alta'),
(263,'0005','Formação do carpóforo',32,33,'Biologia','carpóforo,corpo frutífero,frutificação','muito alta'),
(264,'0005','Identificação correta',34,37,'Identificação','identificação,píleo,lâminas,poros,pé,anel','muito alta'),
(265,'0005','Cogumelos tóxicos',38,44,'Segurança','tóxicos,venenosos,intoxicação,amanitina,muscarina','muito alta'),
(266,'0005','Conselhos práticos de identificação',48,49,'Identificação','conselhos práticos,identificação,apanha','alta'),
(267,'0005','Cogumelos com tubos e poros',50,69,'Identificação','tubos,poros,boletos,boletus','alta'),
(268,'0005','Cogumelos com lâminas e anel',70,91,'Identificação','lâminas,anel,amanita,agaricus','alta'),
(269,'0005','Cogumelos com lâminas sem anel',92,117,'Identificação','lâminas,sem anel,russula,lactarius','alta'),
(270,'0005','Outros cogumelos',118,124,'Identificação','outros cogumelos,formas especiais','média'),
(271,'0005','Medidas preventivas',140,143,'Segurança','prevenção,colheita segura,regras,proteção','muito alta'),
(272,'0005','Metais pesados e radioatividade',144,145,'Segurança alimentar','metais pesados,radioatividade,contaminação','alta'),
(273,'0005','Preparação e valor nutritivo',146,148,'Culinária e nutrição','preparação,valor nutritivo,cozinha','média'),
(274,'0005','Conservação, secagem e congelação',149,150,'Pós-colheita','conservação,secagem,congelação,armazenamento','alta'),
(275,'0005','Cultivo em palha e madeira',150,152,'Cultivo','cultivo,palha,madeira,troncos,substrato','alta'),
(276,'0006','Introdução',11,12,'Introdução','introdução,produção,cogumelos','média'),
(277,'0006','Os cogumelos ao longo dos tempos',13,16,'História','história,cultura,cogumelos','média'),
(278,'0006','O que são os cogumelos',17,20,'Biologia','fungos,micélio,hifas,esporos,basídios','muito alta'),
(279,'0006','Produção de sementes de cogumelos',21,24,'Cultivo','spawn,semente,inóculo,micélio,meio de cultura','muito alta'),
(280,'0006','Produção de Agaricus sp.',25,54,'Produção','agaricus,substrato,compostagem,cobertura,rega,colheita,conservação','alta'),
(281,'0006','Substrato e compostagem',25,32,'Substrato','substrato,composto,compostagem,fermentação,pasteurização','muito alta'),
(282,'0006','Condições ambientais de cultivo',33,36,'Ambiente','temperatura,humidade,co2,ventilação,incubação,frutificação','muito alta'),
(283,'0006','Camada de cobertura',37,40,'Cultivo','cobertura,casing,frutificação,retenção de água,microclima','alta'),
(284,'0006','Regas',41,42,'Maneio','rega,água,humidade,evaporação','alta'),
(285,'0006','Sanidade e tratamentos',43,45,'Sanidade','sanidade,doenças,pragas,tratamentos,prevenção','média'),
(286,'0006','Produções',46,46,'Produção','produção,rendimento,flush,colheitas','média'),
(287,'0006','Maneio após a colheita',47,49,'Pós-colheita','colheita,pós-colheita,qualidade,manuseamento','alta'),
(288,'0006','Técnicas de conservação',50,53,'Conservação','conservação,refrigeração,secagem,armazenamento,atmosfera modificada','alta'),
(289,'0006','Pragas e doenças',55,69,'Sanidade','pragas,doenças,contaminação,agaricus','alta'),
(290,'0006','Composição química e valor nutritivo',70,74,'Nutrição','composição química,valor nutritivo,nutrição','média'),
(291,'0006','Produção de Pleurotus sp.',75,89,'Produção','pleurotus,substrato,cultivo,condições ambientais,pragas,valor nutritivo','muito alta'),
(292,'0006','Bibliografia utilizada',91,91,'Referência','bibliografia,fontes,referências','baixa'),
(293,'0007','Identificação segura de cogumelos',NULL,NULL,'Identificação','identificação,pilzführer,segurança,cogumelos','muito alta'),
(294,'0007','Cogumelos comestíveis',NULL,NULL,'Comestibilidade','comestíveis,essbare pilze,consumo','alta'),
(295,'0007','Cogumelos venenosos',NULL,NULL,'Segurança','venenosos,giftpilze,tóxicos,intoxicação','muito alta'),
(296,'0007','Características morfológicas',NULL,NULL,'Morfologia','chapéu,lâminas,poros,pé,anel,volva','muito alta'),
(297,'0007','Habitat e época de frutificação',NULL,NULL,'Ecologia','habitat,época,floresta,prado,sazonalidade','alta'),
(298,'0007','Conselhos de consumo seguro',NULL,NULL,'Segurança alimentar','consumo seguro,prevenção,risco,apanha','muito alta');
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

-- Dump completed on 2026-06-22  4:57:06
