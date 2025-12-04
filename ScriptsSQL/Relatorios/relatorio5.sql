SELECT
    p.Nome AS "Produto",
    CAST(AVG(ci.ValorNegociado / ci.Quantidade) AS DECIMAL(10,2)) AS "Custo Médio Unit.",
    p.PrecoVenda AS "Preço Atual",
    CAST((p.PrecoVenda - AVG(ci.ValorNegociado / ci.Quantidade)) AS DECIMAL(10,2)) AS "Margem Bruta (R$)",
    (SELECT f.Nome 
     FROM Compra c2 
     JOIN Compra_Item ci2 ON c2.CompraID = ci2.CompraID
     JOIN Fornecedor f ON c2.FornecedorID = f.FornecedorID
     WHERE ci2.ProdutoID = p.ProdutoID
     ORDER BY c2.DataCompra DESC
     LIMIT 1) AS "Fornecedor Principal"
FROM Produto p
JOIN Compra_Item ci ON p.ProdutoID = ci.ProdutoID
GROUP BY p.ProdutoID, p.Nome, p.PrecoVenda
ORDER BY "Margem Bruta (R$)" DESC
LIMIT 10;