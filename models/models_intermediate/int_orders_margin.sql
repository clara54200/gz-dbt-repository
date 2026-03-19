SELECT
    orders_id,
    date_date,
    -- On additionne les revenus, coûts et marges de tous les produits d'une même commande
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(quantity), 2) AS quantity,
    ROUND(SUM(purchase_cost), 2) AS purchase_cost,
    ROUND(SUM(margin), 2) AS margin
FROM {{ ref('int_sales_margin') }}
GROUP BY 
    orders_id, 
    date_date
ORDER BY 
    orders_id DESC