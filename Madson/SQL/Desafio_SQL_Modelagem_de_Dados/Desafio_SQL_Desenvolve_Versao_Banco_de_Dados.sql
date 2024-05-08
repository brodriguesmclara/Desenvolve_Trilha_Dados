-- Criando um banco de dados chamado BIBLIOTECA.
CREATE DATABASE BIBLIOTECA;

-- Criando uma tabela chamada EDITORA.
CREATE TABLE EDITORA
(
    IdEditora SERIAL NOT NULL PRIMARY KEY,
    Nome VARCHAR NOT NULL UNIQUE
);

-- Inserindo dados na tabela EDITORA.
INSERT INTO EDITORA(Nome)
VALUES ('Bookman');
INSERT INTO EDITORA(Nome)
VALUES ('Edgard Blusher');
INSERT INTO EDITORA(Nome)
VALUES ('Nova Terra');
INSERT INTO EDITORA(Nome)
VALUES ('Brasport');

-- Criando uma tabela chamada CATEGORIA.
CREATE TABLE CATEGORIA
(
    IdCategoria SERIAL NOT NULL PRIMARY KEY,
    Nome VARCHAR NOT NULL UNIQUE
);

-- Inserindo dados na tabela CATEGORIA.
INSERT INTO CATEGORIA(Nome)
VALUES ('Banco de Dados');
INSERT INTO CATEGORIA(Nome)
VALUES ('HTML');
INSERT INTO CATEGORIA(Nome)
VALUES ('Java');
INSERT INTO CATEGORIA(Nome)
VALUES ('PHP');

-- Criando uma tabela chamada AUTOR.
CREATE TABLE AUTOR
(
    IdAutor SERIAL NOT NULL PRIMARY KEY,
    Nome VARCHAR NOT NULL
);

-- Inserindo dados na tabela AUTOR.
INSERT INTO AUTOR(Nome)
VALUES ('Waldemar Setzer');
INSERT INTO AUTOR(Nome)
VALUES ('Flávio Soares');
INSERT INTO AUTOR(Nome)
VALUES ('John Watson');
INSERT INTO AUTOR(Nome)
VALUES ('Rui Rossi dos Santos');
INSERT INTO AUTOR(Nome)
VALUES ('Antonio Pereira de Resende');
INSERT INTO AUTOR(Nome)
VALUES ('Claudiney Calixto Lima');
INSERT INTO AUTOR(Nome)
VALUES ('Evandro Carlos Teruel');
INSERT INTO AUTOR(Nome)
VALUES ('Ian Graham');
INSERT INTO AUTOR(Nome)
VALUES ('Fabrício Xavier');
INSERT INTO AUTOR(Nome)
VALUES ('Pablo Dalloglio');

-- Criando uma tabela chamada LIVRO.
CREATE TABLE LIVRO
(
    IdLivro SERIAL NOT NULL PRIMARY KEY,
    IdEditora INTEGER NOT NULL,
    FOREIGN KEY(IdEditora)
    REFERENCES EDITORA (IdEditora),
    IdCategoria INTEGER NOT NULL,
    FOREIGN KEY(IdCategoria)
    REFERENCES CATEGORIA (IdCategoria),
    Nome VARCHAR NOT NULL UNIQUE
);

-- Inserindo dados na tabela LIVRO.
INSERT INTO LIVRO(IdEditora, IdCategoria, Nome)
VALUES (2, 1, 'Banco de Dados – 1 Edição');
INSERT INTO LIVRO(IdEditora, IdCategoria, Nome)
VALUES (1, 1, 'Oracle DataBase 11G Administração');
INSERT INTO LIVRO(IdEditora, IdCategoria, Nome)
VALUES (3, 3, 'Programação de Computadores em Java');
INSERT INTO LIVRO(IdEditora, IdCategoria, Nome)
VALUES (4, 3, 'Programação Orientada a Aspectos em Java');
INSERT INTO LIVRO(IdEditora, IdCategoria, Nome)
VALUES (4, 2, 'HTML5 – Guia Prático');
INSERT INTO LIVRO(IdEditora, IdCategoria, Nome)
VALUES (3, 2, 'XHTML: Guia de Referência para Desenvolvimento na Web');
INSERT INTO LIVRO(IdEditora, IdCategoria, Nome)
VALUES (1, 4, 'PHP para Desenvolvimento Profissional');
INSERT INTO LIVRO(IdEditora, IdCategoria, Nome)
VALUES (2, 4, 'PHP com Programação Orientada a Objetos');

-- Criando uma tabela chamada LIVRO_AUTOR.
CREATE TABLE LIVRO_AUTOR
(
    IdLivro SERIAL NOT NULL,
    FOREIGN KEY(IdLivro)
    REFERENCES LIVRO (IdLivro),
    IdAutor INTEGER NOT NULL,
    FOREIGN KEY(IdAutor)
    REFERENCES AUTOR (IdAutor),
    PRIMARY KEY (IdLivro,IdAutor)
);

