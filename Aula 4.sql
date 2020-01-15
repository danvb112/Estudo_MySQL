USE curso_sql;

INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (1, 'Fernando', 1400, 'TI' );
INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (2, 'Guilherme', 2500, 'Jurídico' );
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('Fábio', 1700, 'TI' );
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('José', 1800, 'Marketing' );
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('Isabela', 2200, 'Jurídico' );

SELECT * FROM funcionarios;
SELECT * FROM funcionarios WHERE salario > 2000;
SELECT * FROM funcionarios WHERE nome = 'José';
SELECT * FROM funcionarios WHERE id = 3;

UPDATE funcionarios SET salario = salario * 1.1 WHERE id = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE funcionarios SET salario = salario * 1.1;

UPDATE funcionarios SET salario = ROUND(salario * 1.1, 2);

DELETE FROM funcionarios WHERE id = 4;

INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (1, 'Carro', 'SB-0001');
INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (1, 'Carro', 'SB-0002');

UPDATE veiculos SET funcionario_id = 5 WHERE id = 2;

SELECT * FROM veiculos;

INSERT INTO salarios (faixa, inicio, fim) VALUES ('Analista Jr', 1000, 2000);
INSERT INTO salarios (faixa, inicio, fim) VALUES ('Analista Pleno', 2000, 4000);

SELECT nome AS "funcionario", salario FROM funcionarios f WHERE f.salario > 2000;

SELECT * FROM salarios;

SELECT * FROM funcionarios WHERE nome = 'Guilherme' UNION SELECT * FROM funcionarios WHERE id = 5;

SELECT * FROM funcionarios; 

SELECT COUNT(*) FROM funcionarios;
SELECT COUNT(*) FROM funcionarios WHERE salario > 1600;
SELECT COUNT(*) FROM funcionarios WHERE salario > 1600 AND departamento = 'Jurídico';

SELECT SUM(salario) FROM funcionarios;
SELECT SUM(salario) FROM funcionarios WHERE departamento = 'TI';

SELECT AVG(salario) FROM funcionarios;
SELECT AVG(salario) FROM funcionarios WHERE departamento = 'TI';

SELECT MAX(salario) FROM funcionarios;
SELECT MAX(salario) FROM funcionarios WHERE departamento = 'TI';

SELECT MIN(salario) FROM funcionarios;
SELECT MIN(salario) FROM funcionarios WHERE departamento = 'TI';

SELECT departamento FROM funcionarios;
SELECT DISTINCT(departamento) FROM funcionarios;
SELECT * FROM funcionarios ORDER BY nome;
SELECT * FROM funcionarios ORDER BY nome DESC;

SELECT * FROM funcionarios ORDER BY salario;
SELECT * FROM funcionarios ORDER BY departamento;
SELECT * FROM funcionarios ORDER BY departamento, salario DESC;

SELECT * FROM funcionarios LIMIT 2 OFFSET 1;
SELECT * FROM funcionarios LIMIT 1, 2;

SELECT departamento, AVG(SALARIO) FROM funcionarios GROUP BY departamento;
SELECT departamento, AVG(SALARIO) FROM funcionarios GROUP BY departamento HAVING AVG(SALARIO) > 2000;

SELECT departamento, COUNT(*) FROM funcionarios GROUP BY departamento;

SELECT nome FROM funcionarios
WHERE departamento IN 
(
SELECT departamento FROM funcionarios GROUP BY departamento HAVING AVG(SALARIO) > 2000
);

/* CREATE USER 'Daniel'@'200.200.190.190' IDENTIFIED BY 'bonasser123456'; */
/* CREATE USER 'Daniel'@'%' IDENTIFIED BY 'danielviagem'; */

CREATE USER 'Daniel'@'localhost' IDENTIFIED BY 'bonasser123456';
GRANT ALL ON curso_sql.* TO 'Daniel'@'localhost';

CREATE USER 'Daniel'@'%' IDENTIFIED BY 'danielviagem';
GRANT SELECT ON curso_sql.* TO 'Daniel'@'%';
/* GRANT INSERT ON curso_sql.* TO 'Daniel'@'%'; */
GRANT INSERT ON curso_sql.funcionarios TO 'Daniel'@'%';

REVOKE SELECT ON curso_sql.* FROM 'Daniel'@'%';
REVOKE INSERT ON curso_sql.funcionarios FROM 'Daniel'@'%';

GRANT SELECT ON curso_sql.funcionarios TO 'Daniel'@'%';
GRANT SELECT ON curso_sql.veiculos TO 'Daniel'@'%';

REVOKE SELECT ON curso_sql.funcionarios FROM 'Daniel'@'%';
REVOKE SELECT ON curso_sql.veiculos FROM 'Daniel'@'%';

REVOKE ALL ON curso_sql.* FROM 'Daniel'@'localhost';

DROP USER 'Daniel'@'localhost';
DROP USER 'Daniel'@'%';

SELECT USER FROM mysql.user;
SHOW GRANTS FOR 'Daniel'@'%';

SHOW ENGINES;

CREATE TABLE contas_bancarias
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    titular VARCHAR(45) NOT NULL,
    saldo DOUBLE NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

INSERT INTO contas_bancarias (titular, saldo) VALUES ('André', 1000);
INSERT INTO contas_bancarias (titular, saldo) VALUES ('Carlos', 2000);

SELECT * FROM contas_bancarias;

start transaction;
UPDATE contas_bancarias SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas_bancarias SET saldo = saldo + 100 WHERE id = 2;
rollback;

start transaction ;
UPDATE contas_bancarias SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas_bancarias SET saldo = saldo + 100 WHERE id = 2;
commit;

CREATE TABLE pedidos 
(
	id int unsigned not null auto_increment,
    descrição varchar(100) not null,
    valor double not null default '0',
    pago varchar(3) not null default "Não",
    PRIMARY KEY (id)
);

INSERT INTO pedidos (descrição, valor) VALUES ('TV', 3000);
INSERT INTO pedidos (descrição, valor) VALUES ('Geladeira', 1400);
INSERT INTO pedidos (descrição, valor) VALUES ('DVD Player', 300);

SELECT * FROM pedidos;
CALL limpa_pedidos();

CREATE TABLE estoque 
(
	id int unsigned not null auto_increment,
    descricao varchar(50) not null,
    quantidade int not null,
    PRIMARY KEY (id)
);

CREATE TRIGGER gatihlo_limpa_pedidos BEFORE INSERT ON estoque FOR EACH ROW CALL limpa_pedidos();

INSERT INTO estoque (descricao, quantidade) VALUES ('Fogão', 5);
UPDATE pedidos SET pago = "Sim" WHERE id = 8;
INSERT INTO estoque (descricao, quantidade) VALUES ('Celular', 10);
SELECT *, quantidade from estoque;

DELETE from estoque;









