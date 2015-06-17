/* Inserts.sql */

INSERT INTO Tessera (IdTessera, DataScadenza, NoleggioInCorso) VALUES
	(1, '2015-06-30', 0),
	(2, '2015-07-14', 0);

INSERT INTO Utente (Nome, Cognome, DataNascita, LuogoNascita, Residenza,Indirizzo, Email, Tipo, CodiceStudente, IoStudio, IdTessera) VALUES
	(),
	();

INSERT INTO Materiale (CodiceMateriale, Tipo, Danneggiato) VALUES
	(),
	();

INSERT INTO Bicicletta (CodiceMateriale, Elettrica, Stato) VALUES
	(),
	();

INSERT INTO Stazione (NomeStazione, Via) VALUES
	(),
	();

INSERT INTO Colonnina (CodiceMateriale, Bicicletta, NomeStazione) VALUES
	(),
	();

INSERT INTO Operazione (IdOperazione, Orario, Colonnina, Tipo, TipologiaPerNoleggio, TipologiaTrasporto, IdTessera) VALUES
	(),
	();

INSERT INTO Manutenzione(Numero, Data, DescrizioneDanno, CodiceMateriale) VALUES
	(),
	();

INSERT INTO SegnalazioneRottura (Colonnina, IdTessera, Bicicletta) VALUES
	(),
	();

INSERT INTO SegnalazioneMancanza (NomeStazione, IdTessera, Data) VALUES
	(),
	();