
create database customer_churn;

#Query 1: Considering the top 5 groups with the highest average monthly charges among churned customers, how can personalized offers be tailored based on age, gender, and contract type to potentially improve customer retention rates
select * FROM customer_churn_table;
DESCRIBE customer_churn_table;
SELECT Age, Gender, Contract, 
       AVG(`Monthly Charge`) AS avg_monthly_charges
FROM customer_churn_table
WHERE `Churn Label` = 'Yes'
GROUP BY Age, Gender, Contract
ORDER BY avg_monthly_charges DESC
LIMIT 5;

#Explanation Query 1:  `Churn Label` = 'Yes' filters the data to only include churned customers. AVG(MonthlyCharges) calculates the average monthly charges for each group. GROUP BY Age, Gender, ContractType groups customers based on those attributes. ORDER BY AvgMonthlyCharges DESC sorts the groups by average monthly charges in descending order. LIMIT 5 restricts the results to the top 5 groups.
#Query 2: What are the feedback or complaints from those churned customers
SELECT distinct`Churn Reason`
FROM customer_churn_table
WHERE `Churn Label` = 'Yes';

     #OR
SELECT 'Churn Reason', COUNT(*) AS number_of_complaints
FROM customer_churn_table
WHERE 'Churn Reason' IS NOT NULL
GROUP BY 'Churn Reason'
ORDER BY number_of_complaints DESC;
#Explanation Query 2 This query retrieves the Churn Reason column for all customers who have churned (Churn Label is 'Yes').It will return a list of feedback or complaints from those churned customers without any aggregation.
#Query 3: How does the payment method influence churn behavior?
SELECT `Payment Method`, 
       COUNT(*) AS total_customers,
       SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
       (SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS churn_percentage
FROM customer_churn_table
GROUP BY `Payment Method`
ORDER BY churn_percentage DESC;
#Explanation Query 3
 #SELECT Clause:This part specifies the columns you want to retrieve from the dataset: COUNT(*) AS total_customers: This counts the total number of customers for each payment method. The result will be labeled as total_customers. SUM(CASE WHEN Churn Label = 'Yes' THEN 1 ELSE 0 END) AS churned_customers:
#This part uses a CASE statement to sum the number of churned customers for each payment method.
#When Churn Label equals 'Yes', it adds 1 to the count; otherwise, it adds 0.
#The result is labeled as churned_customers, representing the total number of customers who have churned for each payment method.
#(SUM(CASE WHEN Churn Label = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS churn_percentage:This calculates the churn percentage for each payment method. It divides the number of churned customers by the total number of customers and multiplies by 100 to convert it to a percentage. The result is labeled as churn_percentage, showing the proportion of customers who churned for each payment method.
#FROM customer_churn_table:This specifies the table from which the data is being selected.
#GROUP BY Payment Method: This clause groups the results by the Payment Method, so all calculations (total customers, churned customers, and churn percentage) are done for each payment method individually.
#ORDER BY churn_percentage DESC: This orders the final results by the churn percentage in descending order. It allows you to see which payment methods have the highest churn rates at the top of the results.









#SQL Querries and their explanation
#Medium article stating details analysis
# Github repository for the project

