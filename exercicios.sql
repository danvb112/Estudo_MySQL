CREATE DATABASE Exercicios;

use exercicios;

create table instrutores(
	id int unsigned not null auto_increment,
    nome varchar(45),
    telefone int unsigned not null,
    primary key (id)
);

create table cursos(
	id int unsigned auto_increment,
    instrutor_id int unsigned default null,
    nome varchar(45) not null,
    tipo varchar(45) not null,
    preco float unsigned not null,
    primary key (id),
    constraint fk_cursos_instrutores foreign key (instrutor_id) references instrutores(id)
);

create table alunos(
	id int unsigned auto_increment,
    nome varchar (45) not null,
    endereco varchar(70) not null,
    email varchar(70) not null,
    PRIMARY KEY (id) 
);

create table pedidos (
	id int unsigned auto_increment,
    aluno_id int unsigned default null,
    curso_id int unsigned default null,
    primary key(id),
    constraint fk_pedido_aluno foreign key (aluno_id) references alunos (id),
    constraint fk_prdido_curso foreign key (curso_id) references cursos (id),
    data_pedido date,
    hora_pedido time
);

/* Exercicio 3 */

ALTER TABLE alunos ADD data_nascimento VARCHAR (10);
ALTER TABLE alunos change data_nascimento  nascimento date;
CREATE INDEX exercicio ON alunos(nome);
ALTER TABLE instrutores ADD COLUMN email varchar (100);
CREATE INDEX instrutores ON cursos(instrutor_id);
ALTER TABLE instrutores DROP email;

/* Exercicio 4 */

INSERT INTO instrutores (nome, telefone) VALUES ('André Milani', 11111111);
INSERT INTO instrutores (nome, telefone) VALUES ('Carlos Tosin', 12121212);
INSERT INTO cursos (nome, tipo, preco, instrutor_id) VALUES ("Java Fundamentos", 'programação', 270, 2);
INSERT INTO cursos (nome, tipo, preco, instrutor_id) VALUES ('Java Avançado','Programação',330,2);
INSERT INTO cursos (nome, tipo, preco, instrutor_id) VALUES ('SQL Completo','Banco de dados',170,1);
INSERT INTO cursos (nome, tipo, preco, instrutor_id) VALUES ('Php Básico','Programação',270,1);
ALTER TABLE alunos DROP nascimento;
INSERT INTO alunos (nome, endereco, email) VALUES ('José','Rua XV de Novembro 72','jose@softblue.com.br');
INSERT INTO alunos (nome, endereco, email) VALUES ('Wagner','Av. Paulista','wagner@softblue.com.br');
INSERT INTO alunos (nome, endereco, email) VALUES ('Emílio','Rua Lajes 103, ap: 701','emilio@softblue.com.br');
INSERT INTO alunos (nome, endereco, email) VALUES ('Cris','Rua Tauney 22','cris@softblue.com.br');
INSERT INTO alunos (nome, endereco, email) VALUES ('Regina','Rua Salles 305','regina@softblue.com.br');
INSERT INTO alunos (nome, endereco, email) VALUES ('Fernando','Av. Central 30','fernando@softblue.com.br');
INSERT INTO pedidos (aluno_id, curso_id, data_pedido, hora_pedido) VALUES (2,2, '2010-04-15', '11:23:32');
INSERT INTO pedidos (aluno_id, curso_id, data_pedido, hora_pedido) VALUES (2,3, '2010-04-15', '14:36:21');
INSERT INTO pedidos (aluno_id, curso_id, data_pedido, hora_pedido) VALUES (3,2, '2010-04-16', '11:17:45');
INSERT INTO pedidos (aluno_id, curso_id, data_pedido, hora_pedido) VALUES (4,3, '2010-04-17', '14:27:22');
INSERT INTO pedidos (aluno_id, curso_id, data_pedido, hora_pedido) VALUES (5,4, '2010-04-18', '11:18:19');
INSERT INTO pedidos (aluno_id, curso_id, data_pedido, hora_pedido) VALUES (6,4, '2010-04-19', '13:47:35');
INSERT INTO pedidos (aluno_id, curso_id, data_pedido, hora_pedido) VALUES (6,5, '2010-04-20', '18:13:44');

