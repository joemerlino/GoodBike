





per il controllo della password e il riperimento delle info personali (se ritorna qualcosa il login è valido, il qualcosa è per le info profilo)
SELECT * FROM Utente JOIN Tessera WHERE Utente.IdTessera = 'xIdTessera' AND Utente.Email = 'xEmail';