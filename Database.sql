
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS SegnalazioneMancanza;
DROP TABLE IF EXISTS SegnalazioneRottura;
DROP TABLE IF EXISTS Manutenzione;
DROP TABLE IF EXISTS Operazione;
DROP TABLE IF EXISTS Colonnina;
DROP TABLE IF EXISTS Stazione;
DROP TABLE IF EXISTS Bicicletta;
DROP TABLE IF EXISTS Materiale;
DROP TABLE IF EXISTS Utente;
DROP TABLE IF EXISTS Tessera;

CREATE TABLE Tessera(
	IdTessera INTEGER UNSIGNED AUTO_INCREMENT,
	DataAttivazione DATE NOT NULL,
	PRIMARY KEY(IdTessera)
)ENGINE=INNODB;

CREATE TABLE Utente(
	Nome VARCHAR(20) NOT NULL,
	Cognome VARCHAR(20) NOT NULL,
	DataNascita DATE NOT NULL,
	LuogoNascita VARCHAR(20) NOT NULL,
	Residenza VARCHAR(20) NOT NULL,
	Indirizzo VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL,
	Tipo ENUM('Utente','Turista','Studente') DEFAULT 'Utente' NOT NULL,
	CodiceStudente CHAR(10),
	IoStudio BOOLEAN,
	IdTessera INTEGER UNSIGNED,
	PRIMARY KEY(IdTessera),
	UNIQUE(Email),
	FOREIGN KEY (IdTessera) REFERENCES Tessera(IdTessera) ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE Materiale(
	CodiceMateriale INTEGER UNSIGNED AUTO_INCREMENT,
	Danneggiato BOOLEAN DEFAULT 0 NOT NULL,
	PRIMARY KEY(CodiceMateriale)
)ENGINE=INNODB;

CREATE TABLE Bicicletta(
	CodiceMateriale INTEGER UNSIGNED,
	Elettrica BOOLEAN DEFAULT 0 NOT NULL,
	Stato ENUM('InServizio','InMagazzino') DEFAULT 'InMagazzino' NOT NULL,
	PRIMARY KEY(CodiceMateriale),
	FOREIGN KEY (CodiceMateriale) REFERENCES Materiale(CodiceMateriale) ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE Stazione(
	NomeStazione VARCHAR(20),
	Via VARCHAR(30) NOT NULL,
	PRIMARY KEY(NomeStazione)
)ENGINE=INNODB;

CREATE TABLE Colonnina(
	CodiceMateriale INTEGER UNSIGNED,
	Bicicletta INTEGER UNSIGNED DEFAULT NULL,
	NomeStazione VARCHAR(20) NOT NULL,
	PRIMARY KEY(CodiceMateriale),
	UNIQUE(Bicicletta),
	FOREIGN KEY (CodiceMateriale) REFERENCES Materiale(CodiceMateriale) ON DELETE CASCADE,
	FOREIGN KEY (Bicicletta) REFERENCES Bicicletta(CodiceMateriale) ON DELETE SET NULL,
	FOREIGN KEY (NomeStazione) REFERENCES Stazione(NomeStazione) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

CREATE TABLE Operazione(
	IdOperazione INTEGER UNSIGNED AUTO_INCREMENT,
	Orario DATETIME NOT NULL,
	Colonnina INTEGER UNSIGNED NOT NULL,
	Bicicletta INTEGER UNSIGNED NOT NULL,
	Motivazione ENUM('Prelievo','Deposito','Aggiunta','Rimozione') NOT NULL,
	IdTessera INTEGER UNSIGNED,
	PRIMARY KEY(IdOperazione),
	FOREIGN KEY (Colonnina) REFERENCES Colonnina(CodiceMateriale) ON DELETE CASCADE,
	FOREIGN KEY (Bicicletta) REFERENCES Bicicletta(CodiceMateriale) ON DELETE CASCADE,
	FOREIGN KEY (IdTessera) REFERENCES Tessera(IdTessera) ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE Manutenzione(
	NumeroManutenzione INTEGER UNSIGNED AUTO_INCREMENT,
	DataManutenzione DATE NOT NULL,
	DescrizioneDanno VARCHAR(100),
	CodiceMateriale INTEGER UNSIGNED NOT NULL,
	PRIMARY KEY(NumeroManutenzione),
	FOREIGN KEY (CodiceMateriale) REFERENCES Materiale(CodiceMateriale) ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE SegnalazioneRottura(
	Colonnina INTEGER UNSIGNED,
	IdTessera INTEGER UNSIGNED,
	PRIMARY KEY(IdTessera,Colonnina),
	FOREIGN KEY (Colonnina) REFERENCES Colonnina(CodiceMateriale) ON DELETE CASCADE,
	FOREIGN KEY (IdTessera) REFERENCES Tessera(IdTessera) ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE SegnalazioneMancanza(
	NomeStazione VARCHAR(20),
	IdTessera INTEGER UNSIGNED,
	DataSegnalazione DATE NOT NULL,
	PRIMARY KEY(IdTessera,NomeStazione),
	FOREIGN KEY (NomeStazione) REFERENCES Stazione(NomeStazione) ON DELETE CASCADE,
	FOREIGN KEY (IdTessera) REFERENCES Tessera(IdTessera) ON DELETE CASCADE
)ENGINE=INNODB;

/* trigger */

DROP TRIGGER IF EXISTS insert_utente;
DROP TRIGGER IF EXISTS delete_tessera;
DROP TRIGGER IF EXISTS insert_bicicletta;
DROP TRIGGER IF EXISTS delete_bicicletta;
DROP TRIGGER IF EXISTS insert_colonnina;
DROP TRIGGER IF EXISTS delete_colonnina;
DROP TRIGGER IF EXISTS insert_operazione;
DROP TRIGGER IF EXISTS insert_manutenzione;
DROP TRIGGER IF EXISTS insert_segnalazione_rottura;
DROP TRIGGER IF EXISTS insert_segnalazione_mancanza;

DELIMITER |
CREATE TRIGGER insert_utente
BEFORE INSERT ON Utente
FOR EACH ROW BEGIN
DECLARE idT INTEGER UNSIGNED;
DECLARE dat DATE;
SELECT CURDATE() INTO dat;
INSERT INTO Tessera(DataAttivazione) VALUES (dat);
SELECT Tessera.IdTessera INTO idT FROM Tessera ORDER BY Tessera.IdTessera DESC LIMIT 1;
SET NEW.IdTessera = idT;
IF NEW.Tipo = 'Utente' OR NEW.Tipo = 'Turista' THEN SET NEW.CodiceStudente = NULL; SET NEW.IoStudio = NULL;
ElSE IF NEW.CodiceStudente IS NULL OR NEW.IoStudio IS NULL THEN SET NEW.IdTessera = NULL;
END IF; END IF;
END|
DELIMITER ;

DELIMITER |
CREATE TRIGGER delete_tessera
AFTER DELETE ON Tessera
FOR EACH ROW BEGIN
DECLARE mot ENUM('Prelievo','Deposito','Aggiunta','Rimozione');
SELECT Operazione.Motivazione INTO mot FROM Operazione WHERE Operazione.IdTessera = OLD.IdTessera ORDER BY Operazione.Orario DESC LIMIT 1;
IF mot = 'Prelievo' THEN INSERT INTO Tessera(IdTessera) VALUES (NULL);
END IF;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_bicicletta
BEFORE INSERT ON Bicicletta
FOR EACH ROW BEGIN
DECLARE num INTEGER UNSIGNED;
INSERT INTO Materiale(Danneggiato) VALUES (0);
SELECT Materiale.CodiceMateriale INTO num FROM Materiale ORDER BY Materiale.CodiceMateriale DESC LIMIT 1;
SET NEW.CodiceMateriale = num;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER delete_bicicletta
AFTER DELETE ON Bicicletta
FOR EACH ROW BEGIN
DECLARE mot ENUM('Prelievo','Deposito','Aggiunta','Rimozione');
SELECT Operazione.Motivazione INTO mot FROM Operazione WHERE Operazione.Bicicletta = OLD.CodiceMateriale ORDER BY Operazione.Orario DESC LIMIT 1;
IF mot = 'Prelievo' THEN INSERT INTO Materiale(CodiceMateriale) VALUES (NULL);
END IF;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_colonnina
BEFORE INSERT ON Colonnina
FOR EACH ROW BEGIN
DECLARE num INTEGER UNSIGNED;
INSERT INTO Materiale(Danneggiato) VALUES (0);
SELECT Materiale.CodiceMateriale INTO num FROM Materiale ORDER BY Materiale.CodiceMateriale DESC LIMIT 1;
SET NEW.CodiceMateriale = num;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER delete_colonnina
AFTER DELETE ON Colonnina
FOR EACH ROW BEGIN
IF OLD.Bicicletta IS NOT NULL THEN UPDATE Bicicletta SET Stato = 'InMagazzino' WHERE Bicicletta.CodiceMateriale = OLD.Bicicletta;
END IF;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_operazione
BEFORE INSERT ON Operazione
FOR EACH ROW BEGIN
DECLARE nol BOOLEAN;
DECLARE mot ENUM('Prelievo','Deposito','Aggiunta','Rimozione');
DECLARE dat DATETIME;
SET nol = FALSE;
SELECT NOW() INTO dat;
SET NEW.Orario = dat;
IF NEW.Motivazione = 'Prelievo' OR NEW.Motivazione = 'Deposito' THEN
IF NEW.IdTessera IS NULL THEN SET NEW.IdOperazione = NULL;
END IF;
SELECT Operazione.Motivazione INTO mot FROM Operazione WHERE Operazione.IdTessera = NEW.IdTessera AND Operazione.Motivazione = 'Prelievo' AND Operazione.IdOperazione <> NEW.IdOperazione ORDER BY Operazione.Orario DESC LIMIT 1;
IF mot = 'Prelievo' THEN SET nol = TRUE; END IF;
IF NEW.Motivazione = 'Prelievo' THEN IF nol = TRUE THEN SET NEW.IdOperazione = NULL;
ElSE UPDATE Colonnina SET Colonnina.Bicicletta = NULL WHERE Colonnina.CodiceMateriale = NEW.Colonnina;
END IF; END IF;
IF NEW.Motivazione = 'Deposito' THEN IF nol = FALSE THEN SET NEW.IdOperazione = NULL;
ELSE UPDATE Colonnina SET Colonnina.Bicicletta = NEW.Bicicletta WHERE Colonnina.CodiceMateriale = NEW.Colonnina;
END IF; END IF;
ELSE
IF NEW.Motivazione = 'Aggiunta' THEN
IF NEW.IdTessera IS NOT NULL THEN SET NEW.IdTessera = NULL;
END IF;
UPDATE Bicicletta SET Bicicletta.Stato = 'InServizio' WHERE Bicicletta.CodiceMateriale = NEW.Bicicletta;
UPDATE Colonnina SET Colonnina.Bicicletta = NEW.Bicicletta WHERE Colonnina.CodiceMateriale = NEW.Colonnina;
END IF;
IF NEW.Motivazione = 'Rimozione' THEN
IF NEW.IdTessera IS NOT NULL THEN SET NEW.IdTessera = NULL;
END IF;
UPDATE Bicicletta SET Bicicletta.Stato = 'InMagazzino' WHERE Bicicletta.CodiceMateriale = NEW.Bicicletta;
UPDATE Colonnina SET Colonnina.Bicicletta = NULL WHERE Colonnina.CodiceMateriale = NEW.Colonnina;
END IF; END IF;
DELETE FROM SegnalazioneMancanza WHERE SegnalazioneMancanza.NomeStazione = (SELECT Colonnina.NomeStazione FROM Colonnina WHERE NEW.Colonnina = Colonnina.CodiceMateriale LIMIT 1);
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_manutenzione
BEFORE INSERT ON Manutenzione
FOR EACH ROW BEGIN
DECLARE dat DATE;
DECLARE bic INTEGER UNSIGNED;
SELECT CURDATE() INTO dat;
SET NEW.DataManutenzione = dat;
DELETE FROM SegnalazioneRottura WHERE NEW.CodiceMateriale = SegnalazioneRottura.Colonnina;
UPDATE Materiale SET Materiale.Danneggiato = FALSE WHERE NEW.CodiceMateriale = Materiale.CodiceMateriale;
SELECT Colonnina.Bicicletta INTO bic FROM Colonnina WHERE NEW.CodiceMateriale = Colonnina.CodiceMateriale;
IF bic IS NOT NULL THEN UPDATE Materiale SET Materiale.Danneggiato = FALSE WHERE bic = Materiale.CodiceMateriale;
END IF;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_segnalazione_rottura
BEFORE INSERT ON SegnalazioneRottura
FOR EACH ROW BEGIN
UPDATE Materiale SET Materiale.Danneggiato = TRUE WHERE NEW.Colonnina = Materiale.CodiceMateriale;
UPDATE Materiale JOIN Colonnina ON Materiale.CodiceMateriale = Colonnina.Bicicletta AND NEW.Colonnina = Colonnina.CodiceMateriale SET Materiale.Danneggiato = TRUE WHERE NEW.Colonnina = Colonnina.CodiceMateriale;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_segnalazione_mancanza
BEFORE INSERT ON SegnalazioneMancanza
FOR EACH ROW BEGIN
DECLARE dat DATE;
SELECT CURDATE() INTO dat;
SET NEW.DataSegnalazione = dat;
END |
DELIMITER ;

/* non so se mancano altri trigger */

SET FOREIGN_KEY_CHECKS=1;

/* insert */

INSERT INTO Utente(Nome, Cognome, DataNascita, LuogoNascita, Residenza,Indirizzo, Email, Tipo, CodiceStudente, IoStudio) VALUES ('Giovanni','Rossi','1990-08-23','Padova','Vigonza','Via Pascoli, 8','giovannirossi@email.it','Utente',NULL,NULL),('Paolo','Gironi','1980-10-10','Venezia','Padova','Via Montegrappa, 10','paolo@email.it','Turista',NULL,NULL),('Davide','Ceron','1992-10-12','Montebelluna','Montebelluna','Via salice, 7','cerondavid@gmail.com','Studente','287654',0);

INSERT INTO Bicicletta (Elettrica) VALUES (0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(1),(0),(0),(1),(0),(0),(0),(0),(0),(0),(0),(0),(0),(1),(0),(0),(0),(0),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1);

INSERT INTO Stazione (NomeStazione, Via) VALUES ('Paolotti','Via Paolotti'),('Prato','Via del Santo'),('Stazione','Pizzale Stazione'),('Santo','Via dei Santi');

INSERT INTO Colonnina (NomeStazione) VALUES ('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Paolotti'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Prato'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Stazione'),('Santo'),('Santo'),('Santo'),('Santo'),('Santo'),('Santo'),('Santo'),('Santo'),('Santo'),('Santo'),('Santo'),('Santo');

INSERT INTO Operazione(Colonnina,Bicicletta,Motivazione,IdTessera) VALUES (41,1,'Aggiunta',NULL),(42,3,'Aggiunta',NULL),(43,4,'Aggiunta',NULL),(44,18,'Aggiunta',NULL),(45,27,'Aggiunta',NULL),(46,25,'Aggiunta',NULL),(47,8,'Aggiunta',NULL),(48,12,'Aggiunta',NULL),(49,24,'Aggiunta',NULL),(50,21,'Aggiunta',NULL),(51,29,'Aggiunta',NULL),(52,23,'Aggiunta',NULL),(53,20,'Aggiunta',NULL),(54,15,'Aggiunta',NULL),(55,35,'Aggiunta',NULL),(56,26,'Aggiunta',NULL),(57,7,'Aggiunta',NULL),(58,32,'Aggiunta',NULL),(59,10,'Aggiunta',NULL),(60,36,'Aggiunta',NULL),(81,16,'Aggiunta',NULL),(85,17,'Aggiunta',NULL),(86,30,'Aggiunta',NULL),(87,6,'Aggiunta',NULL),(91,11,'Aggiunta',NULL),(97,33,'Aggiunta',NULL),(98,9,'Aggiunta',NULL),(99,22,'Aggiunta',NULL),(101,28,'Aggiunta',NULL),(106,13,'Aggiunta',NULL),(54,15,'Rimozione',NULL),(81,16,'Rimozione',NULL);

INSERT INTO SegnalazioneMancanza (NomeStazione, IdTessera) VALUES ('Paolotti',1),('Paolotti',2),('Prato',1);

INSERT INTO SegnalazioneRottura (Colonnina, IdTessera) VALUES (81,1),(59,1),(60,2),(81,2);

INSERT INTO Manutenzione(DescrizioneDanno, CodiceMateriale) VALUES ('riparato il lucchetto elettronico',60);

/*
UPDATE Operazione SET Operazione.Orario = '2015-07-15 08:45:47' WHERE Operazione.IdOperazione = '1';
UPDATE Operazione SET Operazione.Orario = '2015-07-15 17:37:29' WHERE Operazione.IdOperazione = '2';
*/

/*operazioni eseguibili:
inserimento utente (inserimento tessera in automatico)
aggiornamento di alcuni dati dell'utente ............ forse
eliminazione di una tessera (elimina utente in automatico)
inserimento di una stazione
eliminazione di una stazione
inserimento di una bicicletta o di una colonnina(inserimento materiale in automatico)
eliminatione di un materiale
inserimento di una operazione
inserimento di una manutenzione(elimina in automatico le segnalazioni di rottura)
inserimento di una segnalazione di rottura 
inserimento di una segnalazione di mancanza
(procedura per l'eliminazione delle segnalazioni di mancanze, o qualcosa di simile)
*/