-- Inserindo dados na tabela LIVRO_AUTOR.
INSERT INTO LIVRO_AUTOR(IdLivro, IdAutor)
VALUES (1, 1);
INSERT INTO LIVRO_AUTOR(IdLivro, IdAutor)
VALUES (1, 2);
INSERT INTO LIVRO_AUTOR(IdLivro, IdAutor)
VALUES (2, 3);
INSERT INTO LIVRO_AUTOR(IdLivro, IdAutor)
VALUES (3, 4);
INSERT INTO LIVRO_AUTOR(IdLivro, IdAutor)
VALUES (4, 5);
INSERT INTO LIVRO_AUTOR(IdLivro, IdAutor)
VALUES (4, 6);
INSERT INTO LIVRO_AUTOR(IdLivro, IdAutor)
VALUES (5, 7);
INSERT INTO LIVRO_AUTOR(IdLivro, IdAutor)
VALUES (6, 8);
INSERT INTO LIVRO_AUTOR(IdLivro, IdAutor)
VALUES (7, 9);
INSERT INTO LIVRO_AUTOR(IdLivro, IdAutor)
VALUES (8, 10);

-- Criando uma tabela chamada EDITORA.
CREATE TABLE ALUNO
(
    IdAluno SERIAL NOT NULL PRIMARY KEY,
    Nome VARCHAR NOT NULL
);

-- Inserindo dados na tabela ALUNO.
INSERT INTO ALUNO(Nome)
VALUES ('Mario');
INSERT INTO ALUNO(Nome)
VALUES ('João');
INSERT INTO ALUNO(Nome)
VALUES ('Paulo');
INSERT INTO ALUNO(Nome)
VALUES ('Pedro');
INSERT INTO ALUNO(Nome)
VALUES ('Maria');

-- Criando uma tabela chamada EMPRESTIMO.
CREATE TABLE EMPRESTIMO
(
    IdEmprestimo SERIAL NOT NULL PRIMARY KEY,
    IdAluno INTEGER NOT NULL,
    FOREIGN KEY(IdAluno)
    REFERENCES ALUNO (IdAluno),
    Data_Emprestimo DATE NOT NULL DEFAULT CURRENT_DATE,
    Data_Devolucao DATE NOT NULL,
    Valor DECIMAL NOT NULL,
    Devolvido VARCHAR(1) NOT NULL
);

-- Inserindo dados na tabela EMPRESTIMO.
INSERT INTO EMPRESTIMO(IdAluno, Data_Emprestimo, Data_Devolucao, Valor, Devolvido)
VALUES (1, '02/05/2023', '12/05/2023', 10, 'S');
INSERT INTO EMPRESTIMO(IdAluno, Data_Emprestimo, Data_Devolucao, Valor, Devolvido)
VALUES (1, '23/04/2023', '03/05/2023', 5, 'N');
INSERT INTO EMPRESTIMO(IdAluno, Data_Emprestimo, Data_Devolucao, Valor, Devolvido)
VALUES (2, '10/05/2023', '20/05/2023', 12, 'N');
INSERT INTO EMPRESTIMO(IdAluno, Data_Emprestimo, Data_Devolucao, Valor, Devolvido)
VALUES (3, '10/05/2023', '20/05/2023', 8, 'S');
INSERT INTO EMPRESTIMO(IdAluno, Data_Emprestimo, Data_Devolucao, Valor, Devolvido)
VALUES (4, '05/05/2023', '15/05/2023', 15, 'N');
INSERT INTO EMPRESTIMO(IdAluno, Data_Emprestimo, Data_Devolucao, Valor, Devolvido)
VALUES (4, '07/05/2023', '17/05/2023', 20, 'S');
INSERT INTO EMPRESTIMO(IdAluno, Data_Emprestimo, Data_Devolucao, Valor, Devolvido)
VALUES (4, '08/05/2023', '18/05/2023', 5, 'S');

-- Criando uma tabela chamada EMPRESTIMO_LIVRO.
CREATE TABLE EMPRESTIMO_LIVRO
(
    IdEmprestimo INTEGER NOT NULL,
    FOREIGN KEY(IdEmprestimo)
    REFERENCES EMPRESTIMO (IdEmprestimo),
    IdLivro INTEGER NOT NULL,
    FOREIGN KEY(IdLivro)
    REFERENCES LIVRO (IdLivro),
    PRIMARY KEY (IdEmprestimo,IdLivro)
);

-- Inserindo dados na tabela EMPRESTIMO_LIVRO.
INSERT INTO EMPRESTIMO_LIVRO(IdEmprestimo, IdLivro)
VALUES (1, 1);
INSERT INTO EMPRESTIMO_LIVRO(IdEmprestimo, IdLivro)
VALUES (2, 4);
INSERT INTO EMPRESTIMO_LIVRO(IdEmprestimo, IdLivro)
VALUES (2, 3);
INSERT INTO EMPRESTIMO_LIVRO(IdEmprestimo, IdLivro)
VALUES (3, 2);
INSERT INTO EMPRESTIMO_LIVRO(IdEmprestimo, IdLivro)
VALUES (3, 7);
INSERT INTO EMPRESTIMO_LIVRO(IdEmprestimo, IdLivro)
VALUES (4, 5);
INSERT INTO EMPRESTIMO_LIVRO(IdEmprestimo, IdLivro)
VALUES (5, 4);
INSERT INTO EMPRESTIMO_LIVRO(IdEmprestimo, IdLivro)
VALUES (6, 6);
INSERT INTO EMPRESTIMO_LIVRO(IdEmprestimo, IdLivro)
VALUES (6, 1);
INSERT INTO EMPRESTIMO_LIVRO(IdEmprestimo, IdLivro)
VALUES (7, 8);

-- Criando índices.
CREATE INDEX idx_Emprestimo_Emprestimo
ON Emprestimo(Data_Emprestimo);
CREATE INDEX idx_Emprestimo_Devolucao
ON Emprestimo(Data_Devolucao);