SELECT * FROM alunos;
SELECT * FROM cursos;
SELECT nome FROM cursos;
SELECT nome, preco FROM cursos WHERE preco > 200;
SELECT nome, preco FROM cursos WHERE preco > 200 AND preco < 300;
SELECT * FROM pedidos WHERE data_pedido BETWEEN 20100415 AND 20100418;
SELECT * FROM pedidos WHERE data_pedido = 20100415;
UPDATE alunos SET endereco = 'Av. Brasil 778' WHERE nome = 'José';
UPDATE alunos SET email = 'cristiano@softblue.com.br' WHERE nome = 'Cris';
SET SQL_SAFE_UPDATES = 0;
UPDATE cursos SET preco = (preco + (preco * 0.10)) WHERE preco < 300;
UPDATE cursos SET nome = 'Php Fundamentos' WHERE nome = 'Php Básico';

/* Exercicios 5 */

SELECT nome, tipo FROM cursos;
SELECT A.nome, A.tipo, B.nome, B.telefone FROM cursos A JOIN instrutores B ON A.instrutor_id = B.id;
SELECT id as Codigo_pedido, data_pedido as "data", hora_pedido as hora, curso_id FROM pedidos;
SELECT A.id as Codigo_Pedido, A.data_Pedido as "data", A.hora_pedido as hora, B.nome FROM pedidos A JOIN cursos B ON A.curso_id = B.id;
SELECT A.id as Codigo_pedido, A.data_pedido as 'Data', A.hora_pedido as Hora, B.nome as Nome_aluno, C.nome AS Nome_curso FROM pedidos A JOIN alunos B ON A.aluno_id = B.id JOIN cursos C ON A.curso_id = C.id; 
CREATE VIEW Nome_preco_cursos AS SELECT nome, preco FROM cursos WHERE tipo = 'Programação';
CREATE VIEW Curso_tipo_instrutor AS SELECT A.nome As Titulo, A.tipo, B.nome FROM cursos A JOIN instrutores B ON A.instrutor_id = B.id;
CREATE VIEW Aluno_data_códigoPedido AS SELECT B.nome As Nome_aluno, A.data_pedido As 'Data do pedido', A.id As 'Código do pedido' FROM pedidos A JOIN alunos B ON A.aluno_id = B.id;

/* Exercicios 6 */
SELECT * FROM cursos;
SELECT * FROM pedidos;
select * from alunos;
SELECT A.nome, B.data_pedido FROM alunos A join pedidos B on A.id = B.aluno_id;

SELECT DISTINCT(A.nome) FROM alunos A JOIN pedidos B ON A.id = B.aluno_id;
SELECT A.nome FROM alunos A JOIN pedidos B ON A.id = B.aluno_id ORDER BY (B.data_pedido) ASC LIMIT 1;
SELECT A.nome FROM alunos A JOIN pedidos B ON A.id = B.aluno_id ORDER BY (B.data_pedido) DESC LIMIT 1;
SELECT DISTINCT (A.nome) FROM alunos A JOIN pedidos B ON A.id = B.aluno_id ORDER BY (B.data_pedido) ASC LIMIT 1 OFFSET 2;
SELECT COUNT(id) FROM pedidos; 
SELECT SUM(preco) FROM cursos JOIN pedidos ON cursos.id = pedidos.curso_id;
SELECT MAX(preco) FROM cursos;
SELECT MIN(preco) FROM cursos;
/*SELECT A.aluno_id, SUM(B.preco) FROM pedidos A JOIN cursos B GROUP BY A.aluno_id; */
SELECT A.nome, COUNT(B.instrutor_id) FROM instrutores A JOIN cursos B ON A.id = B.instrutor_id GROUP BY B.instrutor_id;
SELECT nome, endereco FROM alunos WHERE endereco LIKE "Av._%";
SELECT nome FROM cursos WHERE nome LIKE "Java_%";
SELECT nome FROM cursos WHERE tipo IN (SELECT tipo FROM cursos WHERE tipo = 'Programação');
/*SELECT nome FROM cursos WHERE EXISTS (SELECT tipo FROM cursos WHERE tipo = 'programação'); */






















