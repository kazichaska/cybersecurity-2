````markdown
# Introduction to Splunk Statistics

## Basic Statistics Commands

### 1. Count by Account Name
```splunk
# Simple count of events by account
source="statsreport.csv" 
| stats count by Account_Name
```

### 2. Top Values Analysis
```splunk
# Top 20 accounts with percentages
source="statsreport.csv" 
| top limit=20 Account_Name
```

## Creating Custom Fields with Eval

### 1. Basic Brute Force Detection
```splunk
# Identify potential brute force attempts
source="statsreport.csv" 
| eval BruteForce = if(
    'EventCode'="4740",
    "Potential Brute Force", 
    "Not Brute Force"
)
```

### 2. Database Traffic Analysis
```splunk
source="fortinet_logs.csv"
| eval DB_Type = if(
    dest_ip="12.130.60.5",
    "Customer DB",
    "Non-Customer DB"
)
| stats count by DB_Type
```

## Statistical Reports Examples

### 1. Top Destination IPs
```splunk
source="fortinet_logs.csv"
| top limit=20 dest_ip
```

### 2. Source IP Analysis
```splunk
source="fortinet_logs.csv"
| top limit=10 src_ip
```

### 3. Source IP/Port Combinations
```splunk
source="fortinet_logs.csv"
| top limit=10 src_ip src_port
```

## Best Practices

1. **Report Creation**
   - Start with basic stats
   - Add fields as needed
   - Use clear field names
   - Include percentages when relevant

2. **Using Eval**
   - Create meaningful field names
   - Use descriptive values
   - Keep conditions simple
   - Document complex evaluations

3. **Data Presentation**
   - Sort by relevant metrics
   - Limit results appropriately
   - Include percentage when useful
   - Format for non-technical audiences

## Tips for Success

1. Test queries with smaller datasets first
2. Verify field names before creating reports
3. Use comments to document complex queries
4. Preview results before sharing reports
5. Consider your audience when formatting

## Common Use Cases

1. **Security Monitoring**
   - Login attempt tracking
   - Failed authentication reporting
   - Access pattern analysis
   - Attack detection

2. **System Analysis**
   - Resource usage tracking
   - Error rate monitoring
   - Performance metrics
   - Capacity planning

3. **Compliance Reporting**
   - Access auditing
   - Policy violation tracking
   - Security incident documentation
   - Activity summaries
````