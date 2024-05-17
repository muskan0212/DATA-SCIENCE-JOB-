USE N1;

CREATE TABLE DATA_SCIENCE_JOB (
work_year INT,
job_title VARCHAR(40),
job_category VARCHAR(30),
salary_currency VARCHAR(9),
salary INT,
salary_in_usd INT,
employee_residence VARCHAR(40),
experience_level VARCHAR(30),
employment_type VARCHAR(20),
work_setting VARCHAR(15),
company_location VARCHAR(40),
company_size VARCHAR(4));

LOAD DATA INFILE
'E:/jobs_in_data_science.csv'
into table data_science_job
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM DATA_SCIENCE_JOB;

##Q-1 Find Salary trends with respect to work year?
SELECT SUM(SALARY) AS SALARY_TRENDS, WORK_YEAR FROM DATA_SCIENCE_JOB GROUP BY WORK_YEAR;

##Q-2 Find salary distribution across various specialized Roles namley Data Scientist, Data Engineer and Data Analyst
SELECT SUM(SALARY) AS SALARY_DISTN, JOB_TITLE FROM DATA_SCIENCE_JOB WHERE 
JOB_TITLE IN ("DATA SCIENTIST","DATA ENGINEER", "DATA ANALYST") GROUP BY JOB_TITLE;

##Q-3 Find unique Job Title for which salary range is between 80,000 and 2,00,000?
SELECT distinct(job_title), salary from data_science_job where salary between 80000 and 200000;

##Q-4 Find Employee Residence whose Salary is in 'USD' and Experience level as 'Senior'?
select employee_residence, salary_CURRENCY, experience_level from data_science_job 
where salary_currency = "USD" AND EXPERIENCE_LEVEL = "SENIOR";

##Q-5 Find Total Salary in USD for work setting as 'In-person'?
SELECT SUM(SALARY_IN_USD) AS TOTAL_SALARY, WORK_SETTING
FROM DATA_SCIENCE_JOB WHERE WORK_SETTING = "IN-PERSON";

##Q-6 Find the most common Job category with respect to Job Title?
SELECT MAX(JOB_CATEGORY) AS COMMON_JOB, JOB_TITLE FROM DATA_SCIENCE_JOB GROUP BY JOB_TITLE;

##Q-7 Find average salary based on Employment type with respect to work year and Job Title?
SELECT AVG(SALARY) AS AVG_SALARY, EMPLOYMENT_TYPE, WORK_YEAR, JOB_TITLE FROM DATA_SCIENCE_JOB
group by EMPLOYMENT_TYPE, WORK_YEAR, JOB_TITLE;

##Q-8 Find ratio of medium to large for company size
SELECT COUNT(case when COMPANY_SIZE = 'M' then 1 else 0 end)/count(*) as MEDIUM_RATIO,
       COUNT(case when COMPANY_SIZE = 'L' then 1 else 0 end)/count(*) as LARGE_RATIO
FROM DATA_SCIENCE_JOB;

##Q-9 Find Job Title with respect to work year where 'salary number' is equal to 'salary in USD number'
SELECT JOB_TITLE, SALARY, SALARY_IN_USD FROM DATA_SCIENCE_JOB WHERE EXISTS
(SELECT SALARY FROM DATA_SCIENCE_JOB WHERE DATA_SCIENCE_JOB.SALARY =  DATA_SCIENCE_JOB.SALARY_IN_USD);

##Q-10 Classify unique experience level for all records
SELECT distinct EXPERIENCE_LEVEL FROM DATA_SCIENCE_JOB;