# Splunk Search and Analysis Guide

## Project Requirements Overview
- Explore and select Splunk add-ons/apps
- Upload and manage log data
- Create SPL queries for security analysis

````markdown
## 1. Splunk Add-ons and Apps Selection

### Security Essentials App
```splunk
| rest /services/apps/local | search title="*security*"
```

### Common Security Add-ons
- Splunk Enterprise Security (ES)
- Splunk Security Essentials
- Splunk SOAR
- Splunk Threat Intelligence

## 2. Log Upload Process

### Using Command Line
```bash
./splunk add monitor /path/to/logs/*.log -sourcetype custom_logs
```

### Using Web Interface
1. Settings → Data Inputs
2. Select input type
3. Configure monitoring

## 3. SPL Query Examples

### Failed Login Detection
```splunk
sourcetype=access_* status=failed 
| stats count BY src_ip user 
| where count >= 5
```

### Potential Data Exfiltration
```splunk
sourcetype=firewall_logs dest_port=443 bytes_out>1000000
| stats sum(bytes_out) as total_bytes BY src_ip
| where total_bytes > 100000000
```

### Suspicious Process Analysis
```splunk
sourcetype=windows_events EventCode=4688
| transaction pid maxspan=1m
| where duration > 300
| table Computer, ParentProcessName, NewProcessName, duration
```

## 4. Best Practices

### Query Optimization
- Use time-based filters first
- Leverage indexed fields
- Minimize wildcards
- Use statistical commands effectively

### Data Management
- Configure appropriate retention
- Set up data rollover policies
- Monitor index sizes
- Archive important data

### Security Monitoring
- Create saved searches
- Set up alerts
- Use correlation searches
- Implement dashboards
````

This guide provides structured examples for working with Splunk in a security context, including app selection, data ingestion, and SPL query examples for common security scenarios.