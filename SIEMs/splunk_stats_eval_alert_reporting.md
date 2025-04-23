````markdown
# Splunk Statistics, Eval, Alert, and Reporting Guide

## 1. DoS Attack Analysis

### Statistical Reports
```splunk
# Top 20 Destination IPs
source="fortinet_logs.csv" 
| top limit=20 dest_ip showperc=true

# Top 10 Source IPs
source="fortinet_logs.csv" 
| top limit=10 src_ip showperc=true

# Top 10 Source IP/Port Combinations
source="fortinet_logs.csv" 
| top limit=10 src_ip src_port showperc=true
```

### Database Attack Monitoring
```splunk
# Identify Customer Database Traffic
source="fortinet_logs.csv" 
| eval DB_Type=if(
    dest_ip="12.130.60.5",
    "Customer DB",
    "Non-Customer DB"
)
| stats count by DB_Type
```

## 2. Scheduled Database Report

### Daily Attack Analysis
```splunk
# Database Traffic Report
source="fortinet_logs.csv" 
| eval DB_Type=if(
    dest_ip="12.130.60.5",
    "Customer DB",
    "Non-Customer DB"
)
| stats count by DB_Type
```

Report Configuration:
- Schedule: Daily at 12 PM
- Time Range: Last 24 hours
- Email: management@ompcompany.biz
- Subject: "Database Attack Report"
- Message: "Daily database attack report is now available"

## 3. Brute Force Analysis

### Baseline Analysis
```splunk
# Failed Login Analysis
source="windowsrawlogs.txt" EventCode=4625
| bucket _time span=1h
| stats count as failed_logins by _time
| stats avg(failed_logins) as avg_failed_logins
```

### Attack Detection
```splunk
# February 11 Analysis
source="windowsrawlogs.txt" EventCode=4625
| bucket _time span=1h
| stats count as failed_logins by _time
| where _time >= strptime("2020-02-11", "%Y-%m-%d")
```

## 4. Brute Force Alerting

### Standard Server Alert
```splunk
# Hourly Failed Login Monitor
source="windowsrawlogs.txt" EventCode=4625
| bucket _time span=1h
| stats count as failed_logins
| where failed_logins > [threshold]
```

Alert Configuration:
- Schedule: Hourly
- Email: SOC_Team@ompcompany.biz
- Subject: "Brute Force Alert"
- Message: "Potential brute force attack detected. Please investigate immediately."

### High-Volume Server Alert
```splunk
# Bonus Server Monitor
source="bonus_logs.txt" EventCode=4625
| bucket _time span=1h
| stats count as failed_logins
| where failed_logins > [adjusted_threshold]
```

## Best Practices

1. **Statistical Analysis**
   - Establish clear baselines
   - Consider time patterns
   - Account for normal variations

2. **Report Scheduling**
   - Align with business hours
   - Choose appropriate intervals
   - Include context in notifications

3. **Alert Design**
   - Set appropriate thresholds
   - Minimize false positives
   - Provide clear response instructions
   - Consider alert fatigue

4. **Documentation**
   - Document baseline calculations
   - Record threshold adjustments
   - Track false positive/negative rates
````