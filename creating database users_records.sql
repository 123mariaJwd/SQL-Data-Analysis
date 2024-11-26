
create database users_records; 

use users_records; 

create	table users(id int primary Key, name Varchar(100), age INT); 
#  * is equal to all in SQL 

insert into users ( id, name, age) 
values (101, 'Fatima', 22), 
(102, 'Hania', 23), 
(103, 'Sakina', 21); 

select * from users; 

#list only the name and age of user; 
select name, age from users; 

#Display user's name and age if age is greater than 22

select name, age
from users
where age > 22; 



#Sort the data by age in ascending order;
#Use alias from name and age column 
#show only top two records; 