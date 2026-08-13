-- create database SQL_MINI_PROJECT;
-- USE SQL_MINI_PROJECT;

CREATE TABLE customers ( 
    customer_id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(100) NOT NULL, 
    email VARCHAR(100) NOT NULL UNIQUE, 
    phone VARCHAR(15), 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP 
); 
CREATE TABLE products ( 
    product_id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(100) NOT NULL, 
    category VARCHAR(50) NOT NULL, 
    price DECIMAL(10,2) NOT NULL, 
    stock_quantity INT NOT NULL DEFAULT 0, 
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP 
); 
CREATE TABLE orders ( 
    order_id INT PRIMARY KEY AUTO_INCREMENT, 
    customer_id INT, 
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
    status VARCHAR(20) DEFAULT 'Pending', 
    total_amount DECIMAL(10,2), 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
); 
CREATE TABLE order_items ( 
    order_item_id INT PRIMARY KEY AUTO_INCREMENT, 
    order_id INT, 
    product_id INT, 
    quantity INT NOT NULL CHECK (quantity > 0), 
    item_price DECIMAL(10,2) NOT NULL, 
    FOREIGN KEY (order_id) REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
); 
CREATE TABLE payments ( 
    payment_id INT PRIMARY KEY AUTO_INCREMENT, 
    order_id INT, 
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
    amount_paid DECIMAL(10,2) NOT NULL CHECK (amount_paid > 0), 
    method VARCHAR(20) NOT NULL, 
    FOREIGN KEY (order_id) REFERENCES orders(order_id) 
); 
CREATE TABLE product_reviews ( 
review_id INT PRIMARY KEY AUTO_INCREMENT, 
product_id INT, 
customer_id INT, 
rating INT NOT NULL, 
review_text TEXT, 
review_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
FOREIGN KEY (product_id) REFERENCES products(product_id), 
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
); 