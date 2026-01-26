CREATE TABLE job_postings_fact (
    job_id INT PRIMARY KEY,
    company_id INT ,
    job_title_short TEXT,
    job_title TEXT,
    job_location TEXT,
    job_via TEXT,
    job_schedule_type TEXT,
    job_work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate  NUMERIC(5,3),
    salary_year_avg INTEGER CHECK(salary_year_avg > 0),
    salary_hour_avg NUMERIC(5,3)
);


CREATE TABLE IF NOT EXISTS company_dim (
    company_id INT NOT NULL PRIMARY KEY,
    name varchar(100),
    link text,
    link_google TEXT,
    thumbnail TEXT
);

CREATE TABLE IF NOT EXISTS skills_job_dim (
    job_id INT NOT NULL,
    skill_id INT
);

CREATE TABLE IF NOT EXISTS skill_dim (
    skill_id INT NOT NULL PRIMARY KEY,
    skills VARCHAR(50),
    type VARCHAR(50)
);