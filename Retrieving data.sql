Create database Customer_Dataset; 

select * from customer_invoice; 

select * from customers;

#Excerise1: Retrieve all columns and rows from all the customers table
select * from customers; 

#Excercise 2: List all full name and sigup dates of the customer

select concat(first_name," ",last_name) as Full_name, signup_date
from customers; 

#Fetch all unique first_name from the customer table
select distinct first_name as unique_first_name 
from customers; 

select * from customers;

#Q4: Count the number of unique first_name in the customer table 
select count(distinct first_name) as unique_first_name 
from customers;

#q5: Display all columns from the customer_invoice table 
select * from customer_invoice; 

#Q6 Show only the invoice_id and the amount_due from the customer_invoice table
select invoice_id, amount_due
from customer_invoice; 

#WHERE 
#Q7: Identify customer who live in Alabama

select * 
from customers
where address like "%Alabama"; 

#Q8: Find invoices in the customer_invoice table with an amount_due greater than 1000; 

select * from customer_invoice; 

select * 
from customer_invoice
where amount_due = 1000; 

#Q9: Show first_name, last_name, and address from customer_ids 3,15, and 34. 
select first_name, last_name, address 
from customers
where customer_id in (3, 15, 34); 

#Q10: Identify customers who live in either Adamschester or new Paris and their Phone numbers starts with 92. 
select * from customers where phone_number like "%92%" and (address like "%New Paris%" or address like "%Adamschester%"); 

#Order BY
#Ex:1: Display invoices from the customer_invoice table ordered by amount_due in descending order 
select * 
from customer_invoice
order by amount_due desc; 

#Ex:2: Display imvoices from customer_invoice table ordered by customer_id; 
select * 
from customer_invoice
order by customer_id;

#LIMIT
#Ex:1: Show only the first 10 customer_id from customers; 
select * 
from customers
order by customer_id
limit 10; 

#List the top 5 highest amount_due from the customer_invoice table;
select * 
from customer_invoice
order by amount_due
desc limit 5; 
#Retrieve the invoices with the 3 latest payments made by customers.
select *
from customer_invoice
order by payment_date
desc limit 3;
#List all customers except those living in Washington, Texas, New Mexico and Indiana
select * 
from customers
where address Not in ('Washington', 'Texas', 'New Mexico', 'Indiana');
#List all customers except those living in Washington, Texas, New Mexico and Indiana
select *
from customers
where address <> 'Washington'
and address <> 'Texas'
and address <> 'New Mexico'
and address <> 'Indiana';
# WHERE IN
#Find amount_dues greater than 1000 in the first 100 customer_ids and order the result by customer_id
SELECT customer_id, amount_dues
FROM Customers
WHERE amount_dues > 1000
  AND customer_id IN (
    SELECT customer_id
    FROM Customers
    ORDER BY customer_id
    LIMIT 100
  )
ORDER BY customer_id;