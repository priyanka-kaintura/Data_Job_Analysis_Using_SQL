SELECT '12-03-2004';
-- this produces the output as a string

-- to convert this output to date we can typecast it to DATE as below
SELECT '12-03-2004'::DATE;
SELECT DATE '12-03-2004';

-- Similarly we can make multiple data and convert them into desired data type using typecasting
SELECT 
'Priyanka'::VARCHAR(20),
'200'::INT,
'20.69'::REAL,
'12-03-2004'::DATE;

--  OR

SELECT 
VARCHAR(20) 'Priyanka',
INT '200',
REAL '20.69',
DATE '12-03-2004';

SELECT *FROM job_postings_fact LIMIT 10;

-- Working on the posted date column on job_potings_dataset
SELECT 
job_title_short AS title,
job_location AS location,
job_posted_date AS date_time
FROM job_postings_fact
LIMIT 100;

-- eg results:
-- "title","location","date_time"
-- "Data Analyst","Anywhere","2023-09-25 17:46:06"
-- "Cloud Engineer","Kuwait City, Kuwait","2023-07-30 17:49:18"
-- "Data Analyst","Paris, France","2023-07-28 17:28:01"
-- "Data Engineer","Denver, CO","2023-04-03 17:14:45"
-- "Data Engineer","Anywhere","2023-03-25 17:25:20"
-- "Data Analyst","Bangkok, Thailand","2023-01-29 17:16:56"
-- "Data Engineer","Anywhere","2023-08-13 17:37:05"
-- "Senior Data Engineer","New York, NY","2023-02-19 17:11:17"
-- "Data Analyst","Chicago, IL","2023-10-19 17:01:36"
-- "Data Engineer","Anywhere","2023-04-27 17:38:56"
-- "Data Engineer","Anywhere","2023-06-04 17:27:58"



--Typecasting above to date
SELECT 
job_title_short AS title,
job_location AS location,
job_posted_date::DATE AS date
FROM job_postings_fact
LIMIT 100;

-- eg results:
-- "title","location","date"
-- "Data Analyst","Anywhere","2023-09-25"
-- "Cloud Engineer","Kuwait City, Kuwait","2023-07-30"
-- "Data Analyst","Paris, France","2023-07-28"
-- "Data Engineer","Denver, CO","2023-04-03"
-- "Data Engineer","Anywhere","2023-03-25"
-- "Data Analyst","Bangkok, Thailand","2023-01-29"
-- "Data Engineer","Anywhere","2023-08-13"
-- "Senior Data Engineer","New York, NY","2023-02-19"
-- "Data Analyst","Chicago, IL","2023-10-19"
-- "Data Engineer","Anywhere","2023-04-27"
-- "Data Engineer","Anywhere","2023-06-04"
-- "Data Engineer","Singapore","2023-07-13"
-- "Data Scientist","Ho Chi Minh City, Vietnam","2023-09-26"
-- "Data Engineer","Atlanta, GA","2023-04-13"


SELECT 
job_title_short AS title,
job_location AS location,
job_posted_date::DATE AS date
FROM job_postings_fact
LIMIT 100;

SHOW TIMEZONE;
-- current time zone in postgre due to os setting in my pc and hence it is adding 5:30 to convert it to GMT
-- "TimeZone"
-- "Asia/Calcutta"


/*

FOR DATA CONTAINING TIME WITH TIMEZONE

uses keywords: AT TIME ZONE

syntax

SELECT column_name AT TIME ZONE EST
FROM table_name

Core Behaviors
Case 1: Input has NO offset (Timestamp without Time Zone)
The operator assigns the specified time zone to the value. It assumes the original time was already in that zone and returns a timestamp with the appropriate offset.
Case 2: Input HAS an offset (Timestamp with Time Zone)
The operator converts the value to the target time zone. It shifts the actual clock time based on the difference between the original and target zones. 

eg below:
*/

SELECT job_posted_date AS date_time
FROM job_postings_fact
LIMIT 10;

-- "date_time"
-- "2023-09-25 17:46:06"
-- "2023-07-30 17:49:18"
-- "2023-07-28 17:28:01"
-- "2023-04-03 17:14:45"
-- "2023-03-25 17:25:20"
-- "2023-01-29 17:16:56"
-- "2023-08-13 17:37:05"
-- "2023-02-19 17:11:17"
-- "2023-10-19 17:01:36"
-- "2023-04-27 17:38:56"


SELECT job_posted_date AT TIME ZONE 'GMT'  AS date_time
FROM job_postings_fact
LIMIT 10;

