#-- 1. Create a database named EmployeeManagement.
create database Employee_Management;
#--2. Select the EmployeeManagement database for use.
select * from Employee_Management;
#-- 3. Create a table named Employees with the following columns:
	--   EmployeeID (Primary Key, Auto Increment)
	--   FirstName
	--   LastName
	--   Department
	--   Position
	--   Salary
	--   DateOfHire
	--   Location
    use Employee_management;
    create table Employees(Employee_ID int auto_increment primary key, First_name varchar(50), Last_name varchar(50), department varchar(50), position varchar(50), salary int, date_of_hire DATE,  location varchar(50));
  insert into Employees (Employee_ID,  First_name, Last_name, department,  position, salary, date_of_hire , location)
 values (1,'Ali', 'Khan', 'Finance', 'Analyst', 60000, '2022-03-15', 'Karachi'),
    (2,'Fatima', 'Rashid', 'HR', 'Manager', 80000, '2021-07-22', 'Lahore'),
    (3, 'Ahmed', 'Butt', 'IT', 'Developer', 70000, '2023-01-10', 'Islamabad'),
    (4, 'Sara', 'Sheikh', 'Marketing', 'Coordinator', 50000, '2020-06-05', 'Karachi'),
    (5, 'Ayesha', 'Iqbal', 'Finance', 'Accountant', 65000, '2022-11-01', 'Lahore'),
    (6, 'Bilal', 'Zafar', 'HR', 'Recruiter', 55000, '2021-09-17', 'Islamabad'),
    (7, 'Nida', 'Malik', 'IT', 'System Admin', 75000, '2022-04-28', 'Karachi'),
    (8, 'Usman', 'Rizvi', 'Marketing', 'Manager', 85000, '2020-02-14', 'Lahore'),
    (9, 'Hassan', 'Shah', 'Finance', 'Consultant', 90000, '2019-05-21', 'Karachi'),
    (10, 'Zainab', 'Hassan', 'HR', 'Assistant', 45000, '2023-07-19', 'Islamabad'),
    (11, 'Omar', 'Farooq', 'IT', 'Support Engineer', 60000, '2021-08-23', 'Lahore'),
    (12, 'Mariam', 'Yousaf', 'Marketing', 'Content Writer', 48000, '2022-01-10', 'Islamabad'),
    (13, 'Arif', 'Nawaz', 'Finance', 'Advisor', 72000, '2021-11-30', 'Karachi'),
    (14, 'Rabia', 'Khan', 'HR', 'Training Specialist', 67000, '2022-05-14', 'Lahore'),
    (15, 'Hiba', 'Ali', 'IT', 'Network Admin', 74000, '2021-03-25', 'Islamabad'),
    (16, 'Waqar', 'Aziz', 'Marketing', 'Social Media Manager', 68000, '2020-09-18', 'Karachi'),
    (17, 'Saad', 'Mirza', 'Finance', 'Investment Analyst', 78000, '2023-04-11', 'Lahore'),
    (18, 'Nimra', 'Yasin', 'HR', 'HR Coordinator', 52000, '2021-06-01', 'Islamabad'),
    (19, 'Raza', 'Siddiqui', 'IT', 'Data Analyst', 72000, '2022-02-20', 'Karachi'),
    (20, 'Asma', 'Khalid', 'Marketing', 'Brand Manager', 82000, '2019-12-02', 'Lahore'),
    (21, 'Faisal', 'Haider', 'Finance', 'Account Manager', 76000, '2021-10-12', 'Islamabad'),
    (22, 'Hira', 'Anwar', 'HR', 'Recruitment Lead', 83000, '2020-07-28', 'Karachi'),
    (23, 'Imran', 'Qureshi', 'IT', 'DevOps Engineer', 87000, '2019-03-15', 'Lahore'),
    (24, 'Bushra', 'Saeed', 'Marketing', 'SEO Specialist', 62000, '2022-08-07', 'Islamabad'),
    (25, 'Shahid', 'Iqbal', 'Finance', 'Internal Auditor', 75000, '2021-12-19', 'Karachi'),
    (26, 'Ammar', 'Khan', 'HR', 'Compensation Analyst', 67000, '2021-05-23', 'Lahore'),
    (27, 'Noor', 'Zaman', 'IT', 'Software Engineer', 78000, '2022-10-01', 'Islamabad'),
    (28, 'Sana', 'Hameed', 'Marketing', 'PR Specialist', 70000, '2020-11-09', 'Karachi'),
    (29, 'Rehan', 'Aslam', 'Finance', 'Budget Analyst', 69000, '2021-03-15', 'Lahore'),
    (30, 'Uzma', 'Rauf', 'HR', 'Employee Relations Specialist', 62000, '2022-06-22', 'Islamabad');

    
    set sql_safe_updates=0;
DESCRIBE employees;
UPDATE employees 
SET date_of_hire = STR_TO_DATE(date_of_hire, '%Y-%m-%d')
WHERE date_of_hire IS NOT NULL;

ALTER TABLE employees
MODIFY COLUMN date_of_hire DATE;
-- 6. Retrieve all employees in the 'HR' department.
select * from employees
where department= 'HR';
-- 7. Retrieve employees with a salary greater than 70,000 in Year 2022.
select * from employees
where salary>70000
and date_of_hire like"%2022%";
-- 8. Add a new column named AnnualBonus to the Employees table
alter table employees
add column Annual_Bonus int;
-- 9. Update the AnnualBonus column based on the following conditions:
--   If the salary is above 75,000, the bonus is 10% of the salary.
UPDATE employees
SET Annual_Bonus=salary * 0.10
WHERE salary > 75000;
--   If the salary is between 60,000 and 75,000, the bonus is 7% of the salary.
UPDATE employees
Set Annual_Bonus=salary *0.70
WHERE salary BETWEEN 60000 AND 75000;
--   If the salary is below 60,000, the bonus is 5% of the salary.
Update Employees
set Annual_Bonus=salary * 0.05
where salary < 60000;
select * from Employees;
-- 10. Calculate the total payroll (sum of salaries) for the 'IT' department.
select sum(salary) as Total_Payroll
from employees
where department='IT'
group by department;
-- 11. List the top 3 employees by salary.
select Employee_ID 
from employees
group by Employee_ID
order by salary desc
limit 3;
-- 12. Find the average salary for each department.
select department,avg (salary) as Average_Salary
from Employees
group by department;
select * from Employees;
-- 13. How many employees were hired in the each year.
Select year(date_of_hire) As hire_year, count(Employee_ID) AS number_of_employees
from employees
group by YEAR(date_of_hire)
order by hire_year;
   #3OR
   
select * from employees;
select year(date_of_hire) as year_of_hire, count(*) as employees_hired 
from employees
group by year(date_of_hire)
order by year(date_of_hire);
-- 14. Use the CASE statement to create a temporary column SalaryGrade where:
--    Salaries above 80,000 are classified as 'A'
alter table Employees
add Salary_Grade varchar(50);
select Employee_ID,salary, 
CASE
when salary > 80000 THEN "A"
when salary Between 60000 and 80000 Then "B"
else "C"
end as Salary_Grade
from Employees;
-- 15. Identify employees who have been with the company for more than 3 years.(Hint. subtract year from the current year)
select employee_id, First_name, Last_name, date_of_hire
from Employees
where
year(curdate())-year(date_of_hire)>3;





