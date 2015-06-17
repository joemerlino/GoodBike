/* Database.sql */

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

/* TESSERA */
CREATE TABLE Tessera(
	IdTessera INTEGER UNSIGNED AUTO_INCREMENT,
	DataScadenza DATE NOT NULL,
	NoleggioInCorso BOOLEAN DEFAULT 0 NOT NULL,
	PRIMARY KEY(IdTessera)
)ENGINE=INNODB;

/* UTENTE */
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

/* MATERIALE */
CREATE TABLE Materiale(
	CodiceMateriale INTEGER UNSIGNED AUTO_INCREMENT,
	Tipo ENUM('Bicicletta','Colonnina') NOT NULL,
	Danneggiato BOOLEAN DEFAULT 0 NOT NULL,
	PRIMARY KEY(CodiceMateriale)
)ENGINE=INNODB;

/*BICICLETTA*/
CREATE TABLE Bicicletta(
	CodiceMateriale INTEGER UNSIGNED,
	Elettrica BOOLEAN DEFAULT 0 NOT NULL,
	Stato ENUM('InServizio','InMagazzino') DEFAULT 'InMagazzino' NOT NULL,
	PRIMARY KEY(CodiceMateriale),
	FOREIGN KEY (CodiceMateriale) REFERENCES Materiale(CodiceMateriale) ON DELETE CASCADE
)ENGINE=INNODB;

/*STAZIONE*/
CREATE TABLE Stazione(
	NomeStazione VARCHAR(20),
	Via VARCHAR(30) NOT NULL,
	PRIMARY KEY(NomeStazione)
)ENGINE=INNODB;

/*COLONNINA*/
CREATE TABLE Colonnina(
	CodiceMateriale INTEGER UNSIGNED,
	Bicicletta INTEGER UNSIGNED,
	NomeStazione VARCHAR(20) NOT NULL,
	PRIMARY KEY(CodiceMateriale),
	UNIQUE(Bicicletta),
	FOREIGN KEY (CodiceMateriale) REFERENCES Materiale(CodiceMateriale) ON DELETE CASCADE,
	FOREIGN KEY (Bicicletta) REFERENCES Bicicletta(CodiceMateriale) ON DELETE SET NULL,
	FOREIGN KEY (NomeStazione) REFERENCES Stazione(NomeStazione) ON DELETE CASCADE
)ENGINE=INNODB;

/*OPERAZIONE*/
CREATE TABLE Operazione(
	IdOperazione INTEGER UNSIGNED AUTO_INCREMENT,
	Orario DATETIME NOT NULL,
	Colonnina INTEGER UNSIGNED NOT NULL,
	Tipo ENUM('PerNoleggio','Trasporto') NOT NULL,
	TipologiaPerNoleggio ENUM('Prelievo','Deposito'),
	TipologiaTrasporto ENUM('Aggiunta','Rimozione'),
	IdTessera INTEGER UNSIGNED,
	PRIMARY KEY(IdOperazione),
	UNIQUE(Orario,Colonnina),
	FOREIGN KEY (Colonnina) REFERENCES Colonnina(CodiceMateriale) ON DELETE CASCADE,
	FOREIGN KEY (IdTessera) REFERENCES Tessera(IdTessera) ON DELETE CASCADE
)ENGINE=INNODB;

/* MANUTENZIONE */
CREATE TABLE Manutenzione(
	Numero INTEGER UNSIGNED,
	Data DATE,
	DescrizioneDanno VARCHAR(100),
	CodiceMateriale INTEGER UNSIGNED NOT NULL,
	PRIMARY KEY(Numero,Data),
	FOREIGN KEY (CodiceMateriale) REFERENCES Materiale(CodiceMateriale) ON DELETE CASCADE
)ENGINE=INNODB;

/* SEGNALAZIONEROTTURA */
CREATE TABLE SegnalazioneRottura(
	Colonnina INTEGER UNSIGNED,
	IdTessera INTEGER UNSIGNED,
	Bicicletta BOOLEAN NOT NULL,
	PRIMARY KEY(IdTessera,Colonnina),
	FOREIGN KEY (Colonnina) REFERENCES Colonnina(CodiceMateriale) ON DELETE CASCADE,
	FOREIGN KEY (IdTessera) REFERENCES Tessera(IdTessera) ON DELETE CASCADE
)ENGINE=INNODB;

/* SEGNALAZIONEMANCANZA */
CREATE TABLE SegnalazioneMancanza(
	NomeStazione VARCHAR(20),
	IdTessera INTEGER UNSIGNED,
	Data DATE NOT NULL,
	PRIMARY KEY(IdTessera,NomeStazione),
	FOREIGN KEY (NomeStazione) REFERENCES Stazione(NomeStazione) ON DELETE CASCADE,
	FOREIGN KEY (IdTessera) REFERENCES Tessera(IdTessera) ON DELETE CASCADE
)ENGINE=INNODB;

SET FOREIGN_KEY_CHECKS=1;