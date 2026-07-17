CREATE DATABASE practice_db;
USE practice_db;
select * from superstore_data;
describe superstore_data;
drop table superstore_data;
select * from customers; 
insert into customers values
(1,"Snigdha","Patel"),
(2,"Smriti","Dash"),
(3,"Rimpy","Patel"),
(4,"Pratima", "Nayak");
INSERT INTO customers (customer_id, first_name, last_name)
VALUES
(1, 'Snigdha', 'Patel'),
(2, 'Smriti', 'Dash'),
(3, 'Rimpy', 'Patel'),
(4, 'Pratima', 'Nayak');
alter table customers
add column order_qty int;
update customers
set order_qty=1
where first_name="Snigdha";
SELECT @@SQL_SAFE_UPDATES;
SET SQL_SAFE_UPDATES = 0;
update customers
set order_qty=2
where first_name="Smriti";
update customers
set order_qty=3
where first_name="Rimpy";
update customers
set order_qty=4
where first_name="Pratima";
select * from customers;
alter table customers
drop column email; 
select customer_id,first_name,last_name,order_qty,count(*)
as order_count from customers
group by customer_id;

select * from emp;
alter table emp add column hiredate date;
select * from emp;
update emp set hiredate='07-17-2026'
where name= 'Snigdha';
UPDATE emp
SET hiredate = '2026-07-17'
WHERE name = 'Snigdha';
UPDATE emp
SET hiredate = '2026-07-16'
WHERE name = 'Pratima';
UPDATE emp
SET hiredate = '2025-07-15'
WHERE name = 'Smriti';
UPDATE emp
SET hiredate = '2025-07-15'
WHERE name = 'Rimpy';
select * from emp;
select * from emp
where year(hiredate)=2026;
select * from emp
where year(hiredate)="2025";

