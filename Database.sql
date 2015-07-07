
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
	DataScadenza DATE NOT NULL,
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
	Bicicletta INTEGER UNSIGNED,
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
	UNIQUE(Orario,Colonnina),
	FOREIGN KEY (Colonnina) REFERENCES Colonnina(CodiceMateriale) ON DELETE CASCADE,
	FOREIGN KEY (Bicicletta) REFERENCES Bicicletta(CodiceMateriale) ON DELETE CASCADE,
	FOREIGN KEY (IdTessera) REFERENCES Tessera(IdTessera) ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE Manutenzione(
	Numero INTEGER UNSIGNED,
	DataManutenzione DATE NOT NULL,
	DescrizioneDanno VARCHAR(100),
	CodiceMateriale INTEGER UNSIGNED NOT NULL,
	PRIMARY KEY(Numero,DataManutenzione),
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

DROP TRIGGER IF EXISTS insert_utente;
DROP TRIGGER IF EXISTS update_tessera;
DROP TRIGGER IF EXISTS insert_bicicletta;
DROP TRIGGER IF EXISTS insert_colonnina;
DROP TRIGGER IF EXISTS insert_operazione;
DROP TRIGGER IF EXISTS insert_manutenzione;
DROP TRIGGER IF EXISTS insert_segnalazione_rottura;
DROP TRIGGER IF EXISTS insert_segnalazione_mancanza;

DELIMITER |
CREATE TRIGGER insert_utente
BEFORE INSERT ON Utente
FOR EACH ROW BEGIN
IF NEW.Tipo = 'Utente' OR NEW.Tipo = 'Turista' THEN SET NEW.CodiceStudente = NULL; SET NEW.IoStudio = NULL;
ElSE IF NEW.CodiceStudente IS NULL OR NEW.IoStudio IS NULL THEN SET NEW.IdTessera = NULL;
END IF;
END IF;
END|
DELIMITER ;

DELIMITER |
CREATE TRIGGER update_tessera
BEFORE UPDATE ON Tessera
FOR EACH ROW BEGIN
IF NEW.DataScadenza < OLD.DataScadenza THEN SET NEW.DataScadenza = OLD.DataScadenza;
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
CREATE TRIGGER insert_colonnina
BEFORE INSERT ON Colonnina
FOR EACH ROW BEGIN
DECLARE num INTEGER UNSIGNED;
/*SELECT Bicicletta.CodiceMateriale INTO num FROM Bicicletta LEFT JOIN Materiale ON Bicicletta.CodiceMateriale = Materiale.CodiceMateriale WHERE Bicicletta.CodiceMateriale = NEW.Bicicletta LIMIT 1;
IF num <> NEW.Bicicletta THEN SET NEW.CodiceMateriale = NULL;
END IF;*/ /* non credo serva */
INSERT INTO Materiale(Danneggiato) VALUES (0);
SELECT Materiale.CodiceMateriale INTO num FROM Materiale ORDER BY Materiale.CodiceMateriale DESC LIMIT 1;
SET NEW.CodiceMateriale = num;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_operazione
BEFORE INSERT ON Operazione
FOR EACH ROW BEGIN
DECLARE nol BOOLEAN;
DECLARE tes INTEGER UNSIGNED;
DECLARE dat DATETIME;
SET nol = FALSE;
SELECT NOW() INTO dat;
SET NEW.Orario = dat;
IF NEW.Motivazione = 'Prelievo' OR NEW.Motivazione = 'Deposito' THEN
IF NEW.IdTessera IS NULL THEN SET NEW.IdOperazione = NULL;
END IF;
SELECT IdTessera INTO tes FROM Tessera JOIN Operazione ON Tessera.IdTessera = Operazione.IdTessera WHERE Tessera.IdTessera = NEW.IdTessera AND Operazione.Motivazone = 'Prelievo' AND Operazione.IdOperazione <> NEW.IdOperazione ORDER BY Operazione.Orario DESC LIMIT 1;
IF tes IS NOT NULL THEN SET nol = TRUE; END IF;
IF NEW.Motivazione = 'Prelievo' THEN IF nol = TRUE THEN SET NEW.IdOperazione = NULL;
ELSE UPDATE Tessera SET NoleggioInCorso = TRUE WHERE Tessera.IdTessera = NEW.IdTessera;
END IF;
END IF;
IF NEW.Motivazione = 'Deposito' THEN IF nol = FALSE THEN SET NEW.IdOperazione = NULL;
ELSE UPDATE Tessera SET NoleggioInCorso = FALSE WHERE Tessera.IdTessera = NEW.IdTessera;
END IF;
END IF;
ELSE
IF NEW.Motivazione = 'Aggiunta' THEN
IF NEW.IdTessera IS NOT NULL  THEN SET NEW.IdTessera = NULL;
END IF;
UPDATE Bicicletta SET Stato = 'InServizio' WHERE Bicicletta.CodiceMateriale = NEW.Bicicletta;
END IF;
IF NEW.Motivazione = 'Rimozione' THEN
IF NEW.IdTessera IS NOT NULL  THEN SET NEW.IdTessera = NULL;
END IF;
UPDATE Bicicletta SET Stato = 'InMagazzino' WHERE Bicicletta.CodiceMateriale = NEW.Bicicletta;
END IF;
END IF;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_manutenzione
BEFORE INSERT ON Manutenzione
FOR EACH ROW BEGIN
DECLARE dat DATE;
SELECT CURDATE() INTO dat;
SET NEW.DataManutenzione = dat;
DELETE FROM SegnalazioneRottura WHERE NEW.CodiceMateriale = Manutenzione.Colonnina;
UPDATE CodiceMateriale SET CodiceMateriale.danneggiata = FALSE WHERE NEW.CodiceMateriale = Materiale.CodiceMateriale;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_segnalazione_rottura
BEFORE INSERT ON SegnalazioneRottura
FOR EACH ROW BEGIN
UPDATE Materiale SET Materiale.danneggiata = TRUE WHERE NEW.Colonnina = Materiale.CodiceMateriale;
UPDATE Materiale JOIN Colonnina ON Materiale.CodiceMateriale = Colonnina.Bicicletta SET Materiale.danneggiata = TRUE WHERE NEW.Colonnina = Colonnina.CodiceMateriale;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_segnalazione_mancanza
BEFORE INSERT ON SegnalazioneMancanza
FOR EACH ROW BEGIN
DECLARE num INTEGER;
DECLARE vuo INTEGER;
DECLARE dat DATE;
SELECT CURDATE() INTO dat;
SET NEW.DataSegnalazione = dat;
SELECT COUNT(CodiceMateriale) INTO num FROM Colonnina WHERE Colonnina.NomeStazione = NEW.NomeStazione;
SELECT COUNT(CodiceMateriale) INTO vuo FROM Colonnina WHERE Colonnina.NomeStazione = NEW.NomeStazione AND Colonnina.Bicicletta IS NULL;
IF vou = 0 OR num = vuo THEN SET NEW.IdTessera = NULL;
END IF;
END |
DELIMITER ;

/* non so se mancano altri trigger */

INSERT INTO Tessera(DataScadenza) VALUES ('2015-06-30'),('2015-09-14'),('2015-08-22');

INSERT INTO Utente(Nome, Cognome, DataNascita, LuogoNascita, Residenza,Indirizzo, Email, Tipo, CodiceStudente, IoStudio, IdTessera) VALUES ('Giovanni','Rossi','1990-08-23','Padova','Vigonza','Via Pascoli, 8','giovannirossi@email.it','Utente',NULL,NULL,1),('Paolo','Gironi','1980-10-10','Venezia','Padova','Via Montegrappa, 10','paolo@email.it','Turista',NULL,NULL,2),('Davide','Ceron','1992-10-12','Montebelluna','Montebelluna','Via salice, 7','cerondavid@gmail.com','Studente','287654',0,3);

INSERT INTO Bicicletta (Elettrica) VALUES (0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(1),(0),(0),(1),(0),(0),(0),(0),(0),(0),(0),(0),(0),(1),(0),(0),(0),(0),(0);

INSERT INTO Stazione (NomeStazione, Via) VALUES ('Paolotti','Via Paolotti'),('Prato','Via del Santo'),('Stazione','Pizzale Stazione');

INSERT INTO Colonnina (Bicicletta, NomeStazione) VALUES (1,'Paolotti'),(22,'Paolotti'),(23,'Paolotti'),(21,'Paolotti'),(NULL,'Paolotti'),(20,'Paolotti'),(NULL,'Paolotti'),(NULL,'Paolotti'),(24,'Paolotti'),(NULL,'Paolotti'),(NULL,'Paolotti'),(2,'Paolotti'),(3,'Paolotti'),(NULL,'Paolotti'),(NULL,'Paolotti'),(NULL,'Paolotti'),(19,'Paolotti'),(NULL,'Paolotti'),(25,'Paolotti'),(NULL,'Paolotti'),(4,'Prato'),(NULL,'Prato'),(26,'Prato'),(NULL,'Prato'),(5,'Prato'),(NULL,'Prato'),(27,'Prato'),(NULL,'Prato'),(6,'Prato'),(NULL,'Prato'),(NULL,'Prato'),(7,'Prato'),(NULL,'Prato'),(18,'Prato'),(NULL,'Prato'),(28,'Prato'),(NULL,'Prato'),(NULL,'Prato'),(8,'Prato'),(NULL,'Prato'),(13,'Stazione'),(NULL,'Stazione'),(NULL,'Stazione'),(12,'Stazione'),(NULL,'Stazione'),(NULL,'Stazione'),(30,'Stazione'),(NULL,'Stazione'),(NULL,'Stazione'),(9,'Stazione'),(16,'Stazione'),(NULL,'Stazione'),(10,'Stazione'),(NULL,'Stazione'),(NULL,'Stazione'),(NULL,'Stazione'),(NULL,'Stazione'),(11,'Stazione'),(NULL,'Stazione'),(NULL,'Stazione');

/*
INSERT INTO Operazione (IdOperazione, Orario, Colonnina, Tipo, TipologiaPerNoleggio, TipologiaTrasporto, IdTessera) VALUES (),();

INSERT INTO Manutenzione(Numero, Data, DescrizioneDanno, CodiceMateriale) VALUES (),();

INSERT INTO SegnalazioneRottura (Colonnina, IdTessera, Bicicletta) VALUES (),();

INSERT INTO SegnalazioneMancanza (NomeStazione, IdTessera, Data) VALUES (),();
*/

SET FOREIGN_KEY_CHECKS=1;