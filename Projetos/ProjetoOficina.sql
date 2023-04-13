DELIMITER $

/* STATUS */
STATUS
SHOW PROCEDURE STATUS WHERE DB = 'PROJETO_OFICINA';

/* CREATE DATABASE */
CREATE DATABASE PROJETO_OFICINA;

/* USE DATABASE */
USE PROJETO_OFICINA;

/* CREATE TABLES*/
CREATE TABLE CARRO(
    ID_CARRO INT PRIMARY KEY AUTO_INCREMENT,
    MODELO VARCHAR(20) NOT NULL,
    PLACA CHAR(6) NOT NULL UNIQUE,
    FK_MARCA_CARRO INT NOT NULL
);

CREATE TABLE MARCA(
    ID_MARCA INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(20) UNIQUE
);

CREATE TABLE TELEFONE(
    ID_TELEFONE INT PRIMARY KEY AUTO_INCREMENT,  
    TIPO ENUM('RES', 'CEL')DEFAULT 'RES',
    NUMERO VARCHAR(12),
    FK_CLIENTE_TELEFONE INT
);

CREATE TABLE CLIENTE(
    ID_CLIENTE INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(30) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    FK_CARRO_CLIENTE INT NOT NULL UNIQUE
);

CREATE TABLE COR(
    ID_COR INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE CARRO_COR(
    FK_CARRO INT NOT NULL,
    FK_COR INT NOT NULL,
    PRIMARY KEY(FK_CARRO,FK_COR)
);

/* CONSTRAINTS */
ALTER TABLE TELEFONE
ADD FOREIGN KEY (FK_CLIENTE_TELEFONE)
REFERENCES CLIENTE(ID_CLIENTE);

ALTER TABLE CLIENTE
ADD FOREIGN KEY (FK_CARRO_CLIENTE)
REFERENCES CARRO(ID_CARRO);

ALTER TABLE CARRO
ADD FOREIGN KEY (FK_MARCA_CARRO)
REFERENCES MARCA(ID_MARCA);

ALTER TABLE CARRO_COR
ADD FOREIGN KEY (FK_CARRO)
REFERENCES CARRO(ID_CARRO);

ALTER TABLE CARRO_COR
ADD FOREIGN KEY (FK_COR)
REFERENCES COR(ID_COR);
$

/* PROCEDURE */
CREATE PROCEDURE INSERT_CLIENTE(P_NOME VARCHAR(30), P_CPF CHAR(11), FK_CARRO_CLIENTE INT)
BEGIN
    INSERT INTO CLIENTE(ID_CLIENTE, NOME, CPF, FK_CARRO_CLIENTE)
        VALUES (NULL, P_NOME, P_CPF, FK_CARRO_CLIENTE);
END$

CREATE PROCEDURE INSERT_MARCA(P_NOME VARCHAR(20))
BEGIN
    INSERT INTO MARCA(ID_MARCA, NOME) 
        VALUES (NULL, P_NOME);
END;

CREATE PROCEDURE INSERT_CARRO(P_MODELO VARCHAR(20), P_PLACA CHAR(6), P_FK_MARCA_CARRO INT)
BEGIN
    INSERT INTO CARRO(ID_CARRO, MODELO, PLACA, FK_MARCA_CARRO)
        VALUES (NULL, P_MODELO, P_PLACA, P_FK_MARCA_CARRO);
END;

CREATE PROCEDURE INSERT_COR(P_NOME VARCHAR(20))
BEGIN
    INSERT INTO COR(ID_COR, NOME)
        VALUES (NULL, P_NOME);
END;

CREATE PROCEDURE INSERT_TELEFONE(P_TIPO ENUM('RES', 'CEL'), P_NUMERO VARCHAR(12), P_FK_CLIENTE_TELEFONE INT)
BEGIN
    INSERT INTO TELEFONE(ID_TELEFONE, TIPO, NUMERO, FK_CLIENTE_TELEFONE)
        VALUES (NULL, P_TIPO, P_NUMERO, P_FK_CLIENTE_CARRO);
END;

CREATE PROCEDURE INSERT_CARRO_COR(P_FK_CARRO INT, P_FK_COR INT)
BEGIN
    INSERT INTO CARRO_COR(FK_CARRO, FK_COR)
        VALUES (P_FK_CARRO, P_FK_COR);
END$

CREATE PROCEDURE DELETE_CARRO(P_PLACA CHAR(6), P_ID_CARRO INT)
BEGIN
    DELETE FROM CARRO_COR WHERE FK_CARRO = P_ID_CARRO;
    DELETE FROM CLIENTE WHERE P_ID_CARRO = FK_CARRO_CLIENTE;
    DELETE FROM CARRO WHERE PLACA = P_PLACA;
END;$

CREATE PROCEDURE RELATORIO_GERAL()
BEGIN
    SELECT * FROM CONTADOR_CLIENTE;
    SELECT * FROM CONTADOR_MARCA;
    SELECT * FROM CONTADOR_COR;
END;$

/* INSERT */
CALL INSERT_CLIENTE('REGINATO', '12345678901', 1);
CALL INSERT_CLIENTE('BERNARDO', '12345678902', 2);
CALL INSERT_CLIENTE('GIULIANNA', '12345678903', 3);
CALL INSERT_CLIENTE('GABRIEL', '12345678904', 4);
CALL INSERT_CLIENTE('JULIA', '12345678905', 5)$
CALL INSERT_CLIENTE('GRAÇA', '12345678906', 7)$

CALL INSERT_MARCA('CHEVROLET');
CALL INSERT_MARCA('FIAT');
CALL INSERT_MARCA('HONDA');
CALL INSERT_MARCA('TOYOTA');
CALL INSERT_MARCA('BMW')$

CALL INSERT_COR('LARANJA');
CALL INSERT_COR('ROXO');
CALL INSERT_COR('AZUL');
CALL INSERT_COR('VERDE');
CALL INSERT_COR('AMARELO');
CALL INSERT_COR('VERMELHO')$

CALL INSERT_CARRO('CIVIC', 'KXL312', 3);
CALL INSERT_CARRO('CORSA', 'OLA123', 1);
CALL INSERT_CARRO('UNO', 'ABC654', 2);
CALL INSERT_CARRO('X1', 'GYMSS2', 5);
CALL INSERT_CARRO('COROLLA', 'LKJ123', 4)
CALL INSERT_CARRO('GOL', 'LKJ124', 6)$

CALL INSERT_CARRO_COR(1, 2);
CALL INSERT_CARRO_COR(1, 3);
CALL INSERT_CARRO_COR(3, 5);
CALL INSERT_CARRO_COR(4, 1);
CALL INSERT_CARRO_COR(5, 6);
CALL INSERT_CARRO_COR(5, 2);
CALL INSERT_CARRO_COR(2, 4);
CALL INSERT_CARRO_COR(7, 3);
CALL INSERT_CARRO_COR(7, 6);$

/* DELETE */
CALL DELETE_CARRO('LKJ124', 7);

/* SELECT */
SELECT CL.NOME AS CLIENTE, CL.CPF, CA.MODELO, CA.PLACA FROM CLIENTE CL
INNER JOIN CARRO CA
ON CL.FK_CARRO_CLIENTE = CA.ID_CARRO;$

SELECT CA.MODELO, CA.PLACA, C.NOME FROM CARRO CA
INNER JOIN COR C
INNER JOIN CARRO_COR CC
ON ((CA.ID_CARRO = CC.FK_CARRO) AND (C.ID_COR = CC.FK_COR));$

SELECT * FROM RELATORIO_GERAL;$

SELECT * FROM RELATORIO_CLIENTE_TELEFONE;$

SELECT * FROM CONTADOR_CLIENTE;$

SELECT * FROM CONTADOR_MARCA;$

SELECT * FROM CONTADOR_COR;$

CALL RELATORIO_GERAL();

/* VIEW */
CREATE VIEW RELATORIO_GERAL AS 
    SELECT CL.NOME AS CLIENTE, CL.CPF, M.NOME AS MARCA, CA.MODELO, CA.PLACA, C.NOME AS COR
    FROM CLIENTE CL
    INNER JOIN CARRO CA
        ON (CL.FK_CARRO_CLIENTE = CA.ID_CARRO)
    INNER JOIN COR C
    INNER JOIN CARRO_COR CC
        ON ((CA.ID_CARRO = CC.FK_CARRO) AND (C.ID_COR = CC.FK_COR))
    INNER JOIN MARCA M
        ON (M.ID_MARCA = CA.FK_MARCA_CARRO)
    ORDER BY CL.NOME ASC;$

CREATE VIEW RELATORIO_CLIENTE_TELEFONE AS
      SELECT CL.NOME AS CLIENTE, CL.CPF, T.TIPO, T.NUMERO
      FROM CLIENTE CL
      INNER JOIN TELEFONE T
        ON T.FK_CLIENTE_TELEFONE = CL.ID_CLIENTE;$

CREATE VIEW CONTADOR_CLIENTE AS
    SELECT COUNT(*)
    FROM CLIENTE;$

CREATE VIEW CONTADOR_MARCA AS
    SELECT NOME, COUNT(*)
    FROM MARCA
    GROUP BY ID_MARCA;$

CREATE VIEW CONTADOR_COR AS
    SELECT C.NOME, COUNT(CC.FK_COR)
    FROM CARRO_COR CC
    INNER JOIN COR C
    ON C.ID_COR = CC.FK_COR
    GROUP BY C.ID_COR;$

/* DROP  VIEW */
DROP VIEW RELATORIO_GERAL;$
DROP VIEW RELATORIO_CLIENTE_TELEFONE;$

/* DROP PROCEDURE */
DROP PROCEDURE INSERT_CARRO;$
DROP PROCEDURE INSERT_COR;$
DROP PROCEDURE INSERT_MARCA;$
DROP PROCEDURE INSERT_CLIENTE;$
DROP PROCEDURE INSERT_CARRO_COR;$

/* DROP TABLE */
DROP TABLE CARRO_COR;$
DROP TABLE CARRO;$
DROP TABLE COR;$
DROP TABLE TELEFONE;$
DROP TABLE CLIENTE;$
DROP TABLE MARCA;$

/* DROP DATABASE */
DROP DATABASE PROJETO_OFICINA;$