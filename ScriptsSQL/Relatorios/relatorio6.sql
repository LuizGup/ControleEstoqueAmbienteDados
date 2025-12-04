SELECT
    p.Nome AS "Produto",
    SUM(le.QuantidadeAtual) AS "Qtde Parada",
    MAX(v.DataVenda) AS "Data da Última Venda"
FROM Produto p
JOIN Lote_Estoque le ON p.ProdutoID = le.ProdutoID
LEFT JOIN Venda_Item vi ON p.ProdutoID = vi.ProdutoID
LEFT JOIN Venda v ON vi.VendaID = v.VendaID
GROUP BY p.ProdutoID, p.Nome
HAVING 
    SUM(le.QuantidadeAtual) > 0 
    AND (
        MAX(v.DataVenda) <= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) 
        OR MAX(v.DataVenda) IS NULL
    )
ORDER BY "Data da Última Venda" ASC;