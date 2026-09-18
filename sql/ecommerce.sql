-- Q1. Which customers generated the highest revenue for the business?
SELECT 
	u.user_id,
	u.name,
	ROUND(SUM(o.total_amount)::numeric) as revenue
FROM users u
JOIN orders o 
ON u.user_id=o.user_id
WHERE order_status='completed'
GROUP BY u.user_id, u.name
ORDER BY revenue DESC
LIMIT 10;

-- Q2. How has the company's revenue changed month over month?
WITH monthly_revenue AS (
	SELECT 
		DATE_TRUNC('month',order_date) AS Month,
		ROUND(SUM(total_amount)::numeric) as revenue
	FROM orders
	WHERE order_status='completed'
	GROUP BY DATE_TRUNC('month',order_date)
)
SELECT 
	TO_CHAR(month,'Mon YYYY'),
	revenue,
	LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
	ROUND(
		((revenue-LAG(revenue) OVER (ORDER BY month))
		/LAG(revenue) OVER (ORDER BY month)) * 100, 2
		) AS mom_growth_percentage
FROM monthly_revenue
ORDER BY month;

-- Q3. Which products contribute the most to the company's total revenue?
SELECT 
	p.product_id,
	p.product_name,
	ROUND(SUM(oi.item_total)::numeric,2) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
JOIN orders o
ON oi.order_id=o.order_id
WHERE order_status='completed'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 10;

-- Q4. Which product categories generate the highest revenue?
SELECT 
	p.category,
	ROUND(SUM(oi.item_total)::numeric,2) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
JOIN orders o
ON oi.order_id=o.order_id
WHERE order_status='completed'
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 10;

-- Q5. What percentage of total orders falls under each order status?
SELECT
	order_status,
	COUNT(*) AS total_order,
	ROUND(
		(COUNT(*)/SUM(COUNT(*)) OVER()) * 100, 2
		) AS total_order_percentage
FROM orders
GROUP BY order_status;

-- Q6. How can customers be segmented into Platinum, Gold, Silver, and Bronze based on their total spending?
WITH customer_spending AS (
	SELECT
		u.user_id,
		u.name,
		ROUND(SUM(o.total_amount)::numeric,2) AS total_spending
	FROM users u
	JOIN orders o
	ON u.user_id=o.user_id
	WHERE order_status='completed'
	GROUP BY u.user_id, u.name
),
customer_segments AS (
	SELECT
		user_id,
		name,
		total_spending,
		NTILE(4) OVER(ORDER BY total_spending DESC) AS spending_group
	FROM customer_spending
)
SELECT
	user_id,
	name,
	total_spending,
	CASE 
		WHEN spending_group = 1 THEN 'Platinum'
		WHEN spending_group = 2 THEN 'Gold'
		WHEN spending_group = 3 THEN 'Silver'
		ELSE 'Bronze'
	END AS customer_segment
FROM customer_segments
ORDER BY total_spending DESC;

-- Q7. Rank the Top 3 products within each category based on revenue.
WITH product_revenue AS (
	SELECT
		p.product_id,
		p.category,
		p.product_name,
		ROUND(SUM(oi.item_total)::numeric,2) AS revenue
	FROM products p
	JOIN order_items oi
	ON p.product_id=oi.product_id
	JOIN orders o
	ON oi.order_id=o.order_id
	WHERE order_status='completed'
	GROUP BY p.product_id, p.category, p.product_name	
),
ranking AS (
	SELECT
		product_id,
		category,
		product_name,
		revenue,
		ROW_NUMBER() OVER(PARTITION BY category ORDER BY revenue DESC) AS product_rank
	FROM product_revenue
)
SELECT *
FROM ranking
WHERE product_rank<=3
ORDER BY category, product_rank;
	

-- Q8. Which products have the highest average customer rating among products with at least 20 reviews?
SELECT 
	p.product_id,
	p.product_name,
	ROUND(AVG(r.rating),2) AS customer_rating,
	COUNT(r.review_id) AS reviews_count
FROM products p
JOIN reviews r
	ON p.product_id=r.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(r.review_id)>=20
ORDER BY customer_rating DESC;

-- Q9. Which products are viewed or added to cart frequently but purchased the least?
-- (Use LEFT JOIN + CTE)
WITH product_interest AS (
	SELECT
		product_id,
		COUNT(*) FILTER(
			WHERE event_type IN ('view','cart')
		) AS interest_count
	FROM events
	GROUP BY product_id
),
product_purchases AS (
	SELECT
		oi.product_id,
		ROUND(SUM(oi.item_total)::numeric,2) AS purchased_units
	FROM order_items oi
	JOIN orders o
		ON oi.order_id=o.order_id
	WHERE o.order_status='completed'
	GROUP BY oi.product_id
)
SELECT
	p.product_id,
	p.product_name,
	pi.interest_count,
	COALESCE(pp.purchase_units,0) AS purchased_units
FROM products p
JOIN product_interest pi
	ON p.product_id=pi.product_id
LEFT JOIN product_purchases pp
	ON p.product_id=pp.product_id
ORDER BY pi.interest_count DESC, purchased_units ASC;


-- Q10. Calculate the rolling 3-month revenue trend.
-- (Use Window Frame)
WITH monthly_revenue AS (
	SELECT
		DATE_TRUNC('month',order_date) AS month_start,
		ROUND(SUM(total_amount)::numeric,2) AS revenue
	FROM orders
	WHERE order_status='completed'
	GROUP BY DATE_TRUNC('month',order_date)
)
SELECT
	TO_CHAR(month_start,'Mon YYYY') AS Month,
	revenue AS monthly_revenue,
	ROUND(
		SUM(revenue) OVER(
			ORDER BY month_start
			ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
		),2
	) AS rolling_3_month_revenue
FROM monthly_revenue
ORDER BY month_start;


	
