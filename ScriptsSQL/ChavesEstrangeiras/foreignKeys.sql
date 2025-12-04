/* ================= CHAVES ESTRANGEIRAS (ALTER TABLE) ================= */

-- Cliente
ALTER TABLE Endereco_Cliente ADD CONSTRAINT fk_endereco_cliente FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID);

-- Produto
ALTER TABLE Produto ADD CONSTRAINT fk_produto_marca FOREIGN KEY (MarcaID) REFERENCES Marca(MarcaID);
ALTER TABLE Produto ADD CONSTRAINT fk_produto_categoria FOREIGN KEY (CategoriaID) REFERENCES Categoria_Produto(CategoriaID);

-- Características
ALTER TABLE Produto_Caracteristica ADD CONSTRAINT fk_prodcarac_produto FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID) ON DELETE CASCADE;
ALTER TABLE Produto_Caracteristica ADD CONSTRAINT fk_prodcarac_caracteristica FOREIGN KEY (CaracteristicaID) REFERENCES Caracteristica(CaracteristicaID);

-- Preço e Fornecedor
ALTER TABLE Preco_Produto ADD CONSTRAINT fk_preco_produto FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID);
ALTER TABLE Preco_Produto ADD CONSTRAINT fk_preco_usuario FOREIGN KEY (UsuarioID_Modificacao) REFERENCES Usuario(UsuarioID);

ALTER TABLE Fornecedor_Produto ADD CONSTRAINT fk_fornprod_fornecedor FOREIGN KEY (FornecedorID) REFERENCES Fornecedor(FornecedorID);
ALTER TABLE Fornecedor_Produto ADD CONSTRAINT fk_fornprod_produto FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID);

ALTER TABLE Cliente_Produto_Preferido ADD CONSTRAINT fk_cliprod_cliente FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID);
ALTER TABLE Cliente_Produto_Preferido ADD CONSTRAINT fk_cliprod_produto FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID);

-- Compra e Estoque
ALTER TABLE Compra ADD CONSTRAINT fk_compra_fornecedor FOREIGN KEY (FornecedorID) REFERENCES Fornecedor(FornecedorID);
ALTER TABLE Compra_Item ADD CONSTRAINT fk_compraitem_compra FOREIGN KEY (CompraID) REFERENCES Compra(CompraID);
ALTER TABLE Compra_Item ADD CONSTRAINT fk_compraitem_produto FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID);

ALTER TABLE Lote_Estoque ADD CONSTRAINT fk_lote_produto FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID);
ALTER TABLE Lote_Estoque ADD CONSTRAINT fk_lote_compraitem FOREIGN KEY (CompraItemID) REFERENCES Compra_Item(CompraItemID);

-- Venda e Entrega
ALTER TABLE Venda ADD CONSTRAINT fk_venda_cliente FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID);
ALTER TABLE Venda ADD CONSTRAINT fk_venda_vendedor FOREIGN KEY (VendedorID) REFERENCES Vendedor(VendedorID);

ALTER TABLE Venda_Item ADD CONSTRAINT fk_vendaitem_venda FOREIGN KEY (VendaID) REFERENCES Venda(VendaID);
ALTER TABLE Venda_Item ADD CONSTRAINT fk_vendaitem_produto FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID);

ALTER TABLE Entrega ADD CONSTRAINT fk_entrega_venda FOREIGN KEY (VendaID) REFERENCES Venda(VendaID);
ALTER TABLE Entrega ADD CONSTRAINT fk_entrega_transportadora FOREIGN KEY (TransportadoraID) REFERENCES Transportadora(TransportadoraID);

ALTER TABLE Rastreamento ADD CONSTRAINT fk_rastreamento_entrega FOREIGN KEY (EntregaID) REFERENCES Entrega(EntregaID);

ALTER TABLE Avaliacao_Venda ADD CONSTRAINT fk_avaliacao_venda FOREIGN KEY (VendaID) REFERENCES Venda(VendaID);

ALTER TABLE Preco_Historico ADD CONSTRAINT fk_preco_produto
    FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID);

ALTER TABLE Preco_Historico ADD CONSTRAINT fk_preco_usuario
    FOREIGN KEY (UsuarioID_Modificacao) REFERENCES Usuario(UsuarioID);