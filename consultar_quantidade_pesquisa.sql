SELECT l.Titulo, COUNT(*) AS total_pesquisas  -- aqui nos selecionamos o titulo do livro e criamos uma coluna para contar quantas vezes ele foi pesquisado
FROM livro AS l  -- Aqui especificamos a tabela livro com a sigla l
JOIN pesquisa AS p ON l.ID_livro = p.fk_Livro_ID_livro -- Aqui especificamos a tabela pesquisa com a sigla p e a juntamos com l quando o ID do livro for igual
GROUP BY l.Titulo  -- aqui nos agrupamos as pesquisas de acordo com o titulo do livro
ORDER BY total_pesquisas DESC;  -- Aqui nos ordenamos as pesquisas do maior para o menor
