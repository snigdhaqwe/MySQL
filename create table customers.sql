use sales;
create table customers
(
customer_id int not null auto_increment primary key,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
number_of_complaints int
);