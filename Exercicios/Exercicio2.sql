use exercicio;

SELECT departamento, COUNT(*) FROM funcionarios GROUP BY departamento ORDER BY COUNT(*);

SELECT idFuncionario, nome, email, departamento, cargo from funcionarios WHERE departamento = 'Roupas' OR departamento = 'Filmes' ORDER BY departamento;

SELECT idFuncionario, nome, email, departamento, cargo from funcionarios WHERE departamento = 'Lar' OR departamento = 'Filmes' ORDER BY departamento;

SELECT idFuncionario, nome, email, departamento, cargo from funcionarios WHERE sexo = 'Masculino' OR departamento = 'Jardim';