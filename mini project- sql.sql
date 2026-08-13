SELECT name,email from customers;
select * from products;
select distinct(category) from products;
select name,category,price from products where price>1000;
select name,category,price from products where price between 2000 and 5000 ;
select * from customers where name like "A%";
select * from products
where price<3000 and 
category="Electronics";
-- 9. Display product names and prices in descending order of price 
select name, price from products order by price desc;
-- 10. Display product names and prices, sorted by price and then by name 
select name,price from products order by price asc,name asc;
-- 1. Retrieve orders where customer information is missing (possibly due to data migration or deletion) 
select * from customers; -- customer_id, name,email,phone,created_at
select * from orders; -- order_id,customer_id,order_date,status,total_amount

SELECT
    o.order_id,
    o.customer_id,
    c.name
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT
   name AS "Customer Name",
   email AS "Email Address"
FROM customers;

select * from order_items;

SELECT
    order_id,
    quantity,
    item_price,
    quantity * item_price AS total_value
FROM order_items;
-- 4. Combine customer name and phone number in a single column 
SELECT
    CONCAT(name, ' - ', phone) AS customer_contact
FROM customers;
select * from orders;

SELECT
    order_id,
    DATE(order_date) AS order_date
FROM orders;
-- 6. List products that do not have any stock left 
select * from products;

select name,product_id from products where stock_quantity<1;
select * from orders;
SELECT COUNT(*) AS total_orders
FROM orders;
-- 2. Calculate the total revenue collected from all orders 
select sum(total_amount) from orders; 

select avg(total_amount) from orders;
SELECT COUNT(DISTINCT customer_id) AS customers_with_orders
FROM orders;

-- 5. Find the number of orders placed by each customer 
select * from customers;
select * from orders;

SELECT
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;
-- 6. Find total sales amount made by each customer 
-- 7. List the number of products sold per category 


select * from  products;
select category ,count(*) from products group by category;
select category ,avg(price) from products group by category;
select * from orders;

SELECT
    DATE(order_date) AS order_date,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE(order_date)
ORDER BY order_date;

-- 10. List total payments received per payment method 

select * from payments;
select method,sum(amount_paid) as total_payments from payments group by method;
-- 1. Retrieve order details along with the customer name (INNER JOIN) 
select * from customers;

select customers.name,customers.email,customers.phone,orders.order_id,orders.order_date from customers
inner join orders on customers.customer_id=orders.customer_id;
-- 2. Get list of products that have been sold (INNER JOIN with order_items) 
select * from order_items; -- order_item_id,order_id,product_id,quantity,item_price
select * from orders;-- order_id,customer_id,order_date,status,total_amount
select order_items.order_item_id,order_items.product_id,order_items.quantity,orders.order_date,orders.status 
from order_items 
Inner join orders on order_items.order_id-orders.order_id;

-- 3. List all orders with their payment method (INNER JOIN) 
select * from payments; -- payment_id,order_id,payment_date,amount_paid,method
select * from orders;-- order_id,customer_id,order_date,status,total_amount
select orders.order_date,orders.status,orders.total_amount,payments.method,payments.payment_id from orders 
inner join payments on orders.order_id=payments.order_id;
-- 4. Get list of customers and their orders (LEFT JOIN) 
select * from customers; -- customer_id,name,email,phone,created_at
select * from orders; -- order_id,customer_id,order_date,status,total_amount
select customers.name,customers.email,customers.phone,orders.order_id,orders.order_date,orders.status from customers
left join orders on customers.customer_id = orders.customer_id;

-- 5. List all products along with order item quantity (LEFT JOIN) 
select * from products; -- product_id,name,category,price,stock_quantity,added_on
select * from order_items; -- order_item_id,order_id,product_id,quantity,item_price
select products.name,products.category,order_items.order_id,order_items.quantity,order_items.item_price from products
left join order_items on products.product_id=order_items.product_id;

-- 7. Combine data from three tables: customer, order, and payment 

select * from payments; -- payment_id,order_id,payment_date,amount_paid,method
select * from orders;-- order_id,customer_id,order_date,status,total_amount
select * from customers; -- customer_id,name,email,phone,created_at

select payments.payment_id,payments.order_id,orders.order_id,orders.customer_id from payments 
join orders on payments.order_id=orders.order_id
join customers on orders.customer_id=customers.customer_id;
select * from products;
select * from products where price>(select avg(price) from products);
-- 2. Find customers who have placed at least one order
select * from orders;
SELECT DISTINCT
    c.customer_id,
    c.name
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;
    -- 3. Show orders whose total amount is above the average for that customer 
select * from payments; -- payment_id,order_id,payment_date,amount_paid,method
select * from orders;-- order_id,customer_id,order_date,status,total_amount
select * from customers; -- customer_id,name,email,phone,created_at
select * from products; -- product_id,name,category,price,stock_quantity,added_on
select * from order_items; -- order_item_id,order_id,product_id,quantity,item_price
select total_amount from orders where total_amount>(
select avg(total_amount) from customers);
WITH customer_avg AS
(
    SELECT
        customer_id,
        AVG(total_amount) AS avg_order_amount
    FROM orders
    GROUP BY customer_id
)
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.total_amount,
    ca.avg_order_amount
FROM orders o
JOIN customer_avg ca
    ON o.customer_id = ca.customer_id
WHERE o.total_amount > ca.avg_order_amount;
-- 4. Display customers who haven’t placed any orders 

SELECT c.customer_id, c.name, c.email
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT p.product_id, p.name
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
-- 6. Show highest value order per customer 
SELECT customer_id, order_id, order_date, total_amount
FROM (
    SELECT 
        customer_id,
        order_id,
        order_date,
        total_amount,
        RANK() OVER (
            PARTITION BY customer_id 
            ORDER BY total_amount DESC
        ) AS rnk
    FROM orders
) x
WHERE rnk = 1;
-- 7. Highest Order Per Customer (Including Names) 
SELECT 
    customer_id,
    customer_name,
    order_id,
    order_date,
    total_amount
FROM (
    SELECT 
        c.customer_id,
        c.name AS customer_name,
        o.order_id,
        o.order_date,
        o.total_amount,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_id
            ORDER BY o.total_amount DESC
        ) AS rn
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
) x
WHERE rn = 1;
-- 1. List all customers who have either placed an order or written a product review 
SELECT customer_id
FROM orders

UNION

SELECT customer_id
FROM product_reviews;

-- 2. List all customers who have placed an order as well as reviewed a product [intersect not supported] 
SELECT DISTINCT c.customer_id, c.name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN product_reviews r
    ON c.customer_id = r.customer_id;
    
    SELECT 
    p.payment_id,
    p.order_id,
    p.payment_date,
    p.amount_paid,
    p.method,
    o.order_date,
    o.status,
    o.total_amount
FROM orders o
RIGHT JOIN payments p
    ON o.order_id = p.order_id;
    
    SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;