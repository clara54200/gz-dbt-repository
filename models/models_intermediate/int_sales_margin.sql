WITH sales AS (
    -- On appelle le fichier stg_gz__sales.sql
    SELECT * FROM {{ ref('stg_gz__sales') }}
),

product AS (
    -- On appelle le fichier stg_gz__product.sql
    SELECT * FROM {{ ref('stg_gz__product') }}
)

SELECT
    s.date_date,
    s.orders_id,
    s.pdt_id,
    s.revenue,
    s.quantity,
    CAST(p.purchSE_PRICE AS FLOAT64) AS unit_purchase_price,
    -- Calcul du coût d'achat total
    ROUND(s.quantity * CAST(p.purchSE_PRICE AS FLOAT64), 2) AS purchase_cost,
    -- Calcul de la marge
    ROUND(s.revenue - (s.quantity * CAST(p.purchSE_PRICE AS FLOAT64)), 2) AS margin
FROM sales s
LEFT JOIN product p 
    ON s.pdt_id = p.products_id