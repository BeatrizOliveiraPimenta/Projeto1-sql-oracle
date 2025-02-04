-- Criação de uma sequência para a tabela clientes
CREATE SEQUENCE clientes_seq START WITH 1 INCREMENT BY 1;

-- Criação de uma sequência para a tabela pedidos
CREATE SEQUENCE pedidos_seq START WITH 1 INCREMENT BY 1;

-- Criação da tabela de clientes
CREATE TABLE clientes (
    id NUMBER PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    data_cadastro DATE DEFAULT SYSDATE
);

-- Criação da tabela de pedidos
CREATE TABLE pedidos (
    id NUMBER PRIMARY KEY,
    cliente_id NUMBER REFERENCES clientes(id),
    valor NUMBER(10,2) NOT NULL,
    data_pedido DATE DEFAULT SYSDATE
);

-- Inserção de dados
INSERT INTO clientes (id, nome, email) VALUES
    (clientes_seq.NEXTVAL, 'Alice Souza', 'alice@email.com');
INSERT INTO clientes (id, nome, email) VALUES
    (clientes_seq.NEXTVAL, 'Bruno Lima', 'bruno@email.com');
INSERT INTO clientes (id, nome, email) VALUES
    (clientes_seq.NEXTVAL, 'Carlos Mendes', 'carlos@email.com');

INSERT INTO pedidos (id, cliente_id, valor) VALUES
    (pedidos_seq.NEXTVAL, 1, 150.00);
INSERT INTO pedidos (id, cliente_id, valor) VALUES
    (pedidos_seq.NEXTVAL, 2, 200.50);
INSERT INTO pedidos (id, cliente_id, valor) VALUES
    (pedidos_seq.NEXTVAL, 1, 99.99);
INSERT INTO pedidos (id, cliente_id, valor) VALUES
    (pedidos_seq.NEXTVAL, 3, 300.00);

-- Consulta para obter os clientes e seus pedidos
SELECT c.nome, c.email, p.valor, p.data_pedido 
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id;

-- Consulta para obter o total gasto por cada cliente
SELECT c.nome, SUM(p.valor) AS total_gasto
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.nome
ORDER BY total_gasto DESC;

-- Atualizar um pedido
UPDATE pedidos 
SET valor = 250.00 
WHERE id = 2;

-- Excluir um pedido
DELETE FROM pedidos 
WHERE id = 3;
