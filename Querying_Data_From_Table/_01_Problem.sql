-- Q1. get the job id, job_title_short, job_location, job_via and salary year avg columns only where job location is in 'Tampa, FL'


SELECT job_id, job_title_short, job_location, job_via, salary_year_avg
FROM job_postings_fact
WHERE job_location = 'Tampa, FL';

-- Q2. get the job id, job_title_short, job_location, job_via and salary year avg columns  only for Full time jobs

SELECT job_id, job_title_short, job_via, salary_year_avg
FROM job_postings_fact
WHERE job_schedule_type LIKE 'Full-time';
-- Runtime : 


-- Q3. get the job id, job_title_short, job_location, job_via and salary year avg columns  only for jobs that are not part time


SELECT DISTINCT job_schedule_type 
FROM job_postings_fact
WHERE job_schedule_type NOT LIKE '%Part-time%';
-- 28 job schedule types


SELECT DISTINCT job_schedule_type 
FROM job_postings_fact
WHERE job_schedule_type LIKE '%Part-time%';

-- 19 job scheule types

SELECT DISTINCT job_id, job_title_short, job_location, job_via, salary_year_avg
FROM job_postings_fact
WHERE job_schedule_type NOT LIKE '%Part-time%';
-- runtime 


-- Q4. get the job id, job_title_short, job_location, job_via and salary year avg columns  jobs that are not posted via LinkedIn


SELECT job_id, job_title_short, job_location, job_via, salary_year_avg
FROM job_postings_fact
WHERE job_via NOT LIKE '%LinkedIn%'
ORDER BY job_id;

SELECT DISTINCT job_via 
FROM job_postings_fact
order by job_via;