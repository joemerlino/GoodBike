/* Triggers.sql */

/*vanno */
DROP TRIGGER IF EXISTS insert_utente;

DELIMITER |
CREATE TRIGGER insert_bicicletta 
AFTER INSERT ON Bicicletta 
FOR EACH ROW BEGIN
DECLARE codice INTEGER;
SELECT MAX(CodiceMateriale) INTO codice FROM Materiale GROUP BY CodiceMateriale;
codice = codice + 1;
INSERT INTO Materiale (CodiceMateriale, Elettrica, Stato) VALUES (codice,"Bicicletta",0)
UPDATE Bicicletta SET NEW.CodiceMateriale = codice;
END|
DELIMITER;



/* non vanno */
DROP TRIGGER IF EXISTS insert_bicicletta;

DELIMITER |
CREATE TRIGGER insert_bicicletta 
AFTER INSERT ON Bicicletta 
FOR EACH ROW BEGIN
INSERT INTO Materiale (Tipo, Danneggiato) VALUES ('Bicicletta',0);
DECLARE codice INTEGER UNSIGNED;
SELECT MAX(CodiceMateriale) INTO codice FROM Materiale GROUP BY CodiceMateriale;
UPDATE Bicicletta SET NEW.CodiceMateriale = codice;
END|
DELIMITER;

/*
////////////////////////////////////
TRIGGER 

si può solo aggiundere tempo alla tessera, non tornare indietro
DROP TRIGGER IF EXISTS update_scadenza_tessera; 
CREATE TRIGGER update_scadenza_tessera BEFORE UPDATE ON Tessera FOR EACH ROW SET NEW.Codice = NULL WHEN NEW.DataScadenza <= OLD.DataScadenza;

un utente deve sempre rispettare regole di tipo : se studente allora IoStudio e CodiceStudente not null, se utente o turista null
DROP TRIGGER IF EXISTS insert_new_studente; 
CREATE TRIGGER insert_new_studente BEFORE INSERT ON Utente FOR EACH ROW BEGIN IF (NEW.Tipo == 'Studente' AND NEW.CodiceStudente IS NULL) OR (NEW.Tipo == 'Studente' AND NEW.IoStudio IS NULL) THEN SET NEW.IdTessera = NULL; ELSE SET NEW.CodiceStudente = NULL; NEW.IoStudio = NULL; ENDIF; END;

DROP TRIGGER IF EXISTS update_new_studente; 
CREATE TRIGGER update_new_studente BEFORE INSERT ON Utente FOR EACH ROW BEGIN IF OLD.Tipo != NEW.Tipo OR OLD.CodiceStudente != NEW.CodiceStudente OR OLD.IoStudio != NEW.IoStudio THEN IF (NEW.Tipo == 'Studente' AND NEW.CodiceStudente IS NULL) OR (NEW.Tipo == 'Studente' AND NEW.IoStudio IS NULL) THEN SET NEW.IdTessera = NULL; ELSE SET NEW.CodiceStudente = NULL; NEW.IoStudio = NULL; ENDIF; ENDIF; END;

una bicicletta deve avere codicemateriale

DROP TRIGGER IF EXISTS insert_noleggio; 
CREATE TRIGGER insert-noleggio BEFORE INSERT ON Noleggio FOR EACH ROW BEGIN DECLARE num INTEGER; SELECT COUNT(*) INTO num FROM Operazione ON NEW.Prelievo = Operazione.Codice WHERE NEW.Prelievo = Operazione.Codice AND Operazione.Tipo = 'Prelievo' AND Operazione.Trasporto = 0; IF num ! 1 THEN SET NEW.Tessera = NULL; SIGNAL SQLSTATE 'qualcosaXDXD'; ELSE bisogna andare su colonnina e deletare la presenza della bicicletta) END IF; END;

*idem per deposito, sempre se funziona XD

*/