WITH LastMonthConversions AS (
    SELECT
        o.product_id,
        SUM(o.order_amount) AS total_sales
    FROM
        orders o
    WHERE
        o.conversion_timestamp >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
        AND o.conversion_timestamp < DATE_TRUNC('month', CURRENT_DATE)
    GROUP BY
        o.product_id
),
TopFiveProducts AS (
    SELECT
        product_id,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM
        LastMonthConversions
)
SELECT
    product_id,
    total_sales
FROM
    TopFiveProducts
WHERE
    sales_rank <= 5;