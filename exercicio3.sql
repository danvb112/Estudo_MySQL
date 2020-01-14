CREATE DATABASE exercicio3;

USE exercicio3;

CREATE TABLE instrutores 
(
	id INT UNSIGNED AUTO_INCREMENT,
    nome varchar(45) not null,
    telefone varchar(11) not null,
    PRIMARY KEY (id)
);


CREATE TABLE cursos 
(
	id INT UNSIGNED NOT NULL auto_increment,
    nome VARCHAR(45) NOT NULL,
    tipo VARCHAR (30) NOT NULL,
    preco int UNSIGNED not null,
    instrutor_id int unsigned default null,
    PRIMARY KEY (id),
    CONSTRAINT fk_cursos_instrutor FOREIGN KEY (instrutor_id) REFERENCES instrutores (id) 
    
);

CREATE TABLE alunos 
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    endereço VARCHAR(60) DEFAULT '',
    email VARCHAR(60) DEFAULT '',
    PRIMARY KEY (id)
);

ALTER TABLE alunos ADD COLUMN data_nascimento varchar(10);
ALTER TABLE alunos DROP COLUMN nascimento;

ALTER TABLE alunos CHANGE COLUMN data_nascimento nascimento DATE;

CREATE INDEX alunos ON alunos (nome);

ALTER TABLE instrutores ADD COLUMN email varchar(100);

CREATE INDEX instrutor ON cursos (instrutor_id);

ALTER TABLE instrutores ADD COLUMN email varchar(100);


INSERT INTO instrutores (nome, telefone) VALUES ("André Milani", 1111-1111);
INSERT INTO instrutores (nome, telefone) VALUES ("Carlos Tosin", 1212-1212);

INSERT INTO cursos (nome, tipo, preco, instrutor_id) VALUES ("Java Fundamentos", "Programação", 270, 2);
INSERT INTO cursos (nome, tipo, preco, instrutor_id) VALUES ("Java Avançado", "Programação", 330, 2);
INSERT INTO cursos (nome, tipo, preco, instrutor_id) VALUES ("SQL Completo", "Banco de dados", 170, 1);
INSERT INTO cursos (nome, tipo, preco, instrutor_id) VALUES ("Php Básico", "Programação", 270, 1);

INSERT INTO alunos (nome, endereço, email) VALUES ("José", "Rua XV de Novembro 72", "jose@softblue.com.br");
INSERT INTO alunos (nome, endereço, email) VALUES ("Wagner", "Av. Paulista", "wagner@softblue.com.br");
INSERT INTO alunos (nome, endereço, email) VALUES ("Emílio", "Rua Lajes 103, ap: 701", "emilio@softblue.com.br");
INSERT INTO alunos (nome, endereço, email) VALUES ("Cris", "Rua Tauney 22", "cris@softblue.com.br");
INSERT INTO alunos (nome, endereço, email) VALUES ("Regina", " Rua Salles 305", "regina@softblue.com.br");
INSERT INTO alunos (nome, endereço, email) VALUES ("Fernando", "Av. Central 30", "fernando@softblue.com.br");

SELECT nome, preco FROM cursos WHERE preco > 200 AND preco < 300;

SELECT * FROM alunos;

UPDATE alunos SET endereço = "Av. Brasil 778" WHERE id = 1;
UPDATE alunos SET email = "cristiano@softblue.com.br" WHERE nome = "Cris";

SET SQL_SAFE_UPDATES = 0;
SELECT * FROM cursos;
UPDATE cursos SET preco = ROUND(preco +(preco * 0.1), 2) WHERE preco < 300;
UPDATE cursos SET nome = "Php Fundamentos" WHERE id = 4;

SELECT nome, tipo FROM cursos;
SELECT * FROM instrutores;

SELECT A.nome, A.tipo, B.nome, B.telefone FROM cursos A JOIN instrutores B ON A.instrutor_id = B.id;

CREATE VIEW nome_preço AS SELECT nome, preco FROM cursos;

CREATE VIEW nomeCurso_tipoCurso_instrutor AS SELECT A.nome AS Curso, A.tipo, B.nome AS Instrutor FROM cursos A JOIN instrutores B ON A.instrutor_id = B.id;

SELECT * from nomeCurso_tipoCurso_instrutor;

SELECT * FROM cursos;
SELECT AVG(preco) FROM cursos;

SELECT MAX(preco) FROM cursos;
SELECT MIN(preco) FROM cursos;

SELECT instrutores.nome, COUNT(*) FROM cursos INNER JOIN instrutores ON cursos.instrutor_id = instrutores.id GROUP BY instrutores;

SELECT instrutores.nome, COUNT(*) FROM cursos INNER JOIN instrutores ON instrutores.id = cursos.instrutor_id GROUP BY nome;

SELECT * FROM alunos;
SELECT nome, endereço FROM alunos GROUP BY endereço HAVING endereço like 'Av%';

