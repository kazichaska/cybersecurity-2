Here is the challenge 

Instructions
Let's Go Splunking!
You have just been hired as an SOC analyst by Vandalay Industries, an importing and exporting company.

Vandalay Industries uses Splunk for its security monitoring and has been experiencing various security issues over the past few months.

You are tasked with developing searches, custom reports, and alerts to monitor Vandalay's security environments to protect from future attacks.

System Requirements
You will use the Splunk app located in the M18 lab environment.

Your Objective
Utilize your Splunk skills to design a powerful monitoring solution to protect Vandalay from security attacks.

Note: As you complete this assignment, make sure to take notes to help with the upcoming quiz.

Topics Covered in This Assignment
Researching and adding new apps
Installing new apps
Uploading files
Splunk searching
Using fields
Custom reports
Custom alerts
Let's get started!

Vandalay Industries Monitoring Activity Instructions
Note: As you progress through this activity, take notes and document your work in your report. It will be a useful reference for the quiz questions.

Step 1: The Need for Speed
Background: As the worldwide leader of importing and exporting, Vandalay Industries has been the target of many adversaries attempting to disrupt its online business. Recently, Vandalay has been experiencing DDoS attacks against its web servers.

Not only were Vandalay web servers taken offline by a DDoS attack, but upload and download speeds were also significantly impacted after the outage. Your networking team provided results of a network speed run around the time of the latest DDoS attack.

Your Task: Create a report to determine the impact of the DDoS attack on upload and download speed. Create an additional field to calculate the ratio of the upload speed to the download speed. To do so, complete the following steps:

Upload the following file containing the system speeds around the time of the attack:

Speed Test FileLinks to an external site.
Using the eval command, create a field called ratio that shows the ratio between the upload and download speeds.

Hint: The format for creating a ratio is: | eval new_field_name = 'fieldA' / 'fieldB'

Create a report using Splunk's table command to display the following fields in a statistics report:

_time
IP_ADDRESS
DOWNLOAD_MEGABITS
UPLOAD_MEGABITS
ratio
Hint: Use the following format for the table command: | table fieldA fieldB fieldC

Answer the following questions and include them in your notes:

Based on the report you created, what is the approximate date and time of the attack?

How long did it take your systems to recover?

Make sure to include a screenshot of your report along with the answers to these questions.

Step 2: Are We Vulnerable?
Background: Due to the frequency of attacks, your manager needs to be sure that sensitive customer data on their servers is not vulnerable. Since Vandalay uses Nessus vulnerability scanners, you have pulled the scans from the last 24 hours to see if there are any critical vulnerabilities.

For more information on Nessus, refer to the following link: https://www.tenable.com/products/nessusLinks to an external site..
Your Task: Create a report determining how many critical vulnerabilities exist on the customer data server. Then, build an alert to notify your team if a critical vulnerability reappears on this server. To do so, complete the following steps:

Upload the following file from the Nessus vulnerability scan:

Nessus Scan ResultsLinks to an external site.
Create a report that shows the count of critical vulnerabilities from the customer database server.

The database server IP is 10.11.36.23.
The field that identifies the level of vulnerabilities is severity.
Build an alert that monitors daily to see if this server has any critical vulnerabilities. If a vulnerability exists, have an alert emailed to soc@vandalay.com.

Step 3: Drawing the (Base)line
Background: A Vandalay server is also experiencing brute-force attacks against its administrator account. Management would like you to set up monitoring to notify the SOC team if a brute-force attack occurs again.

Your Task: Analyze administrator logs that document a brute-force attack. Then, create a baseline of the ordinary amount of administrator bad logins and determine a threshold to indicate if a brute-force attack is occurring. To do so, complete the following steps:

Upload the following administrator login logs: - Admin LoginsLinks to an external site.

Answer the following and include it in your notes:

When did the brute force attack occur?

> **Hint:** Look for the `name` field to find failed logins.
> 
> Note that the attack lasted several hours.
Determine a baseline of normal activity and a threshold that would alert if a brute-force attack is occurring.

Design an alert to check the threshold every hour and email the SOC team at SOC@vandalay.com if triggered.

Activity Guidelines
Ensure you have taken adequate notes to use for the quiz questions that follow.




````markdown
# Vandalay Industries Security Monitoring Solution

## Step 1: DDoS Attack Speed Analysis

### Upload Speed Test Data
```splunk
| inputlookup speed_test_data.csv
```

### Create Upload/Download Ratio
```splunk
source="speed_test_data.csv"
| eval ratio = UPLOAD_MEGABITS / DOWNLOAD_MEGABITS
| table _time IP_ADDRESS DOWNLOAD_MEGABITS UPLOAD_MEGABITS ratio
```

### Sample Analysis
```splunk
# View speed changes over time
source="speed_test_data.csv"
| timechart span=1h avg(DOWNLOAD_MEGABITS) as avg_download avg(UPLOAD_MEGABITS) as avg_upload
```

## Step 2: Vulnerability Assessment

### Critical Vulnerabilities Count
```splunk
source="nessus_logs.csv" dest_ip="10.11.36.23" severity="critical"
| stats count as critical_vulns
```

### Daily Vulnerability Alert
```splunk
source="nessus_logs.csv" 
dest_ip="10.11.36.23" 
severity="critical"
| stats count as critical_vulns
| where critical_vulns > 0
```

Alert Settings:
- Schedule: Daily
- Action: Email to soc@vandalay.com
- Subject: "Critical Vulnerabilities Detected"

## Step 3: Brute Force Detection

### Baseline Analysis
```splunk
source="administrator_logs.csv" name="failed login"
| bucket _time span=1h
| stats count as failed_attempts by _time
| stats avg(failed_attempts) as baseline_attempts
```

### Brute Force Alert
```splunk
source="administrator_logs.csv" name="failed login"
| bucket _time span=1h
| stats count as failed_attempts
| where failed_attempts > threshold
```

Alert Settings:
- Schedule: Hourly
- Action: Email to SOC@vandalay.com
- Subject: "Potential Brute Force Attack"

## Easy Examples

### 1. Speed Test Analysis
```splunk
# Simple speed comparison
source="speed_test_data.csv" 
| table _time IP_ADDRESS DOWNLOAD_MEGABITS UPLOAD_MEGABITS
| sort _time
```

### 2. Basic Vulnerability Check
```splunk
# Count by severity
source="nessus_logs.csv" 
| stats count by severity
| sort -count
```

### 3. Failed Login Counter
```splunk
# Hourly failed login count
source="administrator_logs.csv" name="failed login"
| timechart span=1h count
```

## Tips
1. Always start with basic searches before making complex ones
2. Test alerts with small time ranges first
3. Document baseline calculations
4. Include clear alert messages
5. Use appropriate time spans for each analysis

````



`Notes for challenge`

`source="server_speedtest.csv" host="server_speedtest" sourcetype="csv"  | eval ratio = 'UPLOAD_MEGABITS'/'DOWNLOAD_MEGABITS' | table _time IP_ADDRESS DOWNLOAD_MEGABITS UPLOAD_MEGABITS ratio`


`Attack started on 2020-02-03 at 8:30a.m. things back to normal was at 12:30p.m. same day`

```
source="nessus_logs.csv" host="nessus" sourcetype="csv" dest_ip="10.11.36.23" severity="critical"  vulnerability

source="nessus_logs.csv" host="nessus" sourcetype="csv" dest_ip="10.11.36.23" severity="critical"  vulnerability severity=critical
```

```
source="Administrator_logs.csv" host="administrator_logs" sourcetype="csv" | bucket _time span=5m | stats count by _time | stats avg(count) as baseline
```