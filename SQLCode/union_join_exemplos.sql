SELECT * FROM PESSOA_1 ORDER BY NOME, CPF, ENDERECO;

----

SELECT COUNT(CPF), NOME, CPF, ENDERECO FROM PESSOA_1 GROUP BY NOME, CPF, ENDERECO;

----

SELECT 
  		COUNT(CPF),
  		NOME AS jNOME, 
  		CPF AS jCPF, 
  		ENDERECO AS jENDERECO
  	FROM PESSOA_1
  	WHERE 
  		NOME IS NOT NULL
  		AND CPF IS NOT NULL
  		AND ENDERECO IS NOT NULL
  	GROUP BY
  		NOME,
  		CPF,
  		ENDERECO;

----

SELECT 
	NOME,
    CPF,
    ENDERECO 
FROM PESSOA_1 P
JOIN (
	SELECT 
  		COUNT(CPF),
  		NOME AS jNOME, 
  		CPF AS jCPF, 
  		ENDERECO AS jENDERECO
  	FROM PESSOA_1
  	WHERE 
  		NOME IS NOT NULL
  		AND CPF IS NOT NULL
  		AND ENDERECO IS NOT NULL
  	GROUP BY
  		NOME,
  		CPF,
  		ENDERECO
  	HAVING 
  		COUNT (CPF) > 1
 ) jP 
 ON jP.jNOME = P.NOME 
 AND jP.jCPF = P.CPF
 AND jP.jENDERECO = P.ENDERECO
 ORDER BY NOME;
 
 ----
 
SELECT 
	NOME,
    CPF,
    ENDERECO 
FROM PESSOA_1 P
JOIN (
	SELECT 
  		COUNT(CPF),
  		NOME AS jNOME, 
  		CPF AS jCPF, 
  		ENDERECO AS jENDERECO
  	FROM PESSOA_1
  	WHERE 
  		NOME IS NOT NULL
  		AND CPF IS NOT NULL
  		AND ENDERECO IS NOT NULL
  	GROUP BY
  		NOME,
  		CPF,
  		ENDERECO
  	HAVING 
  		COUNT (CPF) > 1
 ) jP 
 ON jP.jNOME = P.NOME 
 AND jP.jCPF = P.CPF
 AND jP.jENDERECO = P.ENDERECO
  
 UNION
  
 SELECT 
	NOME,
    CPF,
    ENDERECO
 FROM PESSOA_1
 WHERE NOME = 'OLOCOMEU';
 
 ----
 
SELECT 
	NOME,
    CPF,
    ENDERECO,
    ENDERECO || '-' || SEXO AS END_SEX
FROM PESSOA_1 P
JOIN (
	SELECT 
  		COUNT(CPF),
  		NOME AS jNOME, 
  		CPF AS jCPF, 
  		ENDERECO AS jENDERECO
  	FROM PESSOA_1
  	WHERE 
  		NOME IS NOT NULL
  		AND CPF IS NOT NULL
  		AND ENDERECO IS NOT NULL
  	GROUP BY
  		NOME,
  		CPF,
  		ENDERECO
  	HAVING 
  		COUNT (CPF) > 1
 ) jP 
 ON jP.jNOME = P.NOME 
 AND jP.jCPF = P.CPF
 AND jP.jENDERECO = P.ENDERECO
 ORDER BY NOME;
  			

DROP TABLE TESTE_1;
DROP TABLE TESTE_2;

CREATE TABLE TESTE_1(
	NUM1 INT(2),
  	NUM2 INT(2)
);

CREATE TABLE TESTE_2(
	NUM1 INT(2),
  	NUM2 INT(2)
);

INSERT INTO TESTE_1(NUM1, NUM2) VALUES (1, 2), (1, 2), (1, 2), (3, 1), (2, 2);
INSERT INTO TESTE_2(NUM1, NUM2) VALUES (4, 5), (4, 5), (4, 6), (6, 4), (2, 2);

SELECT * FROM TESTE_1;

SELECT * FROM TESTE_2;

SELECT * FROM TESTE_1
UNION
SELECT * FROM TESTE_2;