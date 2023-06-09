CREATE DATABASE biblioteca;

USE biblioteca;

CREATE TABLE Acervo (
    ID_acervo INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT -- Define o ID_acervo como inteiro, chave primária, não nulo e com auto incremento
);

CREATE TABLE Bibliotecario (
    Credenciais INTEGER PRIMARY KEY NOT NULL, -- Define Credenciais como inteiro, chave primária e não nulo
    Senha VARCHAR(16) UNIQUE NOT NULL DEFAULT 'admin', -- Define Senha como varchar de até 8 caracteres, única, não nula e com valor padrão 'admin'
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
    Senha VARCHAR(16) UNIQUE NOT NULL, -- Define Senha como varchar de até 8 caracteres, único e não nulo
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

INSERT INTO acervo (ID_acervo)
VALUES 	(1),
		(2),
		(3),
		(4),
		(5);

INSERT INTO bibliotecario (Credenciais,Senha,Nome,fk_Acervo_ID_acervo)
VALUES 	(1234,87654321,"João Carlos",1),
		(4321,23984651,"Pedro Bueno",3),
        (8742,98234165,"Vinnicius Pedro",4),
        (9812,09128374,"Carla Fernanda",5),
        (2912,09127639,"Matias Vinnicius",2);

INSERT INTO aluno (RA,Nome,Telefone,CPF,E_mail,Data_nascimento,Senha,fk_Bibliotecario_Credenciais)
VALUES (323132740, 'João Silva', '(11) 91234-5678', '12345678900', 'joao.silva@gmail.com', '1987-03-15', 'P@ssw0rd', 2912),
    (323132620, 'Maria Santos', '(21) 98765-4321', '23456789011', 'maria.santos@outlook.com', '1992-07-22', 'Secur3ty', 4321),
    (323132825, 'Pedro Almeida', '(31) 99876-5432', '34567890122', 'pedro.almeida@gmail.com', '1985-11-05', 'MyP@ssw0rd', 2912),
    (323132219, 'Ana Costa',Null , '45678901233', 'ana.costa@gmail.com', '1990-09-18', 'Passw0rd!', 1234),
    (323132334, 'Lucas Pereira', '(51) 92345-6789', '56789012344', 'lucas.pereira@gmail.com', '1988-06-29', 'Str0ngP@ss', 1234),
    (323132913, 'Isabela Rodrigues', '(61) 94321-5678', '67890123455', 'isabela.rodrigues@outlook.com', '1995-04-11', '12345678', 2912),
    (323132415, 'Rafael Oliveira', '(71) 93215-8765', '78901234566', 'rafael.oliveira@hotmail.com', '1989-12-02', 'Qwerty12', 1234),
    (323132127, 'Juliana Martins', '(81) 98765-4321', '89012345677', Null, '1993-08-27', 'P@ssw0rd!', 8742),
    (323132539, 'Guilherme Souza', Null, '90123456788', 'guilherme.souza@gmail.com', '1986-01-08', 'Password123', 8742),
    (323132628, 'Larissa Ferreira', '(81) 97823-4567', '01234567899', 'larissa.ferreira@outlook.com', '1991-10-14', '98765432', 4321),
    (323132941, 'Marcos Mendes', '(11) 96547-2189', '21098765432', 'marcos.mendes@gmail.com', '1984-05-23', 'MySecret!', 9812),
    (323132803, 'Camila Castro', '(21) 99786-3452', '32109876543', 'camila.castro@yahoo.com', '1996-09-07', '123456789', 9812),
    (323132516, 'Gabriel Carvalho', '(31) 92456-7893', '43210987654', 'gabriel.carvalho@yahoo.com', '1983-02-12', 'LetMeIn!', 2912),
    (323132327, 'Vitória Gomes', '(41) 98723-4567', '54321098765', 'vitoria.gomes@hotmail.com', '1994-11-30', 'Hello123', 9812),
    (323132742, 'Leonardo Ribeiro', '(51) 96543-2187', '65432109876', Null, '1992-06-04', 'P@ssw0rd1', 9812),
    (323132621, 'Laura Lima', Null, '76543210987', 'laura.lima@gmail.com', '1987-12-09', 'Abcd1234', 4321),
    (323132937, 'Matheus Fernandes', '(71) 95678-5432', '87654321098', 'matheus.fernandes@outlook.com', '1993-03-25', 'Pa$$w0rd', 4321),
    (323132129, 'Leticia Neves', '(81) 94567-2189', '98765432109', 'leticia.neves@gmail.com', '1990-09-01', 'Passw0rd123', 2912);
    
INSERT INTO livro (Titulo,ID_livro,Autor,Editora,Data_publicacao,Genero,Quantidade,fk_Bibliotecario_Credenciais,fk_Acervo_ID_acervo)
VALUES	('O Segredo das Sombras', 1, 'John Smith', 'Editora X', '2022-01-01', 'Aventura', 5, 1234, 1),
		('Aventuras na Terra Proibida', 2, 'Alice Johnson', 'Editora Y', '2022-02-02', 'Ficção Científica', 8, 2912, 2),
		('O Mistério do Passado', 3, 'Michael Brown', 'Editora Z', '2022-03-03', 'Mistério', 2, 4321, 3),
		('Romance Proibido', 4, 'Emily Davis', 'Editora W', '2022-04-04', 'Romance', 10, 8742, 4),
		('Aventuras Fantásticas', 5, 'Daniel Moore', 'Editora V', '2022-05-05', 'Fantasia', 6, 9812, 5),
		('O Segredo do Tesouro Perdido', 6, 'Sophia Taylor', 'Editora Q', '2022-06-06', 'Aventura', 3, 1234, 1),
		('Intrigas Políticas', 7, 'Benjamin Wilson', 'Editora R', '2022-07-07', 'Suspense', 7, 2912, 2),
		('O Mistério do Labirinto', 8, 'Olivia Harris', 'Editora S', '2022-08-08', 'Mistério', 4, 4321, 3),
		('O Amor Proibido', 9, 'Lucas Anderson', 'Editora T', '2022-09-09', 'Romance', 2, 8742, 4),
		('Viagem à Fantasia', 10, 'Isabella Thompson', 'Editora U', '2022-10-10', 'Fantasia', 9, 9812, 5),
		('Aventuras nas Profundezas', 11, 'Thomas Johnson', 'Editora X', '2022-11-11', 'Aventura', 6, 1234, 1),
		('O Mistério do Planeta Desconhecido', 12, 'Sophia Miller', 'Editora Y', '2022-12-12', 'Ficção Científica', 3, 2912, 2),
		('Segredos do Passado', 13, 'Michael Johnson', 'Editora Z', '2023-01-01', 'Mistério', 8, 4321, 3),
		('Amor e Destino', 14, 'Emily White', 'Editora W', '2023-02-02', 'Romance', 5, 8742, 4),
		('A Magia dos Sonhos', 15, 'Daniel Wilson', 'Editora V', '2023-03-03', 'Fantasia', 2, 9812, 5),
		('O Segredo do Tempo', 16, 'Olivia Taylor', 'Editora Q', '2023-04-04', 'Mistério', 4, 1234, 1),
		('O Enigma do Passado', 17, 'Gabriel Smith', 'Editora X', '2023-05-05', 'Aventura', 6, 2912, 2),
		('Aventuras Fantásticas 2', 18, 'Daniel Moore', 'Editora Y', '2023-06-06', 'Fantasia', 3, 4321, 3),
		('O Mistério do Labirinto 2', 19, 'Olivia Harris', 'Editora Z', '2023-07-07', 'Mistério', 7, 8742, 4),
		('O Segredo das Sombras 2', 20, 'John Smith', 'Editora W', '2023-08-08', 'Suspense', 4, 9812, 5),
		('Romance Proibido 2', 21, 'Emily Davis', 'Editora V', '2023-09-09', 'Romance', 2, 1234, 1),
		('Aventuras na Terra Proibida 2', 22, 'Alice Johnson', 'Editora Q', '2023-10-10', 'Ficção Científica', 9, 2912, 2),
		('O Mistério do Passado 2', 23, 'Michael Brown', 'Editora R', '2023-11-11', 'Mistério', 6, 4321, 3),
		('Aventuras Fantásticas 3', 24, 'Daniel Moore', 'Editora S', '2023-12-12', 'Fantasia', 3, 8742, 4),
		('O Segredo do Tesouro Perdido 2', 25, 'Sophia Taylor', 'Editora T', '2024-01-01', 'Aventura', 8, 9812, 5),
		('Intrigas Políticas 2', 26, 'Benjamin Wilson', 'Editora U', '2024-02-02', 'Suspense', 5, 1234, 1),
		('O Mistério do Labirinto 3', 27, 'Olivia Harris', 'Editora X', '2024-03-03', 'Mistério', 7, 2912, 2),
		('O Amor Proibido 2', 28, 'Lucas Anderson', 'Editora Y', '2024-04-04', 'Romance', 3, 4321, 3),
		('Viagem à Fantasia 2', 29, 'Isabella Thompson', 'Editora Z', '2024-05-05', 'Fantasia', 9, 8742, 4),
		('O Enigma do Passado 2', 30, 'Gabriel Smith', 'Editora W', '2024-06-06', 'Mistério', 6, 9812, 5);

Insert into inventario_emprestimo (ID_inventario,fk_Livro_ID_livro,fk_Aluno_RA,Data_emprestimo,Renovacao,Data_devolucao)
VALUES	(1, 4, 323132127, '2023-05-30', 2, '2023-06-13'),
		(2, 10, 323132129, '2023-05-20', 1, '2023-05-27'),
		(3, 17, 323132219, '2023-05-28', 0, '2023-06-03'),
		(4, 1, 323132327, '2023-06-01', 3, '2023-06-22'),
		(5, 5, 323132334, '2023-05-29', 4, '2023-06-19'),
		(6, 9, 323132415, '2023-05-22', 5, '2023-06-26'),
		(7, 14, 323132516, '2023-05-25', 1, '2023-06-01'),
		(8, 3, 323132539, '2023-05-31', 2, '2023-06-14'),
		(9, 8, 323132620, '2023-05-26', 3, '2023-06-16'),
		(10, 2, 323132621, '2023-05-27', 0, '2023-06-02'),
		(11, 13, 323132628, '2023-05-23', 4, '2023-06-20'),
		(12, 6, 323132740, '2023-05-24', 5, '2023-06-28'),
		(13, 12, 323132742, '2023-05-21', 1, '2023-05-28'),
		(14, 16, 323132803, '2023-05-19', 2, '2023-06-02'),
		(15, 11, 323132825, '2023-05-18', 3, '2023-06-09'),
		(16, 7, 323132913, '2023-05-17', 0, '2023-05-31'),
		(17, 15, 323132937, '2023-05-16', 4, '2023-06-13'),
		(18, 18, 323132941, '2023-05-15', 5, '2023-06-20'),
		(19, 3, 323132127, '2023-05-31', 1, '2023-06-07'),
		(20, 9, 323132129, '2023-05-23', 2, '2023-06-06'),
		(21, 13, 323132219, '2023-05-19', 1, '2023-05-26'),
		(22, 6, 323132327, '2023-05-25', 2, '2023-06-07'),
		(23, 11, 323132334, '2023-05-24', 0, '2023-06-04'),
		(24, 5, 323132415, '2023-05-28', 3, '2023-06-18'),
		(25, 16, 323132516, '2023-05-22', 4, '2023-06-19'),
		(26, 10, 323132539, '2023-05-27', 5, '2023-07-04'),
		(27, 17, 323132620, '2023-05-21', 1, '2023-05-28'),
		(28, 9, 323132621, '2023-05-23', 2, '2023-06-06'),
		(29, 2, 323132628, '2023-05-29', 3, '2023-06-19'),
		(30, 3, 323132740, '2023-05-24', 0, '2023-06-02'),
		(31, 14, 323132742, '2023-05-25', 4, '2023-06-22'),
		(32, 1, 323132803, '2023-05-30', 5, '2023-06-27'),
		(33, 8, 323132825, '2023-05-26', 1, '2023-06-02'),
		(34, 7, 323132913, '2023-05-17', 2, '2023-05-31'),
		(35, 15, 323132937, '2023-05-16', 3, '2023-06-06'),
		(36, 12, 323132941, '2023-05-15', 0, '2023-05-29'),
		(37, 11, 323132127, '2023-05-22', 4, '2023-06-19'),
		(38, 6, 323132129, '2023-05-24', 5, '2023-07-01'),
		(39, 1, 323132219, '2023-05-20', 1, '2023-05-27'),
		(40, 4, 323132327, '2023-05-29', 2, '2023-06-11'),
		(41, 9, 323132334, '2023-05-23', 3, '2023-06-13'),
		(42, 17, 323132415, '2023-05-28', 0, '2023-06-04'),
		(43, 14, 323132516, '2023-05-25', 4, '2023-06-22'),
		(44, 2, 323132539, '2023-05-21', 5, '2023-06-28'),
		(45, 8, 323132620, '2023-05-26', 1, '2023-06-02'),
		(46, 10, 323132621, '2023-05-27', 2, '2023-06-09'),
		(47, 16, 323132628, '2023-05-19', 3, '2023-06-09'),
		(48, 12, 323132740, '2023-05-24', 0, '2023-06-02'),
		(49, 5, 323132742, '2023-05-28', 4, '2023-06-25'),
		(50, 13, 323132803, '2023-05-19', 5, '2023-07-06'),
		(51, 4, 323132825, '2023-05-18', 1, '2023-05-25'),
		(52, 17, 323132913, '2023-05-17', 2, '2023-05-31'),
		(53, 3, 323132937, '2023-05-16', 3, '2023-06-06'),
		(54, 7, 323132941, '2023-05-15', 0, '2023-05-29'),
		(55, 11, 323132127, '2023-05-22', 4, '2023-06-19'),
		(56, 2, 323132129, '2023-05-24', 5, '2023-07-01'),
		(57, 15, 323132219, '2023-05-20', 1, '2023-05-27'),
		(58, 9, 323132327, '2023-05-29', 2, '2023-06-11'),
		(59, 14, 323132334, '2023-05-23', 3, '2023-06-13'),
		(60, 10, 323132415, '2023-05-28', 0, '2023-06-04'),
		(61, 5, 323132516, '2023-05-25', 4, '2023-06-22'),
		(62, 1, 323132539, '2023-05-21', 5, '2023-06-28'),
		(63, 8, 323132620, '2023-05-26', 1, '2023-06-02'),
		(64, 13, 323132621, '2023-05-27', 2, '2023-06-09'),
		(65, 6, 323132628, '2023-05-19', 3, '2023-06-09'),
		(66, 12, 323132740, '2023-05-24', 0, '2023-06-02'),
		(67, 3, 323132742, '2023-05-28', 4, '2023-06-25'),
		(68, 16, 323132803, '2023-05-19', 5, '2023-07-06'),
		(69, 4, 323132825, '2023-05-18', 1, '2023-05-25'),
		(70, 17, 323132913, '2023-05-17', 2, '2023-05-31'),
		(71, 9, 323132937, '2023-05-16', 3, '2023-06-06');

INSERT INTO consulta (fk_Bibliotecario_Credenciais,fk_Inventario_Emprestimo_ID_inventario)
VALUES  (1234, 23),
		(2912, 50),
		(4321, 12),
		(8742, 66),
		(9812, 42),
		(1234, 5),
		(2912, 31),
		(4321, 18),
		(8742, 69),
		(9812, 2),
		(1234, 9),
		(2912, 57),
		(4321, 27),
		(8742, 61),
		(9812, 35),
		(1234, 14),
		(2912, 47),
		(4321, 3),
		(8742, 70),
		(9812, 1),
		(1234, 30),
		(2912, 63),
		(4321, 38),
		(8742, 54),
		(9812, 41),
		(1234, 7),
		(2912, 21),
		(4321, 15),
		(8742, 44),
		(9812, 10),
		(1234, 58),
		(2912, 39),
		(4321, 8),
		(8742, 65),
		(9812, 20),
		(1234, 49),
		(2912, 68),
		(4321, 56),
		(8742, 16),
		(9812, 33),
		(1234, 17),
		(2912, 26),
		(4321, 13),
		(8742, 71),
		(9812, 19),
		(1234, 55),
		(2912, 60),
		(4321, 24),
		(8742, 43),
		(9812, 36),
		(1234, 32),
		(2912, 51),
		(4321, 6),
		(8742, 67),
		(9812, 29);
        
INSERT INTO pesquisa (fk_Aluno_RA,fk_Livro_ID_livro)
VALUES (323132127, 10),
		(323132129, 5),
		(323132219, 28),
		(323132327, 2),
		(323132334, 19),
		(323132415, 12),
		(323132516, 23),
		(323132539, 7),
		(323132620, 15),
		(323132621, 3),
		(323132628, 27),
		(323132740, 8),
		(323132742, 16),
		(323132803, 21),
		(323132825, 1),
		(323132913, 26),
		(323132937, 18),
		(323132941, 30),
		(323132127, 11),
		(323132129, 6),
		(323132219, 25),
		(323132327, 9),
		(323132334, 20),
		(323132415, 14),
		(323132516, 24),
		(323132539, 4),
		(323132620, 13),
		(323132621, 22),
		(323132628, 29),
		(323132740, 17),
		(323132742, 3),
		(323132803, 10),
		(323132825, 2),
		(323132913, 28),
		(323132937, 19),
		(323132941, 5),
		(323132127, 7),
		(323132129, 16),
		(323132219, 21),
		(323132327, 1),
		(323132334, 26),
		(323132415, 18),
		(323132516, 30),
		(323132539, 8),
		(323132620, 15),
		(323132621, 9),
		(323132628, 25),
		(323132740, 14),
		(323132742, 23),
		(323132803, 6),
		(323132825, 11),
		(323132913, 27),
		(323132937, 22),
		(323132941, 3);