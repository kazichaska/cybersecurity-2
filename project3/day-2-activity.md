```markdown
# Day 2: VSI Security Incident Analysis Guide

## Overview
This guide documents the process of analyzing attack logs for both Windows and Apache servers during the VSI security incident.

## Log File Updates
Replace source files in all reports, alerts and dashboards:
- Windows: `windows_server_logs.csv` → `windows_server_attack_logs.csv`
- Apache: `apache_logs.txt` → `apache_attack_logs.txt`

## Windows Server Analysis

### Severity Level Changes
```splunk
source="windows_server_attack_logs.csv" 
| stats count by severity
```
**Finding**: High severity events increased from 329 to 2,222

### Failed Activities Analysis
```splunk
source="windows_server_attack_logs.csv"
| stats count by status
```
**Finding**: Failed activities spiked from 142 to 186

### Suspicious Login Activity
```splunk
source="windows_server_attack_logs.csv"
| stats count by user
| sort -count
```
Key Findings:
- Peak activity: 2,586 events
- Time: March 25, 2020 04:00
- Primary actors: User_k (suspicious activity 03:00-06:00)

## Apache Server Analysis

### HTTP Methods Review
```splunk
source="apache_attack_logs.txt"
| stats count by method
```
**Finding**: Unusual spike in POST requests (1,324 total)

### Geographic Analysis
```splunk
source="apache_attack_logs.txt"
| iplocation src_ip
| stats count by City, Country
```
**Finding**: High volume from Ashburn, US (668 requests)

### URI Analysis
```splunk
source="apache_attack_logs.txt"
| stats count by uri_path
| sort -count
```
**Finding**: Suspicious activity targeting `/VSI_Account_logon.php`

## Attack Timeline

### Critical Events
1. Windows Server
   - Password reset attempts: 4,256 instances
   - Peak attack time: March 25, 2020 04:00
   - Primary target: User authentication system

2. Apache Server  
   - Attack type: Potential brute force
   - Peak time: March 25, 2020 15:00
   - Attack vector: POST requests to login page

## Alert Analysis

### Windows Alerts
- Failed Activity Alert
  - Threshold met: Yes
  - Peak count: 2,586
  - Time: March 25, 2020 04:00

### Apache Alerts  
- International Traffic Alert
  - Threshold met: Yes
  - Count: 937 IPs
  - Recommendation: Adjust threshold

## Best Practices for Future Monitoring

1. Alert Tuning
   - Adjust thresholds based on attack patterns
   - Implement geographic-based filtering
   - Add correlation rules

2. Dashboard Improvements
   - Add real-time user activity tracking
   - Implement geographic visualizations
   - Create attack pattern recognition panels

3. Documentation
   - Maintain detailed incident logs
   - Record threshold adjustments
   - Document response procedures
