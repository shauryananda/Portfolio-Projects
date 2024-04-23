CREATE DATABASE sql_trainity_operation_analytics_and_investigating_metric_spike;

USE sql_trainity_operation_analytics_and_investigating_metric_spike;

/*Case Study 1 (Job Data)*/

create table job_data(
job_id int,
actors_id int,
event varchar(255),
language varchar(255),
time_spent int,
org varchar(255),
ds date);

select * from job_data;

INSERT INTO job_data (ds, job_id, actors_id, event, language, time_spent, org)
VALUES ('2020-11-30', 21, 1001, 'skip', 'English', 15, 'A'),
       ('2020-11-30', 22, 1006, 'transfer', 'Arabic', 25, 'B'),
       ('2020-11-29', 23, 1003, 'decision', 'Persian', 20, 'C'),
       ('2020-11-28', 23, 1005,'transfer', 'Persian', 22, 'D'),
       ('2020-11-28', 25, 1002, 'decision', 'Hindi', 11, 'B'),
       ('2020-11-27', 11, 1007, 'decision', 'French', 104, 'D'),
       ('2020-11-26', 23, 1004, 'skip', 'Persian', 56, 'A'),
       ('2020-11-25', 20, 1004, 'transfer', 'Italian', 45, 'C');
       
/*. Task:
Jobs Reviewed Over Time:
Objective: Calculate the number of jobs reviewed per hour for each day in November 2020.
Your Task: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.
*/

SELECT ds AS DAY,ROUND(COUNT(job_id)/SUM(time_spent)*3600) as jobs_reviewed_perhour
FROM job_data
WHERE ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY ds;


/* Task:
Throughput Analysis
Objective: Calculate the 7-day rolling average of throughput (number of events per second).
Your Task: Write an SQL query to calculate the 7-day rolling average of throughput. Additionally, explain whether you prefer using the daily metric or the 7-day rolling average for throughput, and why.
*/

SELECT ds, event_or_events_per_day, 
ROUND(AVG(event_or_events_per_day) OVER(ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS 7_day_rolling_avg 
FROM (SELECT ds, COUNT(DISTINCT event) AS event_or_events_per_day 
FROM job_data
GROUP BY ds) AS temptable;



/* Task:
Language Share Analysis:
Objective: Calculate the percentage share of each language in the last 30 days.
Your Task: Write an SQL query to calculate the percentage share of each language over the last 30 days.
*/

SELECT language AS languages,CONCAT(ROUND(COUNT(*)*100/(select COUNT(*)
FROM job_data),2),'%') AS percetage_share
FROM job_data
GROUP BY language;

/* Task:
Duplicate Rows Detection:
Objective: Identify duplicate rows in the data.
Your Task: Write an SQL query to display duplicate rows from the job_data table.
*/

SELECT ds, COUNT(ds) AS no_of_duplicates
FROM job_data
GROUP BY ds
HAVING no_of_duplicates > 1;

