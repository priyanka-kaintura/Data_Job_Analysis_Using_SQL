ALTER TABLE job_postings_fact
ALTER COLUMN salary_hour_avg TYPE NUMERIC(5,3),
ALTER COLUMN salary_rate TYPE TEXT;

ALTER TABLE job_postings_fact
ALTER COLUMN salary_hour_avg TYPE NUMERIC(10,3),
ALTER COLUMN salary_year_avg TYPE NUMERIC(15,3);

ALTER TABLE company_dim
ALTER column name TYPE TEXT;

ALTER TABLE skill_dim
RENAME TO skills_dim;