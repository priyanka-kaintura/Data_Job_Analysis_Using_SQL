-- Fetch Data from each table ordered by their primary keys and 

SELECT * FROM job_postings_fact
ORDER BY job_id
LIMIT 100;


SELECT * FROM company_dim
ORDER BY company_id
LIMIT 100;


SELECT * FROM skills_dim
ORDER BY skill_id
LIMIT 100;


SELECT * FROM skills_job_dim
ORDER BY skill_id
LIMIT 100;

--  Check names of columns in a table

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'job_postings_fact'
AND table_schema = 'public';
-- Output of above is saved in schema_unpacking > _01_column_details


SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'company_dim'
AND table_schema = 'public';
-- Output of above is saved in schema_unpacking > _02_column_details


SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'skills_dim'
AND table_schema = 'public';
-- Output of above is saved in schema_unpacking > _03_column_details


SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'skills_job_dim'
AND table_schema = 'public';
-- Output of above is saved in schema_unpacking > _04_column_details


