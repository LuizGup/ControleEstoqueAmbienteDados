WITH VendasVendedor AS (
    SELECT
        v.VendedorID,
        SUM(vi.Quantidade * vi.PrecoUnitarioVenda) AS TotalVendidoMes
    FROM Venda v
    JOIN Venda_Item vi ON v.VendaID = vi.VendaID
    WHERE
        -- Ajuste dinâmico para o mês atual
        v.DataVenda >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
        AND v.DataVenda < (DATE_FORMAT(CURRENT_DATE, '%Y-%m-01') + INTERVAL 1 MONTH)
    GROUP BY v.VendedorID
)
SELECT
    vd.Nome AS "Vendedor",
    COALESCE(vv.TotalVendidoMes, 0.00) AS "Total Vendas",
    vd.MetaVendaMensal AS "Meta",
    CASE
        WHEN COALESCE(vv.TotalVendidoMes, 0.00) >= vd.MetaVendaMensal THEN 'Sim'
        ELSE 'Não'
    END AS "Bateu Meta?",
    CASE
        WHEN COALESCE(vv.TotalVendidoMes, 0.00) < vd.MetaVendaMensal
        THEN vd.MetaVendaMensal - COALESCE(vv.TotalVendidoMes, 0.00)
        ELSE 0.00
    END AS "Falta (R$)"
FROM Vendedor vd
LEFT JOIN VendasVendedor vv ON vd.VendedorID = vv.VendedorID;