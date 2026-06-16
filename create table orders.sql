use sales;
create table orders(
order_id int not null auto_increment primary key,
order_date date,
order_info int,
order_value int,
order_currency varchar(10)
);