-- "date_time"
-- "2023-09-25 23:16:06+05:30"
-- "2023-07-30 23:19:18+05:30"
-- "2023-07-28 22:58:01+05:30"
-- "2023-04-03 22:44:45+05:30"
-- "2023-03-25 22:55:20+05:30"
-- "2023-01-29 22:46:56+05:30"
-- "2023-08-13 23:07:05+05:30"
-- "2023-02-19 22:41:17+05:30"
-- "2023-10-19 22:31:36+05:30"
-- "2023-04-27 23:08:56+05:30"


SELECT job_posted_date AT TIME ZONE 'Asia/Calcutta' AT TIME ZONE 'GMT'  AS date_time
FROM job_postings_fact
LIMIT 10;

-- Kolkata time is GMT+5:30 (UTC+5:30),
-- Result:
-- "date_time"
-- "2023-09-25 12:16:06"
-- "2023-07-30 12:19:18"
-- "2023-07-28 11:58:01"
-- "2023-04-03 11:44:45"
-- "2023-03-25 11:55:20"
-- "2023-01-29 11:46:56"
-- "2023-08-13 12:07:05"
-- "2023-02-19 11:41:17"
-- "2023-10-19 11:31:36"
-- "2023-04-27 12:08:56"

SELECT job_posted_date AT TIME ZONE 'GMT' AT TIME ZONE 'EST'  AS date_time
FROM job_postings_fact
LIMIT 10;

-- EST is 5 hrs ahead of GMT
-- "date_time"
-- "2023-09-25 12:46:06"
-- "2023-07-30 12:49:18"
-- "2023-07-28 12:28:01"
-- "2023-04-03 12:14:45"
-- "2023-03-25 12:25:20"
-- "2023-01-29 12:16:56"
-- "2023-08-13 12:37:05"
-- "2023-02-19 12:11:17"
-- "2023-10-19 12:01:36"
-- "2023-04-27 12:38:56"

-- EXTRACT FUNCTION IN SQL is used to extract fields like day, month or year from a date
-- The function needs the provided data to be in timestamp or date format to execute
-- If string variable or any other data type is used, it throws an error

-- eg. SELECT EXTRACT(MONTH FROM column_name);


SELECT EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact;

SELECT EXTRACT(MONTH FROM DATE '12-09-2007');
SELECT EXTRACT(MONTH FROM '12-09-2007'::DATE);

-- Below query gives an error as the date is not typecasted into date

SELECT EXTRACT(MONTH FROM '12-07-2007');


SELECT COUNT(job_id) AS job_count, EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
GROUP BY month
ORDER BY job_count DESC;

-- "job_count","month"
-- "92266","1"
-- "75067","8"
-- "66601","10"
-- "64560","2"
-- "64404","11"
-- "64158","3"
-- "63855","7"
-- "62915","4"
-- "62433","9"
-- "61500","6"
-- "57692","12"
-- "52235","5"


-- From above data we observe that job posting count is substanitally high during Jan & Aug and then remains nealry constant for most month between 60,000-65,000
-- NEXT PROBLMES
-- CREATE NEW TABLES FOR jobs posted in each month AS jan_job, feb_jobs etc and store them in database

-- Write a query to find average salary for both yearly (salry year avg) and hourly (salary hourly avg) for job postings that were posted after June 1, 2023. Group the results by job_schedule_type

SELECT job_schedule_type, AVG(salary_year_avg) AS yearly_avg_salary, AVG(salary_hour_avg) AS hourly_avg_salary
FROM job_postings_fact
WHERE job_posted_date > '1-06-2023'::DATE
GROUP BY job_schedule_type
LIMIT 10;

-- SELECT EXTRACT(MONTH FROM '1-06-2023'::DATE); -- RESULTS INTO 6 THAT MEANS THE MONTH IS CALCULATED CORRECTLY
-- "job_schedule_type","yearly_avg_salary","hourly_avg_salary"
-- "Contractor","105379.745535714286","55.5895523138832998"
-- "Contractor and Full-time","",""
-- "Contractor and Internship","",""
-- "Contractor and Part-time","",""
-- "Contractor and Per diem","",""
-- "Contractor and Temp work","86471.604166666667","52.2462156862745098"
-- "Contractor, Temp work, and Internship","",""
-- "Full-time","123777.834177001641","41.3512298159969959"
-- "Full-time and Contractor","104875.047820000000","55.5662000000000000"
-- "Full-time and Internship","78722.727272727273","29.8405172413793103"


-- Write a query to count the number of job posting for each month in 2023, adjusting the job_posted_date to be in 'America/New_York' TZ before extracting (hind) the month. Assume the job_posted_date to be stored in UTC. Group by and order by the month
-- SELECT EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month
-- FROM job_postings_fact


SELECT EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month, COUNT(job_id)
FROM job_postings_fact
WHERE job_posted_date BETWEEN '1-1-2023'::DATE AND '31-12-2023'::DATE
GROUP BY month
ORDER BY month;


