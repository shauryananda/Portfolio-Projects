CREATE DATABASE sql_trainity_operation_analytics_and_investigating_metric_spike;

USE sql_trainity_operation_analytics_and_investigating_metric_spike;

/* Case Study 2: Investigating Metric Spike */

/* Task:
Weekly User Engagement:
Objective: Measure the activeness of users on a weekly basis.
Your Task: Write an SQL query to calculate the weekly user engagement.
*/

SELECT WEEK(occurred_at) AS WEEK,COUNT(DISTINCT user_id) AS weekly_user_engagement
FROM events
WHERE event_type='engagement'
GROUP BY WEEK(occurred_at)
ORDER BY WEEK(occurred_at);

/* Task:
User Growth Analysis:
Objective: Analyze the growth of users over time for a product.
Your Task: Write an SQL query to calculate the user growth for the product.
*/

SELECT YEAR,week_num, new_user_activated,
new_user_activated - LAG(new_user_activated) OVER( ORDER BY YEAR,week_num ) AS user_growth
FROM(SELECT YEAR(activated_at) AS YEAR,WEEK(activated_at) AS week_num,COUNT(user_id) AS new_user_activated 
FROM users 
WHERE activated_at IS NOT NULL AND state='active'
GROUP BY YEAR,week_num
ORDER BY YEAR,week_num) AS temptable;
	
/* Task:
Weekly Retention Analysis:
Objective: Analyze the retention of users on a weekly basis after signing up for a product.
Your Task: Write an SQL query to calculate the weekly retention of users based on their sign-up cohort.
*/

SELECT t1.week_num,(t2.old_users - t1.new_users)AS Retained_Users
FROM(SELECT WEEK(occurred_at) AS week_num,
COUNT(DISTINCT user_id) AS new_users
FROM events
WHERE event_type = "signup_flow"
GROUP BY week_num) AS t1
JOIN
(SELECT WEEK(occurred_at) AS week_num,
COUNT(DISTINCT user_id) AS old_users
FROM events
WHERE event_type = "engagement"
GROUP BY week_num) AS t2
ON t1.week_num = t2.week_num;

/* Task:
Weekly Engagement Per Device:
Objective: Measure the activeness of users on a weekly basis per device.
Your Task: Write an SQL query to calculate the weekly engagement per device.
*/

SELECT WEEK(occurred_at) AS weeks,device,COUNT(DISTINCT user_id) AS device_engagement
FROM events
GROUP BY device, WEEK(occurred_at)
ORDER BY WEEK(occurred_at);


/* Task:
Email Engagement Analysis:
Objective: Analyze how users are engaging with the email service.
Your Task: Write an SQL query to calculate the email engagement metrics.

*/

SELECT DISTINCT WEEK(occured_at) AS week_num,
COUNT(DISTINCT CASE WHEN ACTION = 'sent_weekly_digest' THEN user_id END) AS email_digest,
COUNT(DISTINCT CASE WHEN ACTION ='email_open' THEN user_id END) AS email_open,
COUNT(DISTINCT CASE WHEN ACTION = 'email_clickthrough' THEN user_id END) AS click_throgh,
COUNT(DISTINCT CASE WHEN ACTION ='sent_reengagement_email' THEN user_id END) AS reengagement_emails
FROM email_events
GROUP BY WEEK(occured_at);

SELECT * FROM email_events;
