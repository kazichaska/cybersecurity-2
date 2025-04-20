# Rule Correlation Activity

## Original Task Instructions
As the SOC manager at OMP, after normalizing web server logs, create a plan for identifying attacks in real-time. Design plainly worded correlation rules that will later be implemented in SIEM to detect:

1. Suspicious and unsuccessful web activity from Beijing
2. Flood of web requests from a single-source IP in a short period
3. Suspicious successful web requests for JPG images from non-US IPs

## Solution: Correlation Rules Design

### Rule 1: Beijing Suspicious Activity Detection
```plaintext
IF source_ip.geolocation = "Beijing" AND
   http_response_code >= 400 AND
   count(events) > 10 within 5 minutes
THEN
   create_alert(
      severity: "Medium",
      description: "Multiple failed requests detected from Beijing",
      evidence: {
         source_ip,
         timestamp,
         requested_resource,
         response_code
      }
   )
```

### Rule 2: DoS Attack Detection
```plaintext
IF count(requests) from single_source_ip > 1000 AND
   timespan <= 60 seconds AND
   distinct_urls <= 3
THEN
   create_alert(
      severity: "High",
      description: "Potential DoS attack detected",
      evidence: {
         source_ip,
         request_count,
         timespan,
         urls_accessed
      }
   )
```

### Rule 3: Foreign Image Access Monitoring
```plaintext
IF requested_resource matches "*.jpg" AND
   source_ip.country != "United States" AND
   http_response_code = 200 AND
   count(events) > 50 within 1 hour
THEN
   create_alert(
      severity: "Low",
      description: "High volume of successful image access from foreign IP",
      evidence: {
         source_ip,
         country,
         accessed_images,
         timestamp_range
      }
   )
```

## Implementation Considerations

### 1. Threshold Management
- Configure dynamic thresholds based on:
  - Historical traffic patterns
  - Business hours
  - Peak usage periods
  - Seasonal variations

### 2. Geolocation Accuracy
- Maintain updated IP geolocation databases
- Account for:
  - VPN traffic
  - Proxy servers
  - CDN endpoints
  - Known business partner IPs

### 3. False Positive Reduction
- Whitelist legitimate sources:
  - Search engine crawlers
  - CDN servers
  - Business partners
  - Known good IPs

### 4. Response Procedures
- Define clear escalation paths
- Document investigation steps
- Create automated response actions:
  - IP blocking
  - Rate limiting
  - Alert notification

This design provides a foundation for implementing effective SIEM rules while considering practical operational factors that affect detection accuracy.