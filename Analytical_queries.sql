-- Analytical queries

-- 1. Total Revenue
SELECT
	SUM(payment_amount) AS total_revenue
FROM Payments
;
-- output: 3279.80

-- 2. Top 5 Best Selling Products
SELECT
	p.product_name,
    SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Products p
	ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5
; 
-- output: Cotton T-Shirt, Face Cream, Laptop Pro, Wireless Mouse, Shampoo 500ml

-- 3. Monthly Sales Trend
SELECT
	DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(oi.subtotal) AS monthly_sales
FROM Orders o
JOIN Order_Items oi
	ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month
;
-- Month: 2024-10  Monthly_Sales: 3279.80


-- 4. Top Customers by spending
SELECT
	c.first_name,
    c.last_name,
    SUM(p.payment_amount) AS total_spent
FROM Customers c
JOIN Orders o 
	ON c.customer_id = o.customer_id
JOIN Payments p
	ON o.order_id = p.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5
;

-- Output: Alice Johnson, Jack Wilson, Diana Prince, Karen Davis, Grace Lee

-- 5. Orders by Status
SELECT
	order_status,
    COUNT(*) AS order_count
FROM Orders
GROUP BY order_status
;