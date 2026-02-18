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

ALTER TABLE skills_job_dim 
ADD FOREIGN KEY(job_id) 
REFERENCES job_postings_fact(job_id);

ALTER TABLE skills_job_dim
ADD FOREIGN KEY(skill_id)
REFERENCES skills_dim(skill_id);

ALTER TABLE job_postings_fact
ADD FOREIGN KEY(company_id)
REFERENCES company_dim(company_id);

SELECT * FROM skills_job_dim LIMIT 5;