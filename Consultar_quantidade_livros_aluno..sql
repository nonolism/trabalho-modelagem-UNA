SELECT a.Nome, COUNT(*) AS livros -- Aqui nos selecionamos o nome do aluno e criamos uma coluna para contar quantas vezes o RA do mesmo aparece na tabela de emprestimo(essa duplicidade significando quantos livros ele já pegou)
FROM aluno AS a  -- Aqui especificamos a tabela aluno com a sigla a
JOIN inventario_emprestimo AS i ON a.RA = i.fk_Aluno_RA -- Aqui especificamos a tabela inventario_emprestimo como i e a juntamos com a quando o RA for igual
GROUP BY fk_Aluno_RA;  -- Aqui nos agrupamos os resultados pelo RA, mostrando quantas vezes ele se repete