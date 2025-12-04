WITH ProximaChegada AS (
    SELECT
        ci.ProdutoID,
        MIN(c.DataPrevistaEntrega) AS ProximaData
    FROM Compra c
    JOIN Compra_Item ci ON c.CompraID = ci.CompraID
    LEFT JOIN Lote_Estoque le ON le.CompraItemID = ci.CompraItemID
    WHERE le.LoteID IS NULL -- Itens comprados mas ainda não loteados (não entregues)
    GROUP BY ci.ProdutoID
)
SELECT
    p.Modelo AS "Modelo",
    p.Nome AS "Produto",
    COALESCE(SUM(le.QuantidadeAtual), 0) AS "Qtd Disponível",
    COALESCE(GROUP_CONCAT(DISTINCT le.LocalArmazenamento SEPARATOR ', '), 'Sem estoque') AS "Local",
    pch.ProximaData AS "Chegada Prevista"
FROM Produto p
LEFT JOIN Lote_Estoque le ON p.ProdutoID = le.ProdutoID
LEFT JOIN ProximaChegada pch ON p.ProdutoID = pch.ProdutoID
GROUP BY p.ProdutoID, p.Nome, p.Modelo, pch.ProximaData
ORDER BY p.Nome;