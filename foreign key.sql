use sales;
create table sales(
purchase_number int auto_increment,
date_of_purchase date,
customer_id int,
item_code varchar(10),
primary key(purchase_number),
foreign key(customer_id) references customers(customer_id) on delete cascade
);

