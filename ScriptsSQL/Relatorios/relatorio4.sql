WITH NotasPossiveis AS (
    SELECT 1 AS Nota UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
)
SELECT
    np.Nota,
    COUNT(av.AvaliacaoID) AS "Total de Avaliações"
FROM NotasPossiveis np
LEFT JOIN Avaliacao_Venda av ON np.Nota = av.Nota
GROUP BY np.Nota
ORDER BY np.Nota DESC;