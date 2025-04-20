# Module 18 Day 1: Monitoring Assets

## Activity Instructions

As a newly hired SOC manager at Omni Medical Products (OMP), an online medical supply company, you are tasked with designing their first SOC. Given budget constraints, you must prioritize which security events to monitor.

## Background

- OMP has experienced several security incidents
- No existing SOC infrastructure
- Limited monitoring budget available

## Task

Analyze and rank the following security events (1-8) based on risk level to OMP:

**Events to Rank:**

1. [ ] Employee laptop infected with ransomware from phishing email (Omaha office)
2. [ ] DDoS attack causing web server outage (New York office)
3. [ ] Brute-force attacks on administrative application website
4. [ ] Unauthorized vendor physical access to data center (Atlanta office)
5. [ ] Terminated employee retaining active directory access
6. [ ] SQL injection attempts on purchasing web application
7. [ ] Inventory database audit log failure (disk space)
8. [ ] Suspicious VPN access from Asia (no employees located there)

## Requirements

1. Rank events from 1 (highest priority) to 8 (lowest priority)
2. Provide justification for:
    - Highest ranked event
    - Lowest ranked event

## Note

There is no single correct order. Your ranking will be evaluated based on the quality of your risk assessment justification.



````markdown
# OMP Security Event Risk Assessment

## Event Rankings (1-8, 1 being highest risk)

1. A. Ransomware infection from phishing email
2. F. SQL injection attempts on purchasing web application
3. H. Suspicious VPN access from Asia
4. E. Terminated employee active directory access
5. B. DDoS attack on New York web server
6. D. Unauthorized vendor physical access
7. C. Brute-force attacks on admin website
8. G. Database audit log disk space issue

## Risk Assessment Justification

### Highest Risk Events

1. **Ransomware Infection (Event A)**
   - Immediate threat to data confidentiality and availability
   - Potential for rapid spread across network
   - Direct financial impact (ransom demands/recovery costs)
   - Risk of medical data compromise
   - Regulatory compliance concerns (HIPAA)

2. **SQL Injection Attempts (Event F)**
   - Direct threat to customer/medical data
   - Financial system compromise risk
   - Compliance implications
   - Potential for data theft

### Lowest Risk Events

7. **Brute Force Attacks (Event C)**
   - Common occurrence
   - Typically protected by existing controls
   - Limited scope of impact
   - Easily mitigated with account lockout policies

8. **Audit Log Issue (Event G)**
   - Administrative/maintenance issue
   - No direct security breach
   - Can be resolved through monitoring
   - Impact limited to compliance/forensics

## Risk Assessment Criteria Used

- **Impact Severity**
  - Data confidentiality
  - System availability
  - Financial loss potential
  - Regulatory compliance

- **Attack Vector**
  - Ease of exploitation
  - Potential spread
  - Required technical sophistication

- **Detection & Response**
  - Time to detect
  - Ease of containment
  - Recovery complexity

- **Business Impact**
  - Operational disruption
  - Customer trust
  - Regulatory penalties
  - Reputational damage

## Recommended Immediate Actions

1. **High Priority**
   - Isolate infected ransomware system
   - Implement web application firewall
   - Block VPN access from unauthorized regions

2. **Medium Priority**
   - Review/update access control procedures
   - Enhance DDoS protection
   - Implement physical access controls

3. **Lower Priority**
   - Set up automated storage monitoring
   - Review brute force protection measures
````


