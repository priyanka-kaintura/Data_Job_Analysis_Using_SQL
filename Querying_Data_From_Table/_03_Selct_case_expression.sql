-- SYNTAX: 
-- SELECT 
--     CASE
--         WHEN column_name = 'value_1' THEN 'description of Value1'
--         WHEN column_name = 'value2' THEN 'descripiton of Value2'
--         ....
--         ELSE 'other description'
--     END AS column_description
-- FROM table_name

-- Write a query to label a new column as follows
-- Anywhere jobs as remote
-- "New York, NY" jobs a loca
-- Otherwise onstie

-- SELECT DISTINCT job_country, job_location FROM job_postings_fact WHERE job_location = 'Anywhere';
-- SELECT DISTINCT job_country, job_location FROM job_postings_fact WHERE job_country = 'India' ORDER BY job_country ASC, job_location ASC;
-- SELECT DISTINCT job_country, job_location FROM job_postings_fact WHERE job_country = 'India' ORDER BY job_country ASC, job_location ASC;

SELECT job_id, job_title_short, job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS job_location_short
FROM job_postings_fact;

-- Now calcute how many jobs are remote, local and onsite

-- Use group by function to do so on above query

SELECT COUNT(job_id) , 
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS job_location_short
FROM job_postings_fact
GROUP BY job_location_short;

-- "count","job_location_short"
-- "709887","Onsite"
-- "69606","Remote"
-- "8193","Local"


-- Now filter it for only data analyst

SELECT COUNT(job_id) , 
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS job_location_short
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY job_location_short;

-- "count","job_location_short"
-- "180224","Onsite"
-- "13331","Remote"
-- "3038","Local"


-- Problem:

-- I wan to categorize the salaries from each job posting. To see if it fits in my desired salary range. 
-- Put salary in different buckets
-- Define what high, standard or low salary with our own conditions
-- Why? It is easy to determinte which jobpostings are worth looking at based on salary.
-- Bucketing is a common practice in data analysis when viewing categories.
-- I only want to look at data analyst roles.
-- Order from higest to lowest

-- SELECT * ,
--     CASE
--         WHEN salary_year_avg 
--         WHEN
--         ELSE
--     END AS bucket
-- FROM job_postings_fact
-- WHERE job_title_short LIKE 'Data Analyst'
-- ORDER BY salary_year_avg;


SELECT MAX(salary_year_avg) AS max,
MIN(salary_year_avg) AS min,
AVG(salary_year_avg) AS avg
FROM job_postings_fact;

-- "max","min","avg"
-- "960000.000","15000.000","123268.815642507035"
