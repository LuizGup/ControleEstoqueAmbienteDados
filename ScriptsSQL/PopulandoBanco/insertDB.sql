use atividade;

-- 1. Usuários e Pessoas
INSERT INTO Usuario (Matricula, Nome) VALUES ('M1001', 'Admin');

INSERT INTO Vendedor (Nome, MetaVendaMensal) VALUES 
('Carla Silva', 5000.00),
('Bruno Costa', 7000.00);

INSERT INTO Cliente (Nome, Email, Telefone) VALUES 
('Ana Beatriz', 'ana@email.com', '85999998888'),
('Marcos (Dono)', 'marcos@loja.com', '85988887777');

INSERT INTO Fornecedor (Nome, CNPJ) VALUES 
('TechDistribuidora', '11.222.333/0001-44'),
('Moda Atacado', '22.333.444/0001-55');

INSERT INTO Transportadora (Nome, CNPJ) VALUES ('RápidoLog', '33.444.555/0001-66');

-- 2. Produtos e Características
INSERT INTO Marca (Nome) VALUES ('SuperTech'), ('Elegance');
INSERT INTO Categoria_Produto (Nome) VALUES ('Eletrônicos'), ('Roupas');

INSERT INTO Produto (Nome, Modelo, MarcaID, CategoriaID, UnidadeVenda, PrecoVenda) VALUES
('Furadeira de Impacto', 'FI-1000', 1, 1, 'unidade', 299.90),
('Camisa Polo', 'Polo Classic', 2, 2, 'unidade', 119.90),
('Notebook Gamer', 'Nitro 5', 1, 1, 'unidade', 4500.00);

INSERT INTO Caracteristica (Nome) VALUES ('Voltagem'), ('Cor'), ('Tecido');
INSERT INTO Produto_Caracteristica (ProdutoID, CaracteristicaID, Valor) VALUES
(1, 1, '220V'), 
(2, 2, 'Azul Marinho'), 
(2, 3, 'Piquet'), 
(3, 1, 'Bivolt');

-- 3. Histórico de Preços
INSERT INTO Preco_Produto (ProdutoID, ValorVenda, DataInicioVigencia, UsuarioID_Modificacao) VALUES
(1, 299.90, '2025-01-01', 1),
(2, 119.90, '2025-01-01', 1),
(3, 4500.00, '2025-01-01', 1);

-- 4. Vínculo Fornecedor-Produto
INSERT INTO Fornecedor_Produto (FornecedorID, ProdutoID) VALUES (1, 1), (1, 3), (2, 2);

-- 5. Processo de COMPRA (Entrada)
INSERT INTO Compra (FornecedorID, DataCompra, DataPrevistaEntrega) VALUES
(1, '2025-10-20', '2025-11-15'), 
(2, '2025-10-21', '2025-11-10'); 

INSERT INTO Compra_Item (CompraID, ProdutoID, Quantidade, ValorNegociado) VALUES
(1, 1, 50, 150.00), -- Furadeiras
(1, 3, 10, 3500.00), -- Notebooks
(2, 2, 100, 40.00); -- Camisas

-- 6. Processo de ESTOQUE (Recebimento)
-- Nota: Notebooks (Prod 3) ainda não recebidos para testar relatório 1
INSERT INTO Lote_Estoque (ProdutoID, CompraItemID, NumeroLote, QuantidadeRecebida, QuantidadeAtual, LocalArmazenamento) VALUES
(1, 1, 'LOTE-FURA-001', 50, 50, 'A1-P2'),
(2, 3, 'LOTE-CAM-001', 100, 100, 'B3-P1');

-- 7. Processo de VENDA (Saída)
-- Venda 1: Mês Atual (Novembro)
INSERT INTO Venda (ClienteID, VendedorID, DataVenda) VALUES (1, 1, '2025-11-11 10:00:00'); 
INSERT INTO Venda_Item (VendaID, ProdutoID, Quantidade, PrecoUnitarioVenda) VALUES
(1, 1, 2, 299.90), 
(1, 2, 1, 119.90);

-- Baixa no estoque Venda 1
UPDATE Lote_Estoque SET QuantidadeAtual = QuantidadeAtual - 2 WHERE ProdutoID = 1 LIMIT 1;
UPDATE Lote_Estoque SET QuantidadeAtual = QuantidadeAtual - 1 WHERE ProdutoID = 2 LIMIT 1;

-- Venda 2: Mês Atual
INSERT INTO Venda (ClienteID, VendedorID, DataVenda) VALUES (2, 2, '2025-11-05 09:00:00'); 
INSERT INTO Venda_Item (VendaID, ProdutoID, Quantidade, PrecoUnitarioVenda) VALUES
(2, 1, 10, 299.90);

-- Baixa no estoque Venda 2
UPDATE Lote_Estoque SET QuantidadeAtual = QuantidadeAtual - 10 WHERE ProdutoID = 1 LIMIT 1;

-- 8. ENTREGA e RASTREAMENTO
INSERT INTO Entrega (VendaID, TransportadoraID, EnderecoDestino, MeioTransporte, DataEnvio, PrevisaoEntrega) VALUES
(1, 1, 'Rua das Flores, 123, Fortaleza, CE', 'Rodoviário', '2025-11-11 14:00:00', '2025-11-14');

INSERT INTO Rastreamento (EntregaID, Localizacao, Status) VALUES
(1, 'Centro de Distribuição - Fortaleza', 'Pacote recebido pela transportadora'),
(1, 'Em trânsito para o destino', 'Pacote em rota de entrega regional');

-- 9. AVALIAÇÕES
INSERT INTO Avaliacao_Venda (VendaID, Nota) VALUES (1, 5), (2, 4);

INSERT INTO Lote_Estoque (ProdutoID, CompraItemID, NumeroLote, QuantidadeRecebida, QuantidadeAtual, LocalArmazenamento) 
VALUES (3, 2, 'LOTE-NOTE-001', 10, 10, 'SALA-SEGURA-01');