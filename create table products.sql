use sales;
create table products(
product_id int not null auto_increment primary key,
product_name varchar(20),
product_price int,
warehouse_id int
);
