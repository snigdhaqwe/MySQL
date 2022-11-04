use sales;
create table sales
(
purchase_number int auto_increment,
date_of_purchase date,
customer_id int,
item_code varchar(10),
primary key (purchase_number)
);
drop table customers;

create table customers
(
customer_id int,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
number_of_complaints int,
primary key(customer_id)
);

create table items
(
item_code VARCHAR(255),  
item VARCHAR(255),  
unit_price NUMERIC(10,2),  
company­_id VARCHAR(255), 
primary key(item_code)
);
CREATE TABLE companies   
(
company_id varchar(255),   
company_name varchar(255),  
headquarters_phone_number int(12),   
primary key (company_id)   
); 

drop table sales;
drop table companies;
drop table items;
drop table customers;

create table customers
(
customer_id int,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
number_of_complaints int,
primary key(customer_id)
);

alter table customers
add unique key(email_address);

alter table customers
drop index email_address;
drop table customers;
CREATE TABLE customers (

    customer_id INT AUTO_INCREMENT,

    first_name VARCHAR(255),

    last_name VARCHAR(255),

    email_address VARCHAR(255),

    number_of_complaints INT,

PRIMARY KEY (customer_id)

);
ALTER TABLE customers

ADD COLUMN gender ENUM('M', 'F') AFTER last_name;

INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)

VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0)

;
alter table customers
change column number_of_complaints number_of_complaints int default 0;
insert into customers(first_name,last_name,gender)
values('Peter','Figaro','M');
select * from customers;
alter table customers
alter column number_of_complaints drop default;

create table companies
(
company_id varchar(255),
company_name varchar(255) default 'X',
headquarters_phone_number varchar(255) unique key
);
insert into companies(company_id,headquarters_phone_number)
values('1','1234567890');
select * from companies;
insert into companies(company_id,headquarters_phone_number)
values(2,1523645879);
select * from companies;
drop table companies;
create table companies
(
company_id varchar(255),
company_name varchar(255) default 'X',
headquarters_phone_number varchar(255) unique key
);
alter table companies
add primary key(company_id);



