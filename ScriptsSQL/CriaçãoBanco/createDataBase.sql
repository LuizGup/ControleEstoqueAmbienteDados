DROP DATABASE IF EXISTS atividade;
CREATE DATABASE atividade;
USE atividade;

/* ================= TABELAS (SEM FKs) ================= */

CREATE TABLE Usuario (
    UsuarioID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Matricula VARCHAR(50) NOT NULL UNIQUE,
    Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Vendedor (
    VendedorID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    MetaVendaMensal DECIMAL(10, 2) NOT NULL DEFAULT 0
);

CREATE TABLE Cliente (
    ClienteID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Telefone VARCHAR(20)
);

CREATE TABLE Endereco_Cliente (
    EnderecoID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT UNSIGNED NOT NULL,
    Logradouro VARCHAR(255) NOT NULL,
    Numero VARCHAR(20),
    Complemento VARCHAR(100),
    Bairro VARCHAR(100),
    Cidade VARCHAR(100),
    Estado CHAR(2),
    CEP VARCHAR(10)
);

CREATE TABLE Transportadora (
    TransportadoraID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(18) UNIQUE,
    Telefone VARCHAR(20)
);

CREATE TABLE Fornecedor (
    FornecedorID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CNPJ VARCHAR(18) NOT NULL UNIQUE,
    Endereco VARCHAR(255),
    Telefone VARCHAR(20)
);

CREATE TABLE Categoria_Produto (
    CategoriaID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Marca (
    MarcaID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Produto (
    ProdutoID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(200) NOT NULL,
    Modelo VARCHAR(100),
    Descricao TEXT,
    MarcaID INT UNSIGNED,
    CategoriaID INT UNSIGNED,
    UnidadeVenda ENUM('unidade', 'metro', 'm3', 'litro', 'kg') NOT NULL,
    LucroPercentualEstimado DECIMAL(5, 2),
    -- Campo para acesso rápido ao preço atual (opcional, mas comum)
    PrecoVenda DECIMAL(10, 2) 
);

CREATE TABLE Caracteristica (
    CaracteristicaID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Produto_Caracteristica (
    ProdutoID INT UNSIGNED NOT NULL,
    CaracteristicaID INT UNSIGNED NOT NULL,
    Valor VARCHAR(255) NOT NULL,
    PRIMARY KEY (ProdutoID, CaracteristicaID)
);

CREATE TABLE Preco_Produto (
    PrecoID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ProdutoID INT UNSIGNED NOT NULL,
    ValorVenda DECIMAL(10, 2) NOT NULL,
    DataInicioVigencia DATE NOT NULL,
    DataFimVigencia DATE, -- NULL indica que é o preço vigente
    UsuarioID_Modificacao INT UNSIGNED NOT NULL
);

CREATE TABLE Fornecedor_Produto (
    FornecedorID INT UNSIGNED NOT NULL,
    ProdutoID INT UNSIGNED NOT NULL,
    PRIMARY KEY (FornecedorID, ProdutoID)
);

CREATE TABLE Cliente_Produto_Preferido (
    ClienteID INT UNSIGNED NOT NULL,
    ProdutoID INT UNSIGNED NOT NULL,
    PRIMARY KEY (ClienteID, ProdutoID)
);

CREATE TABLE Compra (
    CompraID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    FornecedorID INT UNSIGNED NOT NULL,
    DataCompra DATE NOT NULL,
    CondicaoPagamento VARCHAR(100),
    DataPagamento DATE,
    DataPrevistaEntrega DATE NOT NULL
);

CREATE TABLE Compra_Item (
    CompraItemID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CompraID INT UNSIGNED NOT NULL,
    ProdutoID INT UNSIGNED NOT NULL,
    Quantidade DECIMAL(10, 3) NOT NULL,
    ValorNegociado DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Lote_Estoque (
    LoteID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ProdutoID INT UNSIGNED NOT NULL,
    CompraItemID INT UNSIGNED,
    NumeroLote VARCHAR(50),
    QuantidadeRecebida DECIMAL(10, 3) NOT NULL,
    QuantidadeAtual DECIMAL(10, 3) NOT NULL,
    DataEntrada TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    DataValidade DATE,
    LocalArmazenamento VARCHAR(100)
);

CREATE TABLE Venda (
    VendaID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT UNSIGNED NOT NULL,
    VendedorID INT UNSIGNED NOT NULL,
    DataVenda TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    StatusVenda VARCHAR(50) NOT NULL DEFAULT 'Processando'
);

CREATE TABLE Venda_Item (
    VendaItemID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    VendaID INT UNSIGNED NOT NULL,
    ProdutoID INT UNSIGNED NOT NULL,
    Quantidade DECIMAL(10, 3) NOT NULL,
    PrecoUnitarioVenda DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Entrega (
    EntregaID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    VendaID INT UNSIGNED NOT NULL UNIQUE,
    TransportadoraID INT UNSIGNED,
    EnderecoDestino VARCHAR(255) NOT NULL,
    MeioTransporte VARCHAR(50),
    DataEnvio TIMESTAMP,
    PrevisaoEntrega DATE,
    DataEntregaReal TIMESTAMP NULL,
    NomeRecebedor VARCHAR(100) -- Alterado de RecebidoPor para padronizar com SQL
);

CREATE TABLE Rastreamento (
    RastreamentoID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    EntregaID INT UNSIGNED NOT NULL,
    DataHora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Localizacao VARCHAR(255) NOT NULL,
    Status VARCHAR(100) NOT NULL
);

CREATE TABLE Avaliacao_Venda (
    AvaliacaoID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    VendaID INT UNSIGNED NOT NULL UNIQUE,
    Nota INT NOT NULL CHECK (Nota BETWEEN 1 AND 5),
    Comentario TEXT,
    DataAvaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);