````markdown
# SIEM Implementation Activities Guide

## Activity 1: Monitoring Assets and Risk Assessment

### Scenario: OMP Company Security Events
1. **High Risk Events**
   - Database server showing unusual outbound traffic at 3 AM
   - Multiple failed login attempts on CEO's email account
   
2. **Medium Risk Events**
   - Printer offline in marketing department
   - Employee accessing social media during work hours

3. **Low Risk Events**
   - Coffee machine IoT device disconnected
   - Office temperature sensor malfunction

### Risk Assessment Matrix
| Event | Impact | Likelihood | Risk Level |
|-------|---------|------------|------------|
| Database server unusual traffic | High | High | Critical |
| Multiple failed logins | High | Medium | High |
| Printer offline | Low | High | Medium |
| Social media access | Low | High | Medium |
| IoT device issues | Low | Low | Low |

## Activity 2: Log Analysis Exercise

### Common Log Examples

1. **Windows Event Log**
```text
Event ID: 4625
Time: 2025-04-19 09:15:00
Type: Audit Failure
User: jsmith
Source: Workstation01
Message: Failed login attempt
```

2. **Apache Web Server Log**
```text
192.168.1.100 - - [19/Apr/2025:09:20:15 -0500] "GET /login.php HTTP/1.1" 200 4523
```

3. **Firewall Log**
```text
Apr 19 09:25:33 firewall kernel: BLOCKED INPUT: IN=eth0 SRC=192.168.1.50 DST=192.168.1.100 PORT=445
```

## Activity 3: Log Aggregation and Normalization

### Sample Web Server Logs
```text
Original Log 1:
73.54.12.89 - - [19/Apr/2025:10:15:30 -0500] "GET /admin HTTP/1.1" 403 287

Original Log 2:
[2025-04-19T10:15:31] client: 73.54.12.89 request: "POST /login" status: 401
```

### Normalized Fields
- Timestamp: 2025-04-19 10:15:30
- Source IP: 73.54.12.89
- Action: GET/POST
- Resource: /admin, /login
- Status: 403, 401

## Activity 4: Creating Correlation Rules

### Example Rule: Detecting Brute Force Attack
```yaml
Rule Name: Simple_Brute_Force_Detection
Description: Detect multiple failed logins from same source

Conditions:
- Count failed logins > 3
- Time window: 5 minutes
- Same source IP
- Same target account

Actions:
1. Create alert ticket
2. Send email notification
3. Block source IP for 1 hour
```

## Activity 5: SIEM Vendor Selection

### OMP Company Requirements
- Budget: $50,000/year
- Company Size: 250 employees
- Data Volume: 5GB/day
- Compliance: PCI DSS

### Vendor Comparison
| Feature | Vendor A | Vendor B | Vendor C |
|---------|----------|----------|----------|
| Cost/Year| $45,000 | $60,000 | $30,000 |
| Storage | 1TB | 2TB | 500GB |
| Support | 24/7 | Business hrs | Email only |
| Integration | Excellent | Good | Limited |

### Recommendation
Based on requirements, Vendor A is recommended because:
- Within budget
- Adequate storage
- 24/7 support
- Good integration capabilities

## Summary Tips
1. Always prioritize critical assets
2. Document all security events
3. Standardize log formats
4. Test correlation rules regularly
5. Consider scalability in SIEM selection
````