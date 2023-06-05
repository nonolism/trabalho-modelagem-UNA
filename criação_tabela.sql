CREATE TABLE Acervo (
    ID_acervo INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT -- Define o ID_acervo como inteiro, chave primária, não nulo e com auto incremento
);

CREATE TABLE Bibliotecario (
    Credenciais INTEGER PRIMARY KEY NOT NULL, -- Define Credenciais como inteiro, chave primária e não nulo
    Senha VARCHAR(8) UNIQUE NOT NULL DEFAULT 'admin', -- Define Senha como varchar de até 8 caracteres, única, não nula e com valor padrão 'admin'
    Nome VARCHAR(50) NOT NULL, -- Define Nome como varchar de até 50 caracteres, não nulo
    fk_Acervo_ID_acervo INTEGER,
    FOREIGN KEY (fk_Acervo_ID_acervo) REFERENCES Acervo (ID_acervo) ON DELETE RESTRICT -- Cria a chave estrangeira fk_Acervo_ID_acervo que referencia a tabela Acervo(ID_acervo) com ação de restrição no delete
);

CREATE TABLE Livro (
    Titulo VARCHAR(100) NOT NULL, -- Define Titulo como varchar de até 100 caracteres, não nulo
    ID_livro INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT, -- Define ID_livro como inteiro, chave primária, não nulo e com auto incremento
    Autor VARCHAR(100) NOT NULL, -- Define Autor como varchar de até 100 caracteres, não nulo
    Editora VARCHAR(100) NOT NULL, -- Define Editora como varchar de até 100 caracteres, não nulo
    Data_publicacao DATE NOT NULL, -- Define Data_publicacao como do tipo DATE, não nulo
    Genero VARCHAR(50) NOT NULL, -- Define Genero como varchar de até 50 caracteres, não nulo
    Quantidade INTEGER NOT NULL DEFAULT '1', -- Define Quantidade como inteiro, não nulo e com valor padrão '1'
    fk_Bibliotecario_Credenciais INTEGER,
    fk_Acervo_ID_acervo INTEGER,
    FOREIGN KEY (fk_Bibliotecario_Credenciais) REFERENCES Bibliotecario (Credenciais) ON DELETE CASCADE, -- Cria a chave estrangeira fk_Bibliotecario_Credenciais que referencia a tabela Bibliotecario(Credenciais) com ação de cascata no delete
    FOREIGN KEY (fk_Acervo_ID_acervo) REFERENCES Acervo (ID_acervo) ON DELETE CASCADE -- Cria a chave estrangeira fk_Acervo_ID_acervo que referencia a tabela Acervo(ID_acervo) com ação de cascata no delete
);

CREATE TABLE Aluno (
    RA INTEGER PRIMARY KEY NOT NULL, -- Define RA como inteiro, chave primária e não nulo
    Nome VARCHAR(50) NOT NULL, -- Define Nome como varchar de até 50 caracteres, não nulo
    Telefone VARCHAR(20), -- Define Telefone como varchar de até 20 caracteres
    CPF VARCHAR(11) UNIQUE NOT NULL, -- Define CPF como varchar de até 11 caracteres, único e não nulo
    E_mail VARCHAR(100) UNIQUE, -- Define E_mail como varchar de até 100 caracteres, único
    Data_nascimento DATE NOT NULL, -- Define Data_nascimento como do tipo DATE, não nulo
    Senha VARCHAR(8) UNIQUE NOT NULL, -- Define Senha como varchar de até 8 caracteres, único e não nulo
    fk_Bibliotecario_Credenciais INTEGER,
    FOREIGN KEY (fk_Bibliotecario_Credenciais) REFERENCES Bibliotecario (Credenciais) ON DELETE CASCADE -- Cria a chave estrangeira fk_Bibliotecario_Credenciais que referencia a tabela Bibliotecario(Credenciais) com ação de cascata no delete
);

CREATE TABLE Inventario_Emprestimo (
    ID_inventario INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT, -- Define ID_inventario como inteiro, chave primária, não nulo e com auto incremento
    fk_Livro_ID_livro INTEGER,
    fk_Aluno_RA INTEGER,
    Data_emprestimo DATE DEFAULT(CURRENT_DATE), -- Define Data_emprestimo como do tipo DATE, com valor padrão igual à data atual
    Renovacao INTEGER,
    Data_devolucao DATE DEFAULT(CURRENT_DATE + INTERVAL '7' DAY), -- Define Data_devolucao como do tipo DATE, com valor padrão igual à data atual + 7 dias
    FOREIGN KEY (fk_Livro_ID_livro) REFERENCES Livro (ID_livro),
    FOREIGN KEY (fk_Aluno_RA) REFERENCES Aluno (RA)
);

CREATE TABLE Consulta (
    fk_Bibliotecario_Credenciais INTEGER,
    fk_Inventario_Emprestimo_ID_inventario INTEGER,
    FOREIGN KEY (fk_Bibliotecario_Credenciais) REFERENCES Bibliotecario (Credenciais) ON DELETE SET NULL, -- Cria a chave estrangeira fk_Bibliotecario_Credenciais que referencia a tabela Bibliotecario(Credenciais) com ação de definir NULL no delete
    FOREIGN KEY (fk_Inventario_Emprestimo_ID_inventario) REFERENCES Inventario_Emprestimo (ID_inventario) ON DELETE SET NULL -- Cria a chave estrangeira fk_Inventario_Emprestimo_ID_inventario que referencia a tabela Inventario_Emprestimo(ID_inventario) com ação de definir NULL no delete
);

CREATE TABLE Pesquisa (
    fk_Aluno_RA INTEGER,
    fk_Livro_ID_livro INTEGER,
    FOREIGN KEY (fk_Aluno_RA) REFERENCES Aluno (RA) ON DELETE SET NULL, -- Cria a chave estrangeira fk_Aluno_RA que referencia a tabela Aluno(RA) com ação de definir NULL no delete
    FOREIGN KEY (fk_Livro_ID_livro) REFERENCES Livro (ID_livro) ON DELETE SET NULL -- Cria a chave estrangeira fk_Livro_ID_livro que referencia a tabela Livro(ID_livro) com ação de definir NULL no delete
);
