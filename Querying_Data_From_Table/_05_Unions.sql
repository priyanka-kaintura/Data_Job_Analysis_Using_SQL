-- Union used to combine the results from two queries 
-- Removes all duplicate results
-- Sntax:

-- Query_1 UNION Query_2

SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1

UNION

SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2

UNION 

SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

-- Unlike UNION the other operation UNION ALL does not remove duplicates if Any

SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1

UNION ALL

SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2

UNION ALL

SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;