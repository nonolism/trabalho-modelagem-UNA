SELECT ac.ID_acervo, SUM(l.quantidade) AS Total_livros  -- Aqui nos selecionamos o id do acervo e criamos uma coluna para contar a quantidade de livros que temos
FROM acervo AS ac -- Aqui especificamos a tabela acervo com a sigla ac
JOIN livro AS l ON ac.ID_acervo = l.fk_Acervo_ID_acervo -- Aqui juntamos a tabela livro como l a tabela ac onde o ID for igual
GROUP BY ac.ID_acervo; -- Aqui nos agrupamos pela Id do acervo, fazendo com que seja mostrado quantos livros estão em cada acervo.