-- "month","count"
-- "1","91943"
-- "2","64612"
-- "3","64069"
-- "4","63099"
-- "5","52063"
-- "6","61604"
-- "7","63860"
-- "8","75104"
-- "9","62335"
-- "10","66466"
-- "11","64478"
-- "12","56009"


-- SUMS TO 7,85,642 WHICH MATCHES THE TOTAL COUNT

-- SELECT job_posted_date
-- FROM job_postings_fact
-- WHERE job_posted_date BETWEEN '1-1-2023'::DATE AND '31-12-2023'::DATE
-- ORDER BY job_posted_date;

-- 
-- 1-50 of 785642
-- Write a query to find companies that have posted job offering health insurance, where these postings were made in the second quarter of 2023. Use date extraction to filter by quarter.

SELECT DISTINCT job_postings_fact.company_id AS company_id, company_dim.name AS company_name
FROM job_postings_fact
JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023 
AND EXTRACT(QUARTER FROM job_posted_date) = 2
AND job_health_insurance = TRUE
ORDER BY company_id
LIMIT 100;

-- "company_id","company_name"
-- 7,"Proofpoint"
-- 10,"Signify Technology"
-- 18,"Engtal"
-- 19,"Enlighten"
-- 21,"Meta"
-- 27,"CyberCoders"
-- 28,"ADNET Systems, Inc."
-- 29,"Jacobs"
-- 30,"Vizient, Inc."
-- 34,"Nelnet"
-- 43,"PayPal"
-- 48,"Abbtech Professional Resources, Inc"
-- 49,"Booz Allen Hamilton"
-- 53,"USAA"
-- 62,"LMI Consulting, LLC"
-- 66,"Citi"
-- 68,"Foot Locker"
-- 69,"Oracle"
-- 74,"IQVIA"
-- 75,"New Iron, Inc."
-- 76,"Addison Group"
-- 80,"Scientific American"
-- 82,"Leidos"
-- 88,"Experis"
-- 89,"BAE Systems"
-- 91,"Cognizant Technology Solutions"
-- 92,"UST"
-- 96,"CGI"
-- 98,"Google"
-- 100,"ClearanceJobs"
-- 102,"Atlassian"
-- 108,"MATRIX Resources"
-- 112,"Genesis10"
-- 114,"GM Financial"
-- 115,"Defense Acquisition Support Services LLC"
-- 116,"Ericsson"
-- 118,"Pearson"
-- 119,"Johnson & Johnson"
-- 123,"Cisco"
-- 126,"LLNL"
-- 128,"Verizon"
-- 138,"Cardinal Health"
-- 143,"Guidehouse"
-- 152,"UnitedHealth Group"
-- 154,"Capital One"
-- 156,"Insight Global"
-- 162,"Harnham"
-- 165,"Fidelity Investments"
-- 174,"Massachusetts General Hospital"
-- 176,"Penn Medicine"
-- 180,"Mercy"
-- 184,"LMI Government Consulting (Logistics Management Institute)"
-- 187,"Wells Fargo"
-- 189,"Cox Communications"
-- 191,"SoFi"
-- 209,"Motion Recruitment"
-- 210,"Visa"
-- 212,"EPAM Systems"
-- 218,"Reperio Human Capital"
-- 220,"Lockheed Martin"
-- 225,"Change Healthcare"
-- 241,"CTG"
-- 244,"Publicis Groupe"
-- 248,"ecocareers"
-- 250,"Elevance Health"
-- 259,"Experian"
-- 260,"Columbia University Irving Medical Center"
-- 264,"Florida Blue"
-- 265,"PepsiCo"
-- 271,"TD Bank"
-- 274,"SoCalGas"
-- 275,"LTK"
-- 285,"Wintrust Financial Corporation"
-- 300,"Cognizant"
-- 301,"Gopuff"
-- 307,"Securian Financial Group"
-- 309,"MAXAR Technologies"
-- 317,"RIT Solutions, Inc."
-- 321,"Aptos"
-- 324,"Meta Platforms, Inc. (f/k/a Facebook, Inc.)"
-- 327,"NBCUniversal"
-- 337,"Upwork"
-- 343,"Columbia University"
-- 348,"IBM"
-- 351,"WWC Global"
-- 352,"Hays"
-- 353,"HII Mission Technologies"
-- 357,"American Express"
-- 367,"Walmart"
-- 371,"Eliassen Group"
-- 373,"The Mom Project"
-- 379,"Genworth"
-- 380,"United Airlines"
-- 386,"ClickJobs.io"
-- 388,"Maximus"
-- 395,"S&P Global"
-- 408,"AutoNation"
-- 411,"Salesforce"
-- 413,"Clarivate Analytics US LLC"
-- 417,"Thermo Fisher Scientific"
