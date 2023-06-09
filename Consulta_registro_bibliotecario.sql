SELECT b.Nome, COUNT(*) AS Alunos -- Aqui nos selecionamos o nome do bibliotecario e criamos uma coluna para contar quantos alunos ele registrou
FROM bibliotecario AS b -- Aqui definimos a tabela bibliotecario como b
JOIN aluno AS a ON b.Credenciais = a.fk_Bibliotecario_Credenciais  -- aqui nos definimos a tabela alunos como a e a juntamos com b quando as credenciais forem iguais
GROUP BY b.Credenciais;  -- aqui nos agrupamos pelas credenciais, fazendo com que se retorne quantos alunos foram registrados por cada bibliotecario.