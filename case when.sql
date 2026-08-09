select * from payment;
select distinct(amount),
CASE 
when amount < 3.00 then "Low Rental"
when amount between 3.1 and 4.99 then "Medium rental"
else "High rental"
end as rental_category
from payment;
