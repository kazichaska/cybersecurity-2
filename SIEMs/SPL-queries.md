````markdown
# Splunk Search Processing Language (SPL) Examples

## Basic Windows Log Analysis

### Finding User Account Activities
**1. Basic User Lockout Search**
```splunk
sourcetype="winevent_logs.csv" name="User account locked out"
```

**2. Basic User Deletion Search**
```splunk
sourcetype="winevent_logs.csv" name="User account deleted"
```

### Domain-Specific Searches
**3. Domain B Lockouts**
```splunk
sourcetype="winevent_logs.csv" 
name="User account locked out" 
dest_nt_domain="Domain_B"
```

**4. Domain B Tuesday Deletions**
```splunk
sourcetype="winevent_logs.csv" 
name="User account deleted" 
dest_nt_domain="Domain_B" 
date_wday="Tuesday"
```

## Advanced Piping Examples

### Basic Linux Login Analysis
**1. View All Login Events**
```splunk
source="Linux_login.csv" 
host="Linux_Server" 
sourcetype="csv"
```

### Data Manipulation with Pipes
**2. First 20 Records**
```splunk
source="Linux_login.csv" 
host="Linux_Server" 
sourcetype="csv" 
| head 20
```

**3. Last 20 Records**
```splunk
source="Linux_login.csv" 
host="Linux_Server" 
sourcetype="csv" 
| tail 20
```

### Sorting Examples
**4. First 20 Records by Source IP**
```splunk
source="Linux_login.csv" 
host="Linux_Server" 
sourcetype="csv" 
| head 20 
| sort src_ip
```

**5. Top 20 After IP Sort**
```splunk
source="Linux_login.csv" 
host="Linux_Server" 
sourcetype="csv" 
| sort src_ip 
| head 20
```

## Targeted User Investigation

### Activity Analysis Queries
**1. Successful Logins**
```splunk
sourcetype="winevent_logs_2.csv" 
name="An account was successfully logged on"
```

**2. Account Changes**
```splunk
sourcetype="winevent_logs_2.csv" 
name="User account was changed"
```

**3. Security Access Grants**
```splunk
sourcetype="winevent_logs_2.csv" 
name="System security access was granted to an account"
```

### Account Statistics
**4. Most Active Accounts**
```splunk
sourcetype="winevent_logs_2.csv"
| stats count by name Account_Name
| sort -count
```

**5. Top 50 by Computer**
```splunk
sourcetype="winevent_logs_2.csv"
| stats count by name Account_Name ComputerName
| sort ComputerName
| head 50
```

## Tips & Best Practices
1. Use field selectors in Splunk UI for faster query building
2. Start with broad searches, then narrow results
3. Consider time ranges for better performance
4. Use pipes (|) to refine and format results
5. Test queries with smaller time ranges first


## Fortinet IPS Log Analysis

### Basic IPS Investigation
**1. Find Top Source IP**
```splunk
sourcetype="fortinet_IPS_logs.csv" 
| stats count by src_ip 
| sort -count 
| head 1
```

**2. Identify Primary Attack**
```splunk
sourcetype="fortinet_IPS_logs.csv" 
| stats count by attack_name 
| sort -count 
| head 1
```

### Detailed Analysis Queries
**3. Geographic Location Analysis**
```splunk
sourcetype="fortinet_IPS_logs.csv" 
| iplocation src_ip 
| stats count by City, Country 
| sort -count
```

**4. Attack Pattern Analysis**
```splunk
sourcetype="fortinet_IPS_logs.csv" 
| stats count by attack_name, severity
| sort -count
```

### Summary Findings

1. **Device Information**
   - Fortinet IPS (Intrusion Prevention System)
   - Network security appliance that monitors and blocks malicious traffic

2. **Attack Analysis**
   - Identify top source IP locations
   - Review attack patterns and severity levels
   - Monitor frequency of attacks

3. **Recommended Mitigations**
   - Update IPS signatures regularly
   - Implement geo-blocking for problematic regions
   - Configure appropriate blocking rules
   - Monitor and adjust false positive rates

## Tips for IPS Log Analysis
1. Focus on high-severity attacks first
2. Look for patterns in source IPs
3. Correlate attacks with time patterns
4. Review blocked vs. detected events
5. Monitor for false positives

## Note
These queries are examples and may need modification based on your specific log formats and requirements.
````