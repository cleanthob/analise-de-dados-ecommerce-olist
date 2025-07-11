-- Análise de dados com SQL na base de dados de um ecommerce do Olist

----------------------------------------------------------------------------

-- 1. Quais as categorias distintas de produtos?
-- Existem 74 categorias distintas de produtos.
SELECT
	DISTINCT product_category_name
FROM
	olist_products_dataset opd;

----------------------------------------------------------------------------

-- 2. Quantos pedidos tive por categoria?
-- Conta quantos pedidos foram feitos para cada categoria de produto.
SELECT
	opd.product_category_name,
	COUNT(ood.order_id) AS qtd_pedidos
FROM
	olist_orders_dataset ood
LEFT JOIN 
	olist_order_items_dataset ooid
	ON ood.order_id = ooid.order_id
LEFT JOIN
	olist_products_dataset opd
	ON ooid.product_id = opd.product_id
WHERE
	opd.product_category_name <> ""
GROUP BY
	opd.product_category_name
ORDER BY
	qtd_pedidos DESC;

----------------------------------------------------------------------------

-- 3. Quais as top 5 categorias de produtos considerando a quantidade de pedidos?
-- Lista as 5 categorias com maior número de pedidos.
SELECT
	opd.product_category_name,
	COUNT(ood.order_id) AS qtd_pedidos
FROM
	olist_orders_dataset ood
LEFT JOIN 
	olist_order_items_dataset ooid
	ON ood.order_id = ooid.order_id
LEFT JOIN
	olist_products_dataset opd
	ON ooid.product_id = opd.product_id
WHERE
	opd.product_category_name <> ""
GROUP BY
	opd.product_category_name
ORDER BY
	qtd_pedidos DESC
LIMIT 5;

----------------------------------------------------------------------------

-- 4. Qual a quantidade vendida por categoria?
-- Soma os preços dos pedidos por categoria.
SELECT
	opd.product_category_name,
	SUM(ooid.price) AS preco_pedidos
FROM
	olist_orders_dataset ood
LEFT JOIN 
	olist_order_items_dataset ooid
	ON ood.order_id = ooid.order_id
LEFT JOIN
	olist_products_dataset opd
	ON ooid.product_id = opd.product_id
WHERE
	opd.product_category_name <> ""
GROUP BY
	opd.product_category_name
ORDER BY
	preco_pedidos DESC;

----------------------------------------------------------------------------

-- 5. Quais as top 5 categorias de produtos considerando a quantidade vendida?
-- Mostra as 5 categorias com maior valor total vendido.
SELECT
	opd.product_category_name,
	SUM(ooid.price) AS preco_pedidos
FROM
	olist_orders_dataset ood
LEFT JOIN 
	olist_order_items_dataset ooid
	ON ood.order_id = ooid.order_id
LEFT JOIN
	olist_products_dataset opd
	ON ooid.product_id = opd.product_id
WHERE
	opd.product_category_name <> ""
GROUP BY
	opd.product_category_name
ORDER BY
	preco_pedidos DESC
LIMIT 5;

----------------------------------------------------------------------------

-- 6. Quais as top 5 categorias de produtos mais vendidos no estado de São Paulo?
-- Considera apenas pedidos com destino ao estado de SP e soma o valor dos produtos por categoria.
SELECT
	opd.product_category_name,
	SUM(ooid.price) AS preco_pedidos
FROM
	olist_orders_dataset ood
LEFT JOIN 
	olist_order_items_dataset ooid
	ON ood.order_id = ooid.order_id
LEFT JOIN
	olist_products_dataset opd
	ON ooid.product_id = opd.product_id
LEFT JOIN
	olist_customers_dataset ocd
	ON ood.customer_id = ocd.customer_id
WHERE
	opd.product_category_name <> "" AND 
	ocd.customer_state = "SP"
GROUP BY
	opd.product_category_name
ORDER BY
	preco_pedidos DESC
LIMIT 5;

----------------------------------------------------------------------------

-- 7. Quais os top 5 estados com mais vendas?
-- Mostra os 5 estados com maior soma dos preços dos pedidos.
SELECT
	ocd.customer_state,
	SUM(ooid.price) AS preco_pedidos
FROM
	olist_orders_dataset ood
LEFT JOIN 
	olist_order_items_dataset ooid
	ON ood.order_id = ooid.order_id
LEFT JOIN
	olist_products_dataset opd
	ON ooid.product_id = opd.product_id
LEFT JOIN
	olist_customers_dataset ocd
	ON ood.customer_id = ocd.customer_id
WHERE
	opd.product_category_name <> ""
GROUP BY
	ocd.customer_state
ORDER BY
	preco_pedidos DESC
LIMIT 5;

----------------------------------------------------------------------------
