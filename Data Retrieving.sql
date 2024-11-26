-- Order of commands while writing query
/* 
SELECT
FROM
WHERE 
GROUP BY
HAVING
ORDER BY
LIMIT
*/

-- GROUP BY:
select * from subscription_packages;

-- Exercise1: Find the number of packages and the average monthly rate for each service_type in subscription_packages.
select service_type, count(*), 
round(avg(monthly_rate), 2)
from subscription_packages
group by service_type
order by service_type; 


-- Order by service type and round off the result of average to two dp.
-- Exercise2: Find the most expensive and the least expensive package in each service_type
select * from customer_usage;
-- Exercise3: Find the total minutes_used and total data_used for each service_type in customer_usage. Round off your results to two dp
select service_type, sum(minutes_used) as total_minutes,
round(sum(data_used),2) as total_data
from customer_usage
group by service_type;

select * from customer_usage;

#--Exercise4: Find the total data and total minutes used per customer, per service type.
select customer_id, service_type, sum(minutes_used) as total_minutes,  
round(sum(data_used),2) as total_data
from  customer_usage
group by customer_id, service_type
order by customer_id; 

-- Exercise5: Find the total number of subscriptions for each customer. Order by total number of subscriptions in desc order
select * from customer_subscriptions;

select customer_id, count(subscription_id) as Total_Subscriptions
from customer_subscriptions
group by customer_id
order by 2 desc; 


-- Exercise6: List the total number of feedback entries for each rating level in customer_feedback
select * from customer_feedback;

select rating, count(feedback_id) as feedback_total
from customer_feedback
where rating <> ""
group by rating
order by rating; 


-- Exercise7: Calculate the total minutes used by all customers for mobile services 
-- we can do this with where without group by (faster)

select service_type, sum(minutes_used) as total_minutes
from customer_usage
where service_type = "mobile";

-- we can use group by and then filter with having (slower)

select service_type, sum(minutes_used) as total_minutes
from customer_usage
group by service_type
having service_type = "mobile";

-- we can do this with where without group by (faster)
-- we can use group by and then filter with having (slower)

select * from customer_usage; 
-- Exercise8: which customers used all the service_types? Show results ordered by customer_ids
select customer_id, count(distinct service_type) as service_used 
from customer_usage
group by customer_id
having service_used = 3
order by customer_id; 

select * from customer_subscriptions;
-- Exercise9: Out of customers who have 4 total subscriptions, show the three with the largest customer_ids
select customer_id, count(subscription_id) as total_subscriptions
from customer_subscriptions
group by customer_id
having total_subscriptions = 4
order by customer_id desc
limit 3; 
-- Exercise10: List the total number of feedback entries for ratings 4 and 5 within each service_type.
select * from customer_feedback;

select rating, service_type, count(feedback_id) as total_feedback
from customer_feedback
where rating <> '' and service_type <> ''
group by rating, service_type
having rating in (4,5)
order by rating; 





-- CASE STATEMENTS:
select * from customer_usage;
-- label each customer's total data_used as low when < 1000, moderate when >= 1000 and < 2500, else heavy 
select customer_id, sum(data_used) as total_data, 
CASE
	When sum(data_used) < 1000 then "Low usage"
    when sum(data_used) >= 1000 and sum(data_used) < 2500 then "Moderate usage"
	else "Heavy usage"
end as Usage_category 
from customer_usage
group by customer_id
order by 2; 

select * from customer_invoice; 
-- Exercise: Make a payment_status column showing each customer’s billing status
-- show ‘Paid’ if the payment_date is not empty, and ‘Unpaid’ otherwise. order by payment_status
select customer_id, payment_date, 
case when payment_date <> '' then "paid"
	else "Unpaid"
    end as payment_status00
from customer_invoice
order by 3; 
