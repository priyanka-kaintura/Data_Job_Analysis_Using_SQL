-- Copying data from CSV files into tables using copy command

COPY job_postings_fact 
FROM 'C:\Users\pc\Documents\GitHub\SQL-data-Analysis-on-Job-Dataset\Dataset\job_postings_fact.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');


COPY company_dim 
FROM 'C:\Users\pc\Documents\GitHub\SQL-data-Analysis-on-Job-Dataset\Dataset\company_dim.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');


COPY skill_dim 
FROM 'C:\Users\pc\Documents\GitHub\SQL-data-Analysis-on-Job-Dataset\Dataset\skills_dim.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');


COPY skills_job_dim 
FROM 'C:\Users\pc\Documents\GitHub\SQL-data-Analysis-on-Job-Dataset\Dataset\skills_job_dim.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');