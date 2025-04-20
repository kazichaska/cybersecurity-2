````markdown
# Splunk Reports and Alerts Guide

## 1. Statistical Analysis with SPL

### Basic Stats Commands
```splunk
# Count events by source IP
sourcetype=access_* 
| stats count BY src_ip

# Calculate average response time
sourcetype=access_* 
| stats avg(response_time) as avg_response
```

### Using Eval for New Fields
```splunk
# Create risk score based on response code
sourcetype=access_* 
| eval risk_level=case(
    status >= 500, "High",
    status >= 400, "Medium",
    1=1, "Low"
)
```

## 2. Scheduling Reports

### Daily Login Activity Report
```splunk
# Run daily at 6 AM
sourcetype=auth 
| stats count BY user
| sort -count
| rename count as login_attempts
```

### Weekly Failed Login Report
```splunk
# Schedule for Monday 8 AM
sourcetype=auth status=failed 
| stats count BY src_ip, user
| where count > 5
```

## 3. Baseline Analysis

### Normal Activity Baseline
```splunk
# Average hourly events
sourcetype=* 
| bucket _time span=1h
| stats count BY _time
| stats avg(count) as baseline
```

### Traffic Pattern Analysis
```splunk
# Hourly traffic patterns
sourcetype=access_* 
| timechart span=1h count
| eval is_business_hours=if(
    strftime(_time,"%H") >= "09" AND 
    strftime(_time,"%H") <= "17", 
    1, 0)
```

## 4. Alert Design

### High Volume Alert
```splunk
# Alert if traffic exceeds baseline by 200%
sourcetype=access_* 
| stats count as current_count
| where current_count > baseline * 2
```

### Failed Authentication Alert
```splunk
# Alert on brute force attempts
sourcetype=auth status=failed 
| stats count BY src_ip, user
| where count > 10
```

## Alert Configuration Tips

1. **Throttling**
   - Set minimum time between alerts
   - Group similar events
   - Avoid alert fatigue

2. **Priority Levels**
   - High: Immediate response needed
   - Medium: Investigation required
   - Low: Monitoring only

3. **Alert Actions**
   - Email notifications
   - Webhook integration
   - Ticket creation
   - Script execution

4. **Testing**
   - Validate triggers
   - Check false positive rate
   - Monitor alert volume

## Best Practices

1. Start with broad searches, then refine
2. Use appropriate time ranges
3. Test alerts in development first
4. Document alert criteria
5. Regular review and tuning
````