SELECT * FROM history_visits WHERE LOWER(title) LIKE '%google%';

SELECT * FROM history_visits WHERE LOWER(title) LIKE '%yahoo%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%bing%';


SELECT * FROM history_visits WHERE LOWER(title) LIKE '%forensics%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%incident%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%response%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%malware%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%ransomware%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%phishing%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%cybersecurity%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%hacker%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%breach%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%data%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%threat%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%attack%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%exploit%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%vulnerability%';


-- need some queries where iPhone forensics data would have users phone number, address, etc. as case investigators would need to know the phone number of the user to investigate the case.
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%phone%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%address%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%location%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%contact%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%email%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%social%';
SELECT * FROM history_visits WHERE LOWER(title) LIKE '%media%';


SELECT DISTINCT title FROM history_visits WHERE LOWER(title) LIKE '%foren%';

