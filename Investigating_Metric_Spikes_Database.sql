CREATE DATABASE sql_trainity_operation_analytics_and_investigating_metric_spike;

USE sql_trainity_operation_analytics_and_investigating_metric_spike;

/* Case Study 2: Investigating Metric Spike */


CREATE TABLE users(
	user_id INT,
	created_at TIMESTAMP,
	company_id INT,
	language VARCHAR(100),
	activated_at TIMESTAMP,
	state VARCHAR(50)
	
	);

SET global local_infile = 1;
SELECT * FROM users;

CREATE TABLE events(
	user_id INT,
	occurred_at TIMESTAMP,
	event_type VARCHAR(50),
	event_name VARCHAR(50),
	location VARCHAR(50),
	device VARCHAR(100),
	user_type INT
	);

SELECT * FROM events;

CREATE TABLE email_events(
	user_id INT,
	occured_at TIMESTAMP,
	action VARCHAR(100),
	user_type INT
	
	);
SELECT * FROM email_events;





