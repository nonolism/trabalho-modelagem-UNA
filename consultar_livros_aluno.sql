SELECT a.Nome,i.Data_emprestimo, i.Data_devolucao, l.Titulo -- Aqui nos selecionamos o Nome do aluno, qual foi a data em que o livro foi emprestado, quando foi(ou será) devolvido e qual o titulo do livro
FROM aluno AS a  -- Aqui especificamos a tabela aluno com a sigla a
JOIN inventario_emprestimo AS i ON a.RA = i.fk_Aluno_RA -- Especificamos a tabela inventario_emprestimo como i, e a juntamos em a caso o RA seja igual
JOIN livro AS l ON i.fk_Livro_ID_livro = l.ID_livro  -- Especificamos a tabela livro como l e a juntamos com i onde o ID do livro seja igual
WHERE a.RA=323132127; -- aqui nós limitamos a consulta para apenas quando o RA do aluno for um especifico, sendo necessário apenas trocar esse valor para alterar qual aluno sera consultado.