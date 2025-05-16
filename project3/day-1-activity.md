1. ***Reports: ***

*** Windows logs ***

A report with a table of signatures and associated signature IDs.
This will allow VSI to view reports that show the ID number associated with the specific signature for Windows activity.
Hint: Research how to remove the duplicate values in your SPL search.
Take a screenshot of the report. 


`Windows Signatures and IDs`

`source="windows_server_logs.csv" | fields signature, signature_id | dedup signature, signature_id | table signature, signature_id`

A report that displays the severity levels, and the count and percentage of each.
This will allow VSI to quickly understand the severity levels of the Windows logs being viewed.
Take a screenshot of the report. 

`Windows_log_severity_level`

`source="windows_server_logs.csv" | stats count by severity`


A report that provides a comparison between the success and failure of Windows activities.
This will show VSI if there is a suspicious level of failed activities on their server.
Hint: Check the “status” field for this information.
Take a screenshot of the report. 

`Windows_logs_success_failure`

`source="windows_server_logs.csv" | stats count by status`


2. Alerts: 

Design the following alerts to notify VSI of suspicious activity, and keep this information on hand as you will include it in your presentation: 
Determine a baseline and threshold for the hourly level of failed Windows activity.
Create an alert that’s triggered when the threshold has been reached.
The alert should trigger an email to SOC@VSI-company.com.

`Failure Alert Threshold Met`

`source="windows_server_logs.csv" | where status!="0x0" | bucket _time span=1h | stats count as failures by _time | eventstats avg(failures) as baseline | table _time, failures, baseline`

Determine a baseline and threshold for the hourly count of the signature “an account was successfully logged on.”
Create an alert that’s triggered when the threshold has been reached.
The alert should trigger an email to SOC@VSI-company.com.
Design the alert based on the corresponding signature ID, as the signature name sometimes changes when the Windows system updates.

`High hourly rate of "An account was successfully logged on"`

`source="windows_server_logs.csv" signature="an account was successfully logged on" | bucket _time span=1h | stats count as logged_on by _time | eventstats avg(logged_on) as baseline | table _time, logged_on, baseline`

`signature_id`

`source="windows_server_logs.csv" signature_id="4624" | bucket _time span=1h | stats count as logged_on by _time | eventstats avg(logged_on) as baseline | table _time, logged_on, baseline`

Determine a baseline and threshold for the hourly count of the signature “a user account was deleted.”
Design the alert based on the corresponding signature ID, as the signature name sometimes changes when the Windows system updates.
Create an alert that's triggered when the threshold has been reached.
The alert should trigger an email to SOC@VSI-company.com.

`Any Occurrence of “A User Account Was Deleted”`

`source="windows_server_logs.csv" signature="a user account was deleted" | bucket _time span=1h | stats count as del_user by _time | eventstats avg(del_user) as baseline | table _time, del_user, baseline`

`source="windows_server_logs.csv" signature_id="4726" | bucket _time span=1h | stats count as del_user by _time | eventstats avg(del_user) as baseline | table _time, del_user, baseline`


Visualizations and dashboards: Design the following visualizations, and add them to a dashboard called “Windows Server Monitoring” (be creative with your visualizations, and make sure to grab screenshots of each):
A line chart that displays the different “signature” field values over time.
Hint: Add the following after your search: timechart span=1h count by signature.
Take a screenshot of the chart. 

`Windows Server Monitoring` 

`source="windows_server_logs.csv" | timechart span=1h count by signature`

A line chart that displays the different “user” field values over time.
Take a screenshot of the chart. 
`Windows Server Monitoring` 
`source="windows_server_logs.csv" | timechart span=1h count by user`

Any visualization that illustrates the count of different signatures.
Hint: You can add brand-new custom visualizations by accessing this page inside your VM: Additional Viz.
Take a screenshot of the visualization. 
Any visualization that illustrates the count of different users.
Take a screenshot of the visualization. 
`Windows Server Monitoring` 
`source="windows_server_logs.csv" | where status!="0x0" | stats count as FailedLogins`

`source="windows_server_logs.csv" | stats count by signature | sort - count`

Any single-value visualization of your choice that analyzes any single data point,e.g., radial gauge, marker gauge, or a custom visualization from http://localhost:8000/en-US/manager/search/appsremote?content=visualizations&type=app.
Take a screenshot of the visualization. 
On your dashboard, add the ability to change the time range for all visualizations.
Be sure to title all of your panels appropriately.
Organize the panels on your dashboard as you see fit.

`Windows Server Monitoring` 
`source="windows_server_logs.csv" | stats count by user | sort - count`


*** Apache logs ***

Design the following deliverables to protect VSI from potential attacks by JobeCorp:
Reports: Design the following reports to assist VSI in quickly identifying specific information (make sure to grab screenshots of each report):
A report that shows a table of the different HTTP methods (GET, POST, HEAD, etc.).
This will provide insight into the type of HTTP activity being requested against VSI’s web server.

`Radial Guage - POST request activity`
`source="apache_logs.txt" | stats count by method | sort - count`

A report that shows the top 10 domains that refer to VSI’s website.
This will assist VSI with identifying suspicious referrers.

`Top 10 Referring Domains`
`source="apache_logs.txt" | top limit=10 referer_domain`

A report that shows the count of each HTTP response code.
This will provide insight into any suspicious levels of HTTP responses.

`HTTP Method Usage Report`
`source="apache_logs.txt" | stats count by status | sort - count`


Alerts: Design the following alerts:
Determine a baseline and threshold for hourly activity from any country besides the United States.
Create an alert that’s triggered when the threshold has been reached.

`High Non-US Hourly Activity Alert`
`source="apache_logs.txt" | bucket _time span=1h | iplocation clientip | where Country!="United States" | stats count as ips by _time | eventstats avg(ips) as baseline`


The alert should trigger an email to SOC@VSI-company.com.
Determine an appropriate baseline and threshold for the hourly count of the HTTP POST method.
Create an alert that’s triggered when the threshold has been reached.
The alert should trigger an email to SOC@VSI-company.com.

`HTTP POST Hourly`
`source="apache_logs.txt" | bucket _time span=1h | search method="POST" | stats count as post_count by _time | eventstats avg(post_count) as baseline`

Visualizations and dashboards: 

Design the following visualizations, and add them to a dashboard called “Apache Web Server Monitoring” (be creative with your visualizations, and make sure to grab screenshots of each):

A line chart that displays the different HTTP “methods” field values over time.
Hint: Add the following after your search: timechart span=1h count by method.

`source="apache_logs.txt" | timechart span=1h count by method`

A geographical map showing the location based on the “clientip” field.

`source="apache_logs.txt" | iplocation clientip | geostats latfield=lat longfield=lon count by Country`


Any visualization of your choice that displays the number of different URIs.
Hint: You can add brand-new custom visualizations by accessing this page inside your 
VM: Additional Viz.

`source="apache_logs.txt"| top uri_path limit=10`

Any visualization of your choice that displays the count of the top 10 countries that appear in the log.
Any visualization that illustrates the count of different user agents.
`source="apache_logs.txt"| iplocation clientip | top Country limit=10`

A single-value visualization of your choice that analyzes any single data point: e.g., radial gauge, marker gauge, or a custom visualization from http://localhost:8000/en-US/manager/search/appsremote?content=visualizations&type=app).

`source="apache_logs.txt" | top useragent limit=10`

On your dashboard, add the ability to change the time range for all visualizations.
Be sure to title all of your panels appropriately.
Organize the panels on your dashboard as you see fit.


