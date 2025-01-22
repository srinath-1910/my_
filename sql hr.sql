create database projects;

use projects;

select * from hr;
alter table hr
change column ï»¿id emp_id varchar(20) null;
describe hr;      
select birthdate from hr;
set sql_safe_updates =0;
update hr
set birthdate = case
when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;
alter table hr
modify column birthdate date;
select birthdate from hr;
alter table hr
drop column termdate;
update hr
set hire_date = case
when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;
alter table hr
modify column hire_date date;
alter table hr
add column age int;
update hr
set age= timestampdiff(year,birthdate,curdate());
select birthdate ,age from hr;
select 
min(age) as youmgest,
max(age) as oldest
from hr;
select count(*) from hr where age <18;
-- questions
-- 1.what is the gender nreakdown of employes in the companey?
select gender ,count(*) as count 
from hr 
where age >=18 group by gender;

-- 2.what is the race/ethinicity of employes in the companey?
select race, count(*) as count
from hr
 where age >=18 group by race 
order by count(*) desc;

-- 3.what is the age distributioin of employes in the conpany?
select 
min(age) as youmgest,
max(age) as oldest
from hr
 where age >=18;
 select 
 case
 when age>=18 and age<=24 then '18-24'
 when age>=25 and age<=34 then '25-34'
 when age>=35 and age<=44 then '35-44'
 when age>=45 and age<=54 then '45-54'
 when age>=55 and age<=64 then '55-64'
 else '65+'
 end as age_group,count(*) as count
 from hr 
 where age>=18 
 group by age_group
 order by age_group;
 
  select 
 case
 when age>=18 and age<=24 then '18-24'
 when age>=25 and age<=34 then '25-34'
 when age>=35 and age<=44 then '35-44'
 when age>=45 and age<=54 then '45-54'
 when age>=55 and age<=64 then '55-64'
 else '65+'
 end as age_group,gender,
 count(*) as count
 from hr 
 where age>=18 
 group by age_group,gender
 order by age_group,gender;
 
 -- 4. how many employes work at headquartes at remote locatiions?
 select location,count(*) as count
 from hr where age>=18
 group by location;
 
 -- 5.how does the gender distrinution vart across departments?
 select department, gender, count(*)as count
 from hr where age>=18 
 group by department,gender
 order by department;
 
 -- 6.what is the distribution of job titles across the companey ?
 select jobtitle ,count(*) as count 
 from hr 
 where age >=18 
 group by jobtitle
 order by jobtitle desc;
 
 -- 7. What is the distribution of employees across locations by state?
 select location_state, count(*) as count
 from hr 
 where age>=18
 group by location_state
 order by count desc;

 