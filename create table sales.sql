use snigdha;
create table sales_01
(
purchase_number int not null primary key auto_increment,
date_of_purchase date not null,
customer_id int,
item_code varchar(10) not null
);
