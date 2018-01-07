/*
*
* Instituicao: Instituto Superior Tecnico
* Cadeira: Bases de Dados 15/16
* Autores: Antonio Tavares (78122), Luis Borges (78349), Paulo Ritto (78929)
*
*/

/*
*
* Restrição de Integridade: Todo o valor de contador_sequencia existente na relação sequencia existe numa e uma vez no universo das relações tipo registo, pagina, campo, registo e valor.
*
*/


/* Procedimento que perante um idseq, retorna o número de vezes que se encontra na tabela sequência */
Delimiter //
create function conta-idseq (_idseq int(11))
	returns integer
begin
	declare idseq_count integer;
	select count(*) into idseq_count
		from sequencia
		where contador_sequencia = _idseq;
	return idseq_count;
End //
Delimiter ;

/* Trigger que verifica o insert na tabela tipo_registo */

Delimiter //
CREATE TRIGGER insert_check_tipo_registo BEFORE INSERT ON tipo_registo
FOR EACH ROW
BEGIN
IF conta-idseq(NEW.idseq) > 0 THEN
CALL PROC-QUE-NAO-EXISTE()
END IF;
END //
Delimiter ;

/* Trigger que verifica o insert na tabela pagina */

Delimiter //
CREATE TRIGGER insert_check_pagina BEFORE INSERT ON pagina
FOR EACH ROW
BEGIN
IF conta-idseq(NEW.idseq) > 0 THEN
CALL PROC-QUE-NAO-EXISTE()
END IF;
END //
Delimiter ;
/* Trigger que verifica o insert na tabela campo */

Delimiter //
CREATE TRIGGER insert_check_campo BEFORE INSERT ON campo
FOR EACH ROW
BEGIN
IF conta-idseq(NEW.idseq) > 0 THEN
CALL PROC-QUE-NAO-EXISTE()
END IF;
END //
Delimiter ;

/* Trigger que verifica o insert na tabela registo */

Delimiter //
CREATE TRIGGER insert_check_registo BEFORE INSERT ON registo
FOR EACH ROW
BEGIN
IF conta-idseq(NEW.idseq) > 0 THEN
CALL PROC-QUE-NAO-EXISTE()
END IF;
END //
Delimiter ;

/* Trigger que verifica o insert na tabela valor */
Delimiter //
CREATE TRIGGER insert_check_valor BEFORE INSERT ON valor
FOR EACH ROW
BEGIN
IF conta-idseq(NEW.idseq) > 0 THEN
CALL PROC-QUE-NAO-EXISTE()
END IF;
END //
Delimiter ; 

/* Trigger que verifica o update na tabela tipo_registo */
Delimiter //
CREATE TRIGGER insert_check_tipo_registo BEFORE UPDATE ON tipo_registo
FOR EACH ROW
BEGIN
IF conta-idseq(NEW.idseq) > 0 THEN
CALL PROC-QUE-NAO-EXISTE()
END IF;
END //
Delimiter ;

/* Trigger que verifica o update na tabela pagina */
Delimiter //
CREATE TRIGGER insert_check_pagina BEFORE UPDATE ON pagina
FOR EACH ROW
BEGIN
IF conta-idseq(NEW.idseq) > 0 THEN
CALL PROC-QUE-NAO-EXISTE()
END IF;
END //
Delimiter ;

/* Trigger que verifica o update na tabela campo */
Delimiter //
CREATE TRIGGER insert_check_campo BEFORE UPDATE ON campo
FOR EACH ROW
BEGIN
IF conta-idseq(NEW.idseq) > 0 THEN
CALL PROC-QUE-NAO-EXISTE()
END IF;
END //
Delimiter ;

/* Trigger que verifica o update na tabela registo */
Delimiter //
CREATE TRIGGER insert_check_registo BEFORE UPDATE ON registo
FOR EACH ROW
BEGIN
IF conta-idseq(NEW.idseq) > 0 THEN
CALL PROC-QUE-NAO-EXISTE()
END IF;
END //
Delimiter ;

/*Trigger que verifica o update na tabela valor */
Delimiter //
CREATE TRIGGER insert_check_valor BEFORE UPDATE ON valor
FOR EACH ROW
BEGIN
IF conta-idseq(NEW.idseq) > 0 THEN
CALL PROC-QUE-NAO-EXISTE()
END IF;
END //
Delimiter ;


