# Log Aggregation and Normalization Analysis

## Activity Context
As the SOC manager at OMP, you need to analyze web server logs due to recent DoS attempts. The challenge involves normalizing logs from different web servers that use varying formats.

## Required Fields for Analysis
- Date
- IP Address
- Resource Requested
- User Agent
- HTTP Response Code
- File Size
- Protocol and Version

## Log Analysis

### Log Record 1
```plaintext
83.149.9.216 - - [17/May/2015:10:05:12 +0000] "GET /presentations/logstash HTTP/1.1" 200 7697  "Mozilla/5.0 (Macintosh; Intel Mac OS X 19_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.23.34.77 Safari/537.36"
```

**Normalized Fields:**
- **Date:** 17/May/2015:10:05:12 +0000
- **IP:** 83.149.9.216
- **Resource:** /presentations/logstash
- **Protocol/Version:** HTTP/1.1
- **Response Code:** 200
- **File Size:** 7697
- **User Agent:** Mozilla/5.0 (Macintosh; Intel Mac OS X 19_9_1) AppleWebKit/537.36

### Log Record 2
```plaintext
"GET /presentations/newfile.js HTTP/1.1" 200 7697  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36" 151.32.9.84 - - [18/May/2019:10:05:12 +0000]
```

**Normalized Fields:**
- **Date:** 18/May/2019:10:05:12 +0000
- **IP:** 151.32.9.84
- **Resource:** /presentations/newfile.js
- **Protocol/Version:** HTTP/1.1
- **Response Code:** 200
- **File Size:** 7697
- **User Agent:** Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36

### Log Record 3
```plaintext
[15/May/2015:10:05:12 +0000] "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.234344.77 Safari/537.36" 35.19.88.100 -  "GET /presentations/extrafile.js HTTP/1.1" 200 7697
```

**Normalized Fields:**
- **Date:** 15/May/2015:10:05:12 +0000
- **IP:** 35.19.88.100
- **Resource:** /presentations/extrafile.js
- **Protocol/Version:** HTTP/1.1
- **Response Code:** 200
- **File Size:** 7697
- **User Agent:** Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36

## Observations
1. All logs contain the same required fields but in different orders
2. All requests are using HTTP/1.1 protocol
3. All responses have 200 (Success) status code
4. All requests are GET requests
5. All requests are for resources in the /presentations/ directory
6. All clients are using MacOS with Chrome browser
7. File sizes are consistent (7697 bytes)

This normalized format will help in monitoring for DoS attempts by making it easier to:
- Track request patterns from specific IPs
- Monitor resource access patterns
- Identify unusual user agent strings
- Track response sizes for anomaly detection