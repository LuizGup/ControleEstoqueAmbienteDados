SELECT
    r.DataHora,
    r.Localizacao,
    r.Status,
    CASE 
        WHEN r.Status = 'Entregue' THEN e.NomeRecebedor 
        ELSE NULL 
    END AS RecebidoPor
FROM Entrega e
JOIN Rastreamento r ON e.EntregaID = r.EntregaID
WHERE e.VendaID = 1 -- Filtro da Venda Específica
ORDER BY r.DataHora DESC;