/*
*
* Instituicao: Instituto Superior Tecnico
* Cadeira: Bases de Dados 15/16
* Autores: Antonio Tavares (78122), Luis Borges (78349), Paulo Ritto (78929)
*
*/

/*--alinea a--*/
SELECT L.userid FROM login L, utilizador U 
WHERE L.userid=U.userid 
GROUP BY L.userid HAVING AVG (L.sucesso) < 0.5;

/*--alinea b--*/
SELECT DISTINCT R.regcounter from registo R 
WHERE NOT EXISTS (SELECT P.pagecounter FROM pagina P 
				  WHERE R.userid = P.userid AND NOT EXISTS (SELECT * FROM reg_pag RP 
                                                            WHERE P.pagecounter = RP.pageid AND R.regcounter = RP.regid));

			
/*--alinea c--*/
SELECT DISTINCT P.userid FROM pagina P, reg_pag RP 
WHERE P.ativa=1 AND RP.ativa=1 AND P.userid=RP.userid 
GROUP BY P.userid 
HAVING (COUNT(DISTINCT RP.idregpag)/COUNT(DISTINCT P.pagecounter)) >= ALL(SELECT (COUNT(DISTINCT RP2.idregpag)/COUNT(DISTINCT P2.pagecounter)) FROM reg_pag RP2, pagina P2 
                                                                          WHERE RP2.ativa=1 AND P2.ativa=1 AND RP2.userid=P2.userid 
																		  GROUP BY P2.userid);

/*--alinea d--*/
SELECT U.userid AS userid FROM utilizador U, pagina P 
WHERE P.ativa =1 AND U.userid = P.userid AND P.userid 
NOT IN (SELECT DISTINCT U2.userid AS userid2 FROM utilizador U2, pagina P2 
        WHERE U2.userid = P2.userid AND P2.ativa=1 AND EXISTS (SELECT * FROM tipo_registo T 
                                                               WHERE U2.userid = T.userid AND T.ativo=1 AND NOT EXISTS (SELECT * FROM reg_pag A 
                                                                                                        WHERE P2.pagecounter = A.pageid AND T.typecnt = A.typeid AND A.ativa=1)));
