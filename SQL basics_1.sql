select * from customers;
show databases;
create database DA_June_2026_1;
drop database DA_June_2026_1;
create database Test_DB;
create table employee(
ID int,
Name varchar(30),
Experience int
);
create table Emp_Copy as select ID, Name, Experience from employee; 
describe Emp_Copy;
-- Alter to add column
alter table Emp_Copy add column Location int;

alter table Emp_Copy modify Location varchar(20);
alter table Emp_Copy drop column Location;
describe Emp_Copy;
CREATE TABLE emp (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20)
);
