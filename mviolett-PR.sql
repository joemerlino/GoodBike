-- phpMyAdmin SQL Dump
-- version 3.3.2deb1ubuntu1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: 25 ago, 2015 at 09:49 PM
-- Versione MySQL: 5.1.73
-- Versione PHP: 5.3.2-1ubuntu4.30

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mviolett-PR`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `Bicicletta`
--

CREATE TABLE IF NOT EXISTS `Bicicletta` (
  `CodiceMateriale` int(10) unsigned NOT NULL DEFAULT '0',
  `Elettrica` tinyint(1) NOT NULL DEFAULT '0',
  `Stato` enum('InServizio','InMagazzino') COLLATE latin1_general_ci NOT NULL DEFAULT 'InMagazzino',
  PRIMARY KEY (`CodiceMateriale`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dump dei dati per la tabella `Bicicletta`
--

INSERT INTO `Bicicletta` (`CodiceMateriale`, `Elettrica`, `Stato`) VALUES
(1, 0, 'InMagazzino'),
(2, 0, 'InMagazzino'),
(3, 0, 'InServizio'),
(4, 0, 'InServizio'),
(5, 0, 'InMagazzino'),
(6, 0, 'InServizio'),
(7, 0, 'InServizio'),
(8, 0, 'InServizio'),
(9, 0, 'InServizio'),
(10, 0, 'InServizio'),
(11, 0, 'InServizio'),
(12, 1, 'InServizio'),
(13, 0, 'InServizio'),
(14, 0, 'InMagazzino'),
(15, 1, 'InMagazzino'),
(16, 0, 'InMagazzino'),
(17, 0, 'InServizio'),
(18, 0, 'InServizio'),
(19, 0, 'InMagazzino'),
(20, 0, 'InServizio'),
(21, 0, 'InServizio'),
(22, 0, 'InServizio'),
(23, 0, 'InServizio'),
(24, 0, 'InServizio'),
(25, 1, 'InServizio'),
(26, 0, 'InServizio'),
(27, 0, 'InServizio'),
(28, 0, 'InServizio'),
(29, 0, 'InServizio'),
(30, 1, 'InServizio'),
(31, 1, 'InServizio'),
(32, 1, 'InServizio'),
(33, 1, 'InServizio'),
(34, 1, 'InMagazzino'),
(35, 1, 'InServizio'),
(36, 1, 'InServizio'),
(37, 1, 'InMagazzino'),
(38, 1, 'InMagazzino'),
(39, 1, 'InServizio'),
(40, 1, 'InServizio');

-- --------------------------------------------------------

--
-- Struttura della tabella `Colonnina`
--

CREATE TABLE IF NOT EXISTS `Colonnina` (
  `CodiceMateriale` int(10) unsigned NOT NULL DEFAULT '0',
  `Bicicletta` int(10) unsigned DEFAULT NULL,
  `NomeStazione` varchar(20) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`CodiceMateriale`),
  UNIQUE KEY `Bicicletta` (`Bicicletta`),
  KEY `NomeStazione` (`NomeStazione`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dump dei dati per la tabella `Colonnina`
--

INSERT INTO `Colonnina` (`CodiceMateriale`, `Bicicletta`, `NomeStazione`) VALUES
(41, NULL, 'Paolotti'),
(42, 3, 'Paolotti'),
(43, 4, 'Paolotti'),
(44, 18, 'Paolotti'),
(45, 27, 'Paolotti'),
(46, 25, 'Paolotti'),
(47, 8, 'Paolotti'),
(48, 12, 'Paolotti'),
(49, 24, 'Paolotti'),
(50, 21, 'Paolotti'),
(51, 29, 'Paolotti'),
(52, 23, 'Paolotti'),
(53, 20, 'Paolotti'),
(54, NULL, 'Paolotti'),
(55, 35, 'Paolotti'),
(56, 26, 'Paolotti'),
(57, 7, 'Paolotti'),
(58, 32, 'Paolotti'),
(59, 10, 'Paolotti'),
(60, 36, 'Paolotti'),
(61, NULL, 'Prato'),
(62, NULL, 'Prato'),
(63, NULL, 'Prato'),
(64, NULL, 'Prato'),
(65, NULL, 'Prato'),
(66, NULL, 'Prato'),
(67, NULL, 'Prato'),
(68, NULL, 'Prato'),
(69, NULL, 'Prato'),
(70, NULL, 'Prato'),
(71, NULL, 'Prato'),
(72, NULL, 'Prato'),
(73, NULL, 'Prato'),
(74, NULL, 'Prato'),
(75, NULL, 'Prato'),
(76, NULL, 'Prato'),
(77, NULL, 'Prato'),
(78, NULL, 'Prato'),
(79, NULL, 'Prato'),
(80, NULL, 'Prato'),
(81, NULL, 'Stazione'),
(82, NULL, 'Stazione'),
(83, NULL, 'Stazione'),
(84, NULL, 'Stazione'),
(85, 17, 'Stazione'),
(86, 30, 'Stazione'),
(87, 6, 'Stazione'),
(88, NULL, 'Stazione'),
(89, NULL, 'Stazione'),
(90, NULL, 'Stazione'),
(91, 11, 'Stazione'),
(92, NULL, 'Stazione'),
(93, NULL, 'Stazione'),
(94, NULL, 'Stazione'),
(95, NULL, 'Stazione'),
(96, NULL, 'Stazione'),
(97, 33, 'Stazione'),
(98, 9, 'Stazione'),
(99, NULL, 'Stazione'),
(100, NULL, 'Stazione'),
(101, 28, 'Santo'),
(102, 13, 'Santo'),
(103, 31, 'Santo'),
(104, 39, 'Santo'),
(105, 40, 'Santo'),
(106, 22, 'Santo'),
(107, NULL, 'Santo'),
(108, NULL, 'Santo'),
(109, NULL, 'Santo'),
(110, NULL, 'Santo'),
(111, NULL, 'Santo'),
(112, NULL, 'Santo');

-- --------------------------------------------------------

--
-- Struttura della tabella `Manutenzione`
--

CREATE TABLE IF NOT EXISTS `Manutenzione` (
  `NumeroManutenzione` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DataManutenzione` date NOT NULL,
  `DescrizioneDanno` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `CodiceMateriale` int(10) unsigned NOT NULL,
  PRIMARY KEY (`NumeroManutenzione`),
  KEY `CodiceMateriale` (`CodiceMateriale`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=2 ;

--
-- Dump dei dati per la tabella `Manutenzione`
--

INSERT INTO `Manutenzione` (`NumeroManutenzione`, `DataManutenzione`, `DescrizioneDanno`, `CodiceMateriale`) VALUES
(1, '2015-08-25', 'riparato il lucchetto elettronico', 60);

-- --------------------------------------------------------

--
-- Struttura della tabella `Materiale`
--

CREATE TABLE IF NOT EXISTS `Materiale` (
  `CodiceMateriale` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Danneggiato` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CodiceMateriale`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=113 ;

--
-- Dump dei dati per la tabella `Materiale`
--

INSERT INTO `Materiale` (`CodiceMateriale`, `Danneggiato`) VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 1),
(11, 0),
(12, 1),
(13, 0),
(14, 0),
(15, 0),
(16, 0),
(17, 0),
(18, 0),
(19, 0),
(20, 0),
(21, 0),
(22, 0),
(23, 0),
(24, 0),
(25, 0),
(26, 0),
(27, 0),
(28, 0),
(29, 0),
(30, 0),
(31, 0),
(32, 0),
(33, 0),
(34, 0),
(35, 0),
(36, 0),
(37, 0),
(38, 0),
(39, 0),
(40, 0),
(41, 0),
(42, 0),
(43, 0),
(44, 0),
(45, 0),
(46, 0),
(47, 0),
(48, 1),
(49, 0),
(50, 0),
(51, 0),
(52, 0),
(53, 0),
(54, 0),
(55, 0),
(56, 0),
(57, 0),
(58, 0),
(59, 1),
(60, 0),
(61, 0),
(62, 0),
(63, 0),
(64, 0),
(65, 0),
(66, 0),
(67, 0),
(68, 0),
(69, 0),
(70, 0),
(71, 0),
(72, 0),
(73, 0),
(74, 0),
(75, 0),
(76, 0),
(77, 0),
(78, 0),
(79, 0),
(80, 0),
(81, 1),
(82, 0),
(83, 0),
(84, 0),
(85, 0),
(86, 0),
(87, 0),
(88, 0),
(89, 0),
(90, 0),
(91, 0),
(92, 0),
(93, 0),
(94, 0),
(95, 0),
(96, 0),
(97, 0),
(98, 0),
(99, 0),
(100, 0),
(101, 0),
(102, 0),
(103, 0),
(104, 0),
(105, 0),
(106, 0),
(107, 0),
(108, 0),
(109, 0),
(110, 0),
(111, 0),
(112, 0);

-- --------------------------------------------------------

--
-- Struttura della tabella `Operazione`
--

CREATE TABLE IF NOT EXISTS `Operazione` (
  `IdOperazione` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Orario` datetime NOT NULL,
  `Colonnina` int(10) unsigned NOT NULL,
  `Bicicletta` int(10) unsigned NOT NULL,
  `Motivazione` enum('Prelievo','Deposito','Aggiunta','Rimozione') COLLATE latin1_general_ci NOT NULL,
  `IdTessera` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`IdOperazione`),
  KEY `Colonnina` (`Colonnina`),
  KEY `Bicicletta` (`Bicicletta`),
  KEY `IdTessera` (`IdTessera`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=41 ;

--
-- Dump dei dati per la tabella `Operazione`
--

INSERT INTO `Operazione` (`IdOperazione`, `Orario`, `Colonnina`, `Bicicletta`, `Motivazione`, `IdTessera`) VALUES
(1, '2015-08-25 18:58:52', 41, 1, 'Aggiunta', NULL),
(2, '2015-08-25 18:58:52', 42, 3, 'Aggiunta', NULL),
(3, '2015-08-25 18:58:52', 43, 4, 'Aggiunta', NULL),
(4, '2015-08-25 18:58:52', 44, 18, 'Aggiunta', NULL),
(5, '2015-08-25 18:58:52', 45, 27, 'Aggiunta', NULL),
(6, '2015-08-25 18:58:52', 46, 25, 'Aggiunta', NULL),
(7, '2015-08-25 18:58:52', 47, 8, 'Aggiunta', NULL),
(8, '2015-08-25 18:58:52', 48, 12, 'Aggiunta', NULL),
(9, '2015-08-25 18:58:52', 49, 24, 'Aggiunta', NULL),
(10, '2015-08-25 18:58:52', 50, 21, 'Aggiunta', NULL),
(11, '2015-08-25 18:58:52', 51, 29, 'Aggiunta', NULL),
(12, '2015-08-25 18:58:52', 52, 23, 'Aggiunta', NULL),
(13, '2015-08-25 18:58:52', 53, 20, 'Aggiunta', NULL),
(14, '2015-08-25 18:58:52', 54, 15, 'Aggiunta', NULL),
(15, '2015-08-25 18:58:52', 55, 35, 'Aggiunta', NULL),
(16, '2015-08-25 18:58:52', 56, 26, 'Aggiunta', NULL),
(17, '2015-08-25 18:58:52', 57, 7, 'Aggiunta', NULL),
(18, '2015-08-25 18:58:52', 58, 32, 'Aggiunta', NULL),
(19, '2015-08-25 18:58:52', 59, 10, 'Aggiunta', NULL),
(20, '2015-08-25 18:58:52', 60, 36, 'Aggiunta', NULL),
(21, '2015-08-25 18:58:52', 81, 16, 'Aggiunta', NULL),
(22, '2015-08-25 18:58:52', 85, 17, 'Aggiunta', NULL),
(23, '2015-08-25 18:58:52', 86, 30, 'Aggiunta', NULL),
(24, '2015-08-25 18:58:52', 87, 6, 'Aggiunta', NULL),
(25, '2015-08-25 18:58:52', 91, 11, 'Aggiunta', NULL),
(26, '2015-08-25 18:58:52', 97, 33, 'Aggiunta', NULL),
(27, '2015-08-25 18:58:52', 98, 9, 'Aggiunta', NULL),
(28, '2015-08-25 18:58:52', 99, 22, 'Aggiunta', NULL),
(29, '2015-08-25 18:58:52', 101, 28, 'Aggiunta', NULL),
(30, '2015-08-25 18:58:52', 106, 13, 'Aggiunta', NULL),
(31, '2015-08-25 18:58:52', 54, 15, 'Rimozione', NULL),
(32, '2015-08-25 18:58:52', 81, 16, 'Rimozione', NULL),
(33, '2015-08-25 20:02:48', 41, 1, 'Rimozione', NULL),
(34, '2015-08-25 20:03:41', 106, 13, 'Rimozione', NULL),
(35, '2015-08-25 20:03:54', 102, 13, 'Aggiunta', NULL),
(36, '2015-08-25 20:03:54', 103, 31, 'Aggiunta', NULL),
(37, '2015-08-25 20:03:54', 104, 39, 'Aggiunta', NULL),
(38, '2015-08-25 20:03:54', 105, 40, 'Aggiunta', NULL),
(39, '2015-08-25 20:04:33', 99, 22, 'Rimozione', NULL),
(40, '2015-08-25 20:04:33', 106, 22, 'Aggiunta', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `SegnalazioneMancanza`
--

CREATE TABLE IF NOT EXISTS `SegnalazioneMancanza` (
  `NomeStazione` varchar(20) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `IdTessera` int(10) unsigned NOT NULL DEFAULT '0',
  `DataSegnalazione` date NOT NULL,
  PRIMARY KEY (`IdTessera`,`NomeStazione`),
  KEY `NomeStazione` (`NomeStazione`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dump dei dati per la tabella `SegnalazioneMancanza`
--

INSERT INTO `SegnalazioneMancanza` (`NomeStazione`, `IdTessera`, `DataSegnalazione`) VALUES
('Prato', 1, '2015-08-25');

-- --------------------------------------------------------

--
-- Struttura della tabella `SegnalazioneRottura`
--

CREATE TABLE IF NOT EXISTS `SegnalazioneRottura` (
  `Colonnina` int(10) unsigned NOT NULL DEFAULT '0',
  `IdTessera` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`IdTessera`,`Colonnina`),
  KEY `Colonnina` (`Colonnina`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dump dei dati per la tabella `SegnalazioneRottura`
--

INSERT INTO `SegnalazioneRottura` (`Colonnina`, `IdTessera`) VALUES
(48, 1),
(59, 1),
(81, 1),
(81, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `Stazione`
--

CREATE TABLE IF NOT EXISTS `Stazione` (
  `NomeStazione` varchar(20) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Via` varchar(30) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`NomeStazione`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dump dei dati per la tabella `Stazione`
--

INSERT INTO `Stazione` (`NomeStazione`, `Via`) VALUES
('Paolotti', 'Via Paolotti'),
('Prato', 'Via del Santo'),
('Santo', 'Via dei Santi'),
('Stazione', 'Pizzale Stazione');

-- --------------------------------------------------------

--
-- Struttura della tabella `Tessera`
--

CREATE TABLE IF NOT EXISTS `Tessera` (
  `IdTessera` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DataAttivazione` date NOT NULL,
  PRIMARY KEY (`IdTessera`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci AUTO_INCREMENT=7 ;

--
-- Dump dei dati per la tabella `Tessera`
--

INSERT INTO `Tessera` (`IdTessera`, `DataAttivazione`) VALUES
(1, '2015-08-25'),
(2, '2015-08-25'),
(3, '2015-08-25'),
(4, '2015-08-25'),
(5, '2015-08-25'),
(6, '2015-08-25');

-- --------------------------------------------------------

--
-- Struttura della tabella `Utente`
--

CREATE TABLE IF NOT EXISTS `Utente` (
  `Nome` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `Cognome` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `DataNascita` date NOT NULL,
  `LuogoNascita` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `Residenza` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `Indirizzo` varchar(30) COLLATE latin1_general_ci NOT NULL,
  `Email` varchar(30) COLLATE latin1_general_ci NOT NULL,
  `Tipo` enum('Utente','Turista','Studente') COLLATE latin1_general_ci NOT NULL DEFAULT 'Utente',
  `CodiceStudente` char(10) COLLATE latin1_general_ci DEFAULT NULL,
  `IoStudio` tinyint(1) DEFAULT NULL,
  `IdTessera` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`IdTessera`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dump dei dati per la tabella `Utente`
--

INSERT INTO `Utente` (`Nome`, `Cognome`, `DataNascita`, `LuogoNascita`, `Residenza`, `Indirizzo`, `Email`, `Tipo`, `CodiceStudente`, `IoStudio`, `IdTessera`) VALUES
('Giovanni', 'Rossi', '1990-08-23', 'Padova', 'Vigonza', 'Via Pascoli,8', 'giovannirossi@email.it', 'Utente', NULL, NULL, 1),
('Paolo', 'Gironi', '1980-10-10', 'Venezia', 'Padova', 'Via Montegrappa,10', 'paolo@email.it', 'Turista', NULL, NULL, 2),
('Davide', 'Ceron', '1992-10-12', 'Montebelluna', 'Montebelluna', 'Via salice,7', 'cerondavid@gmail.com', 'Studente', '287654', 0, 3),
('Gianni', 'Pascoli', '2000-09-12', 'Padova', 'Padova', 'Via monte grappa,8', 'gianni.pascoli@gmail.com', 'Studente', '1234', 1, 4),
('giovanni', 'vernia', '1960-11-12', 'Rimini', 'Riccione', 'Via sofia,3', 'giovannivernia@yahoo.it', 'Turista', NULL, NULL, 5),
('Miki', 'Violetto', '1992-02-18', 'Cittadella', 'Cittadella', 'Via Jacopo da Ponte 30', 'miki.violetto@studenti.unipd.i', 'Studente', '1029140', 0, 6);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `Bicicletta`
--
ALTER TABLE `Bicicletta`
  ADD CONSTRAINT `Bicicletta_ibfk_1` FOREIGN KEY (`CodiceMateriale`) REFERENCES `Materiale` (`CodiceMateriale`) ON DELETE CASCADE;

--
-- Limiti per la tabella `Colonnina`
--
ALTER TABLE `Colonnina`
  ADD CONSTRAINT `Colonnina_ibfk_1` FOREIGN KEY (`CodiceMateriale`) REFERENCES `Materiale` (`CodiceMateriale`) ON DELETE CASCADE,
  ADD CONSTRAINT `Colonnina_ibfk_2` FOREIGN KEY (`Bicicletta`) REFERENCES `Bicicletta` (`CodiceMateriale`) ON DELETE SET NULL,
  ADD CONSTRAINT `Colonnina_ibfk_3` FOREIGN KEY (`NomeStazione`) REFERENCES `Stazione` (`NomeStazione`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `Manutenzione`
--
ALTER TABLE `Manutenzione`
  ADD CONSTRAINT `Manutenzione_ibfk_1` FOREIGN KEY (`CodiceMateriale`) REFERENCES `Materiale` (`CodiceMateriale`) ON DELETE CASCADE;

--
-- Limiti per la tabella `Operazione`
--
ALTER TABLE `Operazione`
  ADD CONSTRAINT `Operazione_ibfk_1` FOREIGN KEY (`Colonnina`) REFERENCES `Colonnina` (`CodiceMateriale`) ON DELETE CASCADE,
  ADD CONSTRAINT `Operazione_ibfk_2` FOREIGN KEY (`Bicicletta`) REFERENCES `Bicicletta` (`CodiceMateriale`) ON DELETE CASCADE,
  ADD CONSTRAINT `Operazione_ibfk_3` FOREIGN KEY (`IdTessera`) REFERENCES `Tessera` (`IdTessera`) ON DELETE CASCADE;

--
-- Limiti per la tabella `SegnalazioneMancanza`
--
ALTER TABLE `SegnalazioneMancanza`
  ADD CONSTRAINT `SegnalazioneMancanza_ibfk_1` FOREIGN KEY (`NomeStazione`) REFERENCES `Stazione` (`NomeStazione`) ON DELETE CASCADE,
  ADD CONSTRAINT `SegnalazioneMancanza_ibfk_2` FOREIGN KEY (`IdTessera`) REFERENCES `Tessera` (`IdTessera`) ON DELETE CASCADE;

--
-- Limiti per la tabella `SegnalazioneRottura`
--
ALTER TABLE `SegnalazioneRottura`
  ADD CONSTRAINT `SegnalazioneRottura_ibfk_1` FOREIGN KEY (`Colonnina`) REFERENCES `Colonnina` (`CodiceMateriale`) ON DELETE CASCADE,
  ADD CONSTRAINT `SegnalazioneRottura_ibfk_2` FOREIGN KEY (`IdTessera`) REFERENCES `Tessera` (`IdTessera`) ON DELETE CASCADE;

--
-- Limiti per la tabella `Utente`
--
ALTER TABLE `Utente`
  ADD CONSTRAINT `Utente_ibfk_1` FOREIGN KEY (`IdTessera`) REFERENCES `Tessera` (`IdTessera`) ON DELETE CASCADE;
