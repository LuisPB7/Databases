/*
*
* Instituicao: Instituto Superior Tecnico
* Cadeira: Bases de Dados 15/16
* Autores: Antonio Tavares (78122), Luis Borges (78349), Paulo Ritto (78929)
*
*/

/*--alinea a--*/

CREATE TABLE IF NOT EXISTS d_utilizador (
    userid INT NOT NULL  AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    pais VARCHAR(45) NOT NULL,
    categoria VARCHAR(45) NOT NULL,
FOREIGN KEY (userid) REFERENCES utilizador(userid),
UNIQUE INDEX email_UNIQUE (email) 
);

CREATE TABLE IF NOT EXISTS d_tempo (
    dia TINYINT(31),
    mes TINYINT(12),
    ano INT NOT NULL,
);

CREATE TABLE IF NOT EXISTS login_fact (
    userid INT NOT NULL,
    dia TINYINT(31),
    mes TINYINT(12),
    ano INT NOT NULL,
    numero_logins INT NOT NULL,	 
PRIMARY KEY (userid),
);

/*--alinea b--*/

SELECT AVG(numero_logins) FROM login_fact LF, d_utilizador U, d_tempo T 
WHERE LF.userid = U.userid AND U.pais = 'Portugal' 
GROUP BY ROLLUP (U.categoria, T.ano, T.mes);

