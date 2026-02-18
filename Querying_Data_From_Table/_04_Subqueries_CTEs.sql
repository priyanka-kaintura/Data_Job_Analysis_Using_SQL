-- Subqueries and CTEs are the temporary results sets that are used to simplify the complex queries

-- Using SubQueries

/*

CTES: Define a temporary result set that can be references
Can reference within SELECT, INSERT, UPDATE, DELETE statemetns
DEFINED USING A 'WITH' KEYWORD

*/

-- Create a CTE for january jobs

WITH january_jobs AS (
    --CTE definition starts
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM  job_posted_date) = 1
    -- CTE definition ends
)

SELECT * FROM january_jobs
LIMIT 100;

-- SELECT * FROM january_jobs
-- WHERE job_title_short ='Data Analyst';

-- Execute above and we have a CTE which can then be referenced in other queries

-- A recursive CTE has two parts:
-- Anchor member: A non-recursive term that forms the base result set.
-- Recursive member: A query that references the CTE itself and is repeatedly executed (combined with UNION ALL) until no new rows are returned. 

-- EXTRACT ALL COMPANIES PROVIDING JOBS WITH NO DEGREES MENTIONED

-- USING JOIN:

SELECT job_id, job_postings_fact.company_id, company_dim.name, job_title_short, job_title, job_location, job_via, job_schedule_type, job_work_from_home, search_location, job_health_insurance, job_country  FROM job_postings_fact
JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_no_degree_mention = true;


SELECT job_postings_fact.company_id, company_dim.name, COUNT(job_postings_fact.job_id) AS job_count FROM job_postings_fact
JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_no_degree_mention = true AND job_title_short = 'Data Analyst'
GROUP BY job_postings_fact.company_id, company_dim.name
ORDER BY job_count DESC;

SELECT company_id, name
FROM company_dim
WHERE company_id IN (
    SELECT company_id FROM job_postings_fact
    WHERE job_no_degree_mention = true
);


-- Identify the top 5 skills that are mentioned in the job postings. 
-- Use the sub-queries to find the skill ids with the highest count in skills_job_dim table and then join this result with the skills_dim table to get the skills name

skills_job_dim * job_postings table on job_id count , order by count desc limit 5;

SELECT skills_job_dim.skill_id,skills_dim.skills, COUNT(job_postings_fact.job_id) AS job_count FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills_job_dim.skill_id, skills_dim.skills
ORDER BY job_count DESC
LIMIT 10;

-- FILTERING THIS QUERY FOR DATA ANALYST SPECIFICALLY

SELECT skills_job_dim.skill_id,skills_dim.skills, COUNT(job_postings_fact.job_id) AS job_count FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY skills_job_dim.skill_id, skills_dim.skills
ORDER BY job_count DESC
LIMIT 10;

SELECT skills_job_dim.skill_id, skills_dim.skills, COUNT(job_id) AS count FROM skills_job_dim
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills_job_dim.skill_id, skills_dim.skills
ORDER BY count DESC
LIMIT 5;

SELECT COUNT(DISTINCT job_id) FROM job_postings_fact;
-- 787686

select COUNT (DISTINCT job_id) FROM skills_job_dim;
-- 670364

SELECT COUNT(DISTINCT job_postings_fact.job_id) FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id;
-- 670364

-- Above 3 queries confirms that the job_id present in skills_job_dim table are same as in the job_postings_fact table
-- as we checked count of unique job ids in skills_job_dim table and matched it with the unique job_ids in inner join of job_postings_fact and skills_job_dim table
-- and both are equal, confirming the theory.


-- Determine the size category (small, medium or large) for each company by first identifying the job postings they have. Use a subquery to calculate the total job postings per comapny.
-- A company is considered small if it has less than 10 job postings    
-- Mdeium if it has jobs postings between 10 to 50
-- and Large if it has more than 50 job postings
-- Implement a subquery to aggregate job counts per company before classifying them based on size


-- USE CTES FOR BELOW PROBLEM - 2:43:16
-- Find the count of the number of remote jobs postings per skill
-- Display the top 5 skills by their demand in remote jobs
-- Inlcude skill ID, name and count of postings requiring the skills