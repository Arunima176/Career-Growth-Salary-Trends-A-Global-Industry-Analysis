create database SalarySurveyDB;
use SalarySurveyDB;
CREATE TABLE SalarySurvey (
    Age_Range VARCHAR(100),
    Industry VARCHAR(300), 
    Job_Title VARCHAR(300), 
    Annual_Salary DECIMAL(10,2), 
    Currency VARCHAR(10), 
    State VARCHAR(100), 
    Years_of_Professional_Experience_Overall VARCHAR(20), 
    Years_of_Professional_Experience_in_Field VARCHAR(20), 
    Highest_Level_of_Education_Completed VARCHAR(200), 
    Gender VARCHAR(100)
);
ALTER TABLE SalarySurvey MODIFY COLUMN Annual_Salary INT;
select * from SalarySurvey;
select Industry,Gender,Avg(Annual_Salary) as Avg_AnnualSalary from SalarySurvey 
group by Industry,Gender
order by Avg_AnnualSalary desc;
use SalarySurveydb;
TRUNCATE TABLE SalarySurveydb.SalarySurvey;
DROP TABLE SalarySurveydb.SalarySurvey;
CREATE TABLE SalarySurvey (
    Age_Range VARCHAR(50),
    Industry VARCHAR(255),
    Job_Title VARCHAR(255),
    Annual_Salary INT,
    Additional_Monetary_Compensation INT,
    Currency VARCHAR(50),
    Country VARCHAR(100),
    City VARCHAR(100),
    Years_of_Professional_Experience_Overall VARCHAR(50),
    Years_of_Professional_Experience_in_Field VARCHAR(50),
    Highest_Level_of_Education_Completed VARCHAR(100),
    Gender VARCHAR(50)
);
select * from salarysurvey;
# query 1
select Industry,Gender,Avg(Annual_Salary) as Avg_Annual_salary From salarysurvey 
group by Industry,gender
order by Avg_Annual_salary Desc;

# query 2

select job_title,Sum(Annual_Salary+Additional_Monetary_Compensation) as Total_Compensation from salarysurvey
group by Job_title
order by Total_Compensation Desc;

# query 3

select Highest_Level_of_Education_Completed,Avg(Annual_salary) as Avg_Salary,Min(Annual_salary) as Minimum_salary,Max(Annual_salary) as Maximum_salary from salarysurvey 
group by Highest_Level_of_Education_Completed order by Avg_salary Desc;

# query 4

select Industry,Years_of_Professional_Experience_Overall,count(*) as Employee_count from salarysurvey 
group by Industry,Years_of_Professional_Experience_Overall
order by Years_of_Professional_Experience_Overall Desc;

# query 5 

WITH SalaryRanks AS (
    SELECT Age_Range, Gender, Annual_Salary,
           RANK() OVER (PARTITION BY Age_Range, Gender ORDER BY Annual_Salary) AS rnk,
           COUNT(*) OVER (PARTITION BY Age_Range, Gender) AS total_count
    FROM SalarySurvey
)
SELECT Age_Range, Gender, AVG(Annual_Salary) AS Median_Salary
FROM SalaryRanks
WHERE rnk IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2))
GROUP BY Age_Range, Gender
ORDER BY Age_Range ASC, Gender ASC;


select * from salarysurvey;

# query 6 

select Country,Job_Title, Annual_Salary from (
select Country,Job_Title,Annual_Salary,rank() over (partition by Country order by Annual_Salary desc) as rank_in_country
from salarysurvey ) AS ranked_jobs
where rank_in_country = 1;


# query 7

select city,Industry,Avg(Annual_salary) as Avg_Annual_salary from salarysurvey 
group by city,Industry 
order by industry Asc;

# query 8

select gender,(count(case when Additional_Monetary_Compensation>0 then 1 end)*100/count(*)) as Percentage_With_Compensation from salarysurvey 
group by gender 
order by Percentage_With_Compensation desc;


# query 9
select job_title,Years_of_Professional_Experience_in_Field,sum(Annual_salary+Additional_Monetary_Compensation) as Total_Compensation from salarysurvey 
group by job_title,Years_of_Professional_Experience_in_Field 
order by Total_Compensation Desc;
select * from salarysurvey;

# query 10
select Industry,gender,Highest_Level_of_Education_Completed,avg(Annual_Salary) as Avg_Annual_salary from salarysurvey 
group by Industry,Highest_Level_of_Education_Completed,gender
order by Avg_Annual_salary;





















