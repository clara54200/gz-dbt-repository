WITH orders_margin AS (
    SELECT * FROM {{ ref('int_orders_margin') }}
),

ship AS (
    SELECT * FROM {{ ref('stg_gz__ship') }}
)

SELECT
    o.orders_id,
    o.date_date,

    ROUND(
        o.margin 
        + s.shipping_fee 
        - s.logcost 
        - CAST(s.ship_cost AS FLOAT64)
    , 2) AS operational_margin,
    o.revenue,
    o.purchase_cost,
    o.margin,
    s.shipping_fee,
    s.logcost,
    s.ship_cost,
    o.quantity
FROM orders_margin o
LEFT JOIN ship s 
    ON o.orders_id = s.orders_id