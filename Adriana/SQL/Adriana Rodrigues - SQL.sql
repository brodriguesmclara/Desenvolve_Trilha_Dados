/* BANCO DE DADOS */
CREATE DATABASE biblioteca;

CREATE TABLE editora(
	IdEditora SERIAL PRIMARY KEY NOT NULL,
	Nome VARCHAR(50) NOT NULL UNIQUE
);


INSERT INTO editora (Nome) VALUES 
	('Bookman'), ('Edgar Blusher'), ('Nova Terra'), ('Brasport');

SELECT * FROM editora;

CREATE TABLE categoria(
	IdCategoria SERIAL PRIMARY KEY NOT NULL,
	Nome VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO Categoria (Nome) VALUES 
	('Banco de Dados'), ('HTML'), ('Java'), ('PHP');

SELECT * FROM categoria;

CREATE TABLE autor(
	IdAutor SERIAL PRIMARY KEY NOT NULL,
	Nome VARCHAR(100) NOT NULL
);

INSERT INTO autor(Nome) VALUES 
	('Waldemar Setzer'), 
	('Flávio Soares'), 
	('John Watson'), 
	('Rui Rossi dos Santos'), 
	('Antonio Pereira de Resende'), 
	('Claudiney Calixto Lima'), 
	('Evandro Carlos Teruel'), 
	('Ian Graham'), 
	('Fabrício Xavier'), 
	('Pablo Dalloglio');

SELECT * FROM autor;

CREATE TABLE livro(
	IdLivro SERIAL PRIMARY KEY NOT NULL,
	IdEditora INTEGER NOT NULL REFERENCES editora(IdEditora),
	IdCategoria INTEGER NOT NULL REFERENCES categoria(IdCategoria),
	Nome VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO livro (IdEditora, IdCategoria, Nome) VALUES 
	(2, 1, 'Banco de Dados - 1 Edição'), 
	(1, 1, 'Oracle DataBase 11G Administração'), 
	(3, 3, 'Programação de Computadores em Java'), 
	(4, 3, 'Programação Orientada a Aspectos em Java'), 
	(4,2, 'HTML5 – Guia Prático'), 
	(3,2, 'XHTML: Guia de Referência para Desenvolvimento na Web'), 
	(1,4, 'PHP para Desenvolvimento Profissional') , 
	(2,4, 'PHP com Programação Orientada a Objetos');

SELECT * FROM livro;

CREATE TABLE livro_autor (
	IdLivro INTEGER NOT NULL REFERENCES livro(IdLivro),
	IdAutor INTEGER NOT NULL REFERENCES autor(IdAutor),
	PRIMARY KEY (IdLivro, IdAutor)
);

INSERT INTO livro_autor VALUES 
	(1,1), (1, 2), (2, 3), (3,4), (4,5), (4,6), (5,7), (6,8), (7,9), (8,10);

SELECT * FROM livro_autor;

CREATE TABLE aluno (
	IdAluno SERIAL PRIMARY KEY NOT NULL,
	nome VARCHAR(100) NOT NULL
);

INSERT INTO aluno (nome) VALUES 
('Mario'), ('João'), ('Paulo'), ('Pedro'), ('Maria');

SELECT * FROM aluno;

CREATE TABLE emprestimo(
	IdEmprestimo SERIAL PRIMARY KEY NOT NULL,
	IdAluno INTEGER NOT NULL REFERENCES aluno(IdAluno),
	Data_Emprestimo DATE NOT NULL,
	Data_Devolucao DATE NOT NULL,
	Valor NUMERIC(10,2) NOT NULL,
	Devolvido CHAR(1) NOT NULL
);

INSERT INTO emprestimo(
	IdAluno, Data_Emprestimo, Data_Devolucao, Valor, Devolvido) VALUES
	(1, '2023-05-02', '2023-05-12', 10, 'S'),
	(1, '2023-04-23', '2023-05-03', 5, 'N'),
	(2, '2023-05-10', '2023-05-20', 12, 'N'),
	(3, '2023-05-10', '2023-05-20', 8, 'S'),
	(4, '2023-05-05', '2023-05-15', 15, 'N'),
	(4, '2023-05-07', '2023-05-17', 20, 'S'),
	(4, '2023-05-08', '2023-05-18', 5, 'S');

SELECT * FROM emprestimo;

CREATE TABLE emprestimo_livro (	
	IdEmprestimo INTEGER NOT NULL REFERENCES emprestimo(IdEmprestimo),
	IdLivro INTEGER NOT NULL REFERENCES livro(IdLivro),
	PRIMARY KEY (IdEmprestimo, IdLivro)
);

INSERT INTO emprestimo_livro(IdEmprestimo, IdLivro) VALUES
	(1,1), (2,4), (2, 3), (3,2), (3,7), (4, 5), (5, 4), (6,6), (6,1), (7,8);

SELECT * FROM emprestimo_livro;

CREATE INDEX ind_emprestimos ON emprestimo(IdEmprestimo);
CREATE INDEX ind_devol_emprestimo ON emprestimo(Data_Devolucao);

/* CONSULTAS SIMPLES */
SELECT Nome FROM autor
	ORDER BY Nome;

SELECT Nome FROM aluno
	WHERE Nome LIKE 'P%'
	ORDER BY Nome;

SELECT livro.Nome FROM livro
	JOIN categoria ON livro.IdCategoria = categoria.IdCategoria
	WHERE categoria.Nome IN ('Banco de Dados', 'Java')
	ORDER BY livro.Nome;
/* ou */
SELECT Nome FROM livro
	WHERE Idcategoria IN (1,3)
	ORDER BY Nome;

SELECT livro.Nome FROM livro
	JOIN editora ON livro.IdEditora = editora.IdEditora
	WHERE editora.Nome = 'Bookman'
	ORDER BY livro.Nome;

SELECT * FROM emprestimo
	WHERE Data_Emprestimo BETWEEN '2023-05-05' AND '2023-05-10'
	ORDER BY Data_Emprestimo;

SELECT * FROM emprestimo
	WHERE Data_Emprestimo NOT BETWEEN '2023-05-05' AND '2023-05-10'
	ORDER BY Data_Emprestimo;
	
SELECT * FROM emprestimo
	WHERE Devolvido = 'S'
	ORDER BY Data_Devolucao;
	
/* CONSULTAS COM AGRUPAMENTO SIMPLES */
SELECT COUNT(*) AS QuantidadeLivros
FROM livro;

SELECT SUM(Valor) AS SomaValorEmprestimos
FROM emprestimo;

SELECT ROUND(AVG(Valor),2) AS MediaValorEmprestimos
FROM emprestimo;

SELECT MAX(Valor) AS MaiorValorEmprestimo
FROM emprestimo;

SELECT MIN(Valor) AS MenorValorEmprestimo
FROM emprestimo;

SELECT SUM(Valor) AS SomaValorEmprestimos
	FROM emprestimo
	WHERE Data_Emprestimo BETWEEN '2023-05-05' AND '2023-05-10';

SELECT COUNT(*) AS QtdEmprestimos
	FROM emprestimo
	WHERE Data_Emprestimo BETWEEN '2023-05-01' AND '2023-05-05';

/* CONSULTAS COM JOIN */
CREATE VIEW vw_Livro AS
SELECT livro.Nome AS Livro, categoria.Nome AS Categoria, editora.Nome AS Editora 
	FROM livro
	JOIN categoria ON livro.IdCategoria = categoria.IdCategoria 
	JOIN editora ON livro.IdEditora = editora.IdEditora
	ORDER BY livro.Nome;

SELECT * FROM vw_Livro;

CREATE VIEW vw_Livro_Autor AS
SELECT livro.Nome AS Livro, autor.Nome AS Autor FROM livro_autor
	JOIN livro ON livro_autor.IdLivro = livro.IdLivro
	JOIN autor ON livro_autor.IdAutor = autor.IdAutor
	ORDER BY livro.Nome;
	
SELECT * FROM vw_Livro_Autor;

SELECT livro.Nome AS Livro FROM livro_autor
	JOIN livro ON livro_autor.IdLivro = livro.IdLivro
	JOIN autor ON livro_autor.IdAutor = autor.IdAutor
	WHERE autor.Nome = 'Ian Graham'
	ORDER BY livro.Nome;

SELECT aluno.Nome, emprestimo.Data_Emprestimo, emprestimo.Data_Devolucao 
	FROM emprestimo
	JOIN aluno ON emprestimo.IdAluno = aluno.IdAluno
	ORDER BY aluno.Nome;

SELECT DISTINCT livro.Nome FROM emprestimo_livro
	JOIN livro ON emprestimo_livro.IdLivro = livro.IdLivro
	JOIN emprestimo ON emprestimo_livro.IdEmprestimo = emprestimo.IdEmprestimo
	ORDER BY livro.Nome;

/* CONSULTAS COM AGRUPAMENTO + JOIN */
SELECT editora.Nome AS Editora, COUNT(livro.IdEditora) AS QuantidadeLivros
	FROM livro
	JOIN editora ON livro.IdEditora = editora.IdEditora
	GROUP BY editora.Nome;

SELECT categoria.Nome AS Categoria, COUNT(livro.IdCategoria) AS QuantidadeLivros
	FROM livro
	JOIN categoria ON livro.IdCategoria = categoria.IdCategoria
	GROUP BY categoria.Nome;

SELECT autor.Nome AS Autor, COUNT(livro_autor.IdAutor) AS QuantidadeLivros
	FROM livro_autor
	JOIN autor ON autor.IdAutor = livro_autor.IdAutor
	GROUP BY autor.Nome;

SELECT aluno.Nome, SUM(emprestimo.Valor) AS QuantidadeEmprestimos 
	FROM emprestimo
	JOIN emprestimo_livro ON emprestimo_livro.IdEmprestimo = emprestimo.IdEmprestimo
	JOIN aluno ON emprestimo.IdAluno = aluno.IdAluno
	GROUP BY aluno.Nome
	ORDER BY aluno.Nome;
	
SELECT aluno.Nome, SUM(emprestimo.Valor) AS QuantidadeEmprestimos 
	FROM emprestimo
	JOIN emprestimo_livro ON emprestimo_livro.IdEmprestimo = emprestimo.IdEmprestimo
	JOIN aluno ON emprestimo.IdAluno = aluno.IdAluno
	GROUP BY aluno.Nome
	HAVING SUM(emprestimo.Valor)  > 7
	ORDER BY aluno.Nome;

/* CONSULTAS COMANDOS DIVERSOS */
SELECT UPPER(nome) FROM aluno
	ORDER BY nome;
	
SELECT *
	FROM emprestimo
	WHERE EXTRACT(MONTH FROM Data_Emprestimo) = 4 AND 
	      EXTRACT(YEAR FROM Data_Emprestimo) = 2023;

SELECT *,
       CASE 
           WHEN Devolvido = 'S' THEN 'Devolução completa'
           ELSE 'Em atraso'
       END AS StatusDevolucao
FROM emprestimo;

SELECT SUBSTRING(Nome, 5, 6) AS ParteDoNome
FROM autor;

SELECT CONCAT('R$', Valor),
       CASE 
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 1 THEN 'Janeiro'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 2 THEN 'Fevereiro'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 3 THEN 'Março'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 4 THEN 'Abril'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 5 THEN 'Maio'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 6 THEN 'Junho'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 7 THEN 'Julho'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 8 THEN 'Agosto'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 9 THEN 'Setembro'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 10 THEN 'Outubro'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 11 THEN 'Novembro'
           WHEN EXTRACT(MONTH FROM Data_Emprestimo) = 12 THEN 'Dezembro'
       END AS Mes
FROM emprestimo;

/* SUBCONSULTAS */
SELECT Data_Emprestimo, Valor
	FROM emprestimo
	WHERE Valor > (SELECT AVG(Valor) FROM emprestimo);

SELECT Data_Emprestimo, Valor
	FROM emprestimo
	WHERE IdEmprestimo IN (
		SELECT IdEmprestimo
		FROM emprestimo_livro
		GROUP BY IdEmprestimo
		HAVING COUNT(IdLivro) > 1);	

SELECT Data_Emprestimo, Valor
	FROM emprestimo
	WHERE IdEmprestimo IN (
		SELECT IdEmprestimo
		FROM emprestimo_livro
		GROUP BY IdEmprestimo
		HAVING COUNT(IdLivro) > 1);	
		
SELECT Data_Emprestimo, Valor
	FROM emprestimo
	WHERE Valor < (SELECT SUM(Valor) FROM emprestimo);
