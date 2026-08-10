-- Create Schema
CREATE SCHEMA dannys_diner;

-- Set Schema for this project
use dannys_diner;

-- Sales Table
CREATE TABLE sales (
customer_id VARCHAR(1),
  order_date DATE,
  product_id INTEGER
);

INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 
-- Menu Table
CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  
-- Members Table
CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO members
  (customer_id, join_date) 
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
-- 1. What is the total amount each customer spent at the restaurant?
SELECT s.customer_id, SUM(m. price)
FROM sales s, menu m
WHERE m.product_id = s.product_id
GROUP BY customer_id;

-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, count(*) days
FROM Sales
GROUP BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?
WITH cte_first_product AS ( 
SELECT s.customer_id, s.order_date, m.product_name, 
DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) row_f
FROM sales s, menu m
WHERE m.product_id = s.product_id)

SELECT customer_id, product_name
FROM cte_first_product
WHERE row_f = 1;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT s.product_id, m.product_name, COUNT(*) most_product
FROM sales s, menu m
WHERE m.product_id = s.product_id
GROUP BY s.product_id, m.product_name
ORDER BY most_product DESC
LIMIT 1;

-- 5. Which item was the most popular for each customer?
WITH cte_snd_product AS ( 
SELECT s.customer_id, m.product_name, COUNT(s.product_id) count,
DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY  COUNT(s.product_id) DESC) row_e
FROM sales s, menu m
WHERE m.product_id = s.product_id
GROUP BY s.customer_id, m.product_name)

SELECT customer_id, product_name
FROM cte_snd_product
WHERE row_e = 1;

-- 6. Which item was purchased first by the customer after they became a member?
-- where ad means after join date
WITH cte_ad_product AS ( 
SELECT s.customer_id,s.order_date,me.join_date, m.product_name, COUNT(s.product_id) count,
DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) row_c
FROM sales s, menu m, members me
WHERE m.product_id = s.product_id 
AND me.customer_id = s.customer_id 
AND s.order_date >= me.join_date
GROUP BY s.customer_id,s.order_date,me.join_date, m.product_name)

SELECT customer_id, product_name
FROM cte_ad_product
WHERE row_c = 1;

-- 7. Which item was purchased just before the customer became a member?
-- where bd means before join date
WITH cte_bd_product AS ( 
SELECT s.customer_id,s.order_date,me.join_date, m.product_name, COUNT(s.product_id) count,
DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY s.order_date) row_c
FROM sales s, menu m, members me
WHERE m.product_id = s.product_id 
AND me.customer_id = s.customer_id 
AND s.order_date < me.join_date
GROUP BY s.customer_id,s.order_date,me.join_date, m.product_name)

SELECT customer_id, product_name
FROM cte_bd_product
WHERE row_c = 1;

-- 8. What is the total items and amount spent for each member before they became a member?
SELECT s.customer_id, COUNT(s.product_id) total_items, SUM(m.price) amount_spent
FROM sales s, menu m, members me
WHERE m.product_id = s.product_id 
AND me.customer_id = s.customer_id 
AND s.order_date < me.join_date
GROUP BY s.customer_id;

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier 
		-- how many points would each customer have?
				-- 2x multiplier means 10 * 2
WITH multiplier AS (
	SELECT s.customer_id, m.product_name, SUM(m.price) price,
		CASE WHEN m.product_name = 'sushi' THEN SUM(m.price) * 10 * 2
		ELSE SUM(m.price) * 10
		END points
FROM sales s, menu m
WHERE s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name)

SELECT customer_id, SUM(points) points
FROM multiplier
GROUP BY customer_id;

-- 10. In the first week after a customer joins the program (including their join date)
		-- they earn 2x points on all items, not just sushi 
        -- how many points do customer A and B have at the end of January?
        
WITH cte_offer_validity AS (
    SELECT s.customer_id, me.join_date, s.order_date,
		m.product_name, m.price,
        date_add(me.join_date, interval(6) DAY) firstweek_ends
    FROM sales s, menu m, members me
	WHERE s.customer_id = me.customer_id
    AND s.product_id = m.product_id)
    
SELECT customer_id,
    SUM(CASE
            WHEN order_date BETWEEN join_date AND firstweek_ends THEN price * 10 * 2
            WHEN (order_date NOT BETWEEN join_date AND firstweek_ends) 
            AND product_name = 'sushi' THEN price * 10 * 2
            ELSE price * 10
            END) points
FROM cte_offer_validity
WHERE order_date < '2021-02-01'
GROUP BY customer_id
ORDER BY points DESC;

-- BONUS
/*The following questions are related creating basic data tables that Danny and 
his team can use to quickly derive insights without needing to join the underlying tables using SQL.*/

-- 1. Recreate the following table output using the available data
CREATE VIEW details AS (
SELECT s.customer_id, s.order_date, m.product_name, price, 
    CASE
      WHEN me.join_date <= s.order_date THEN 'Y'
      ELSE 'N'
    END AS members
FROM sales s
LEFT JOIN members me
ON s.customer_id = me.customer_id
JOIN menu m
ON s.product_id = m.product_id
);
    
SELECT *
FROM details;

-- 2. Danny also requires further information about the ranking of customer products, 
	-- but he purposely does not need the ranking for non-member purchases so he expects 
    -- null ranking values for the records when customers are not yet part of the loyalty program.

SELECT *,
   CASE
     WHEN members = 'N' THEN null
     ELSE RANK() OVER(PARTITION BY customer_id, members ORDER BY order_date)
   END AS ranking
FROM details;