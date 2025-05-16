# Digital Evidence Acquisition and Analysis Guide

## Email Analysis in Autopsy

### Viewing Email Evidence
```sql
-- Navigate to Email Messages in Autopsy
SELECT 
    sender,
    subject,
    body,
    date_sent
FROM email_messages
WHERE sender LIKE '%peter%'
ORDER BY date_sent DESC;
```

### Email Export Process
```bash
# Export emails to CSV format
$ autopsy --export-emails /Cases/Peter/emails.csv

# Convert to readable format
$ python3 email_parser.py emails.csv > readable_emails.txt
```

## SMS Message Analysis

### Extracting SMS Data
```sql
-- Query SMS database
SELECT 
    address AS phone_number,
    date AS timestamp,
    text AS message_content
FROM message 
ORDER BY date DESC;
```

### Export SMS Messages
```bash
# Export to CSV format
mkdir -p /Evidence/SMS/
sqlite3 -csv sms.db "SELECT * FROM message;" > /Evidence/SMS/messages.csv
```

## GPS and WiFi Location Analysis

### Extract GPS Data
```python
# Extract GPS coordinates from EXIF data
from PIL import Image
from PIL.ExifTags import TAGS

def get_gps(image_path):
    with Image.open(image_path) as img:
        exif = { TAGS[k]: v for k, v in img._getexif().items() }
        return exif['GPSInfo']
```

### WiFi Location Analysis
```sql
-- Query WiFi connection history
SELECT 
    SSID,
    last_connected,
    location_data
FROM wifi_history
ORDER BY last_connected DESC;
```

## Evidence Worksheet Template

```markdown
# Digital Forensics Evidence Worksheet

## Case Information
- Case Number: 
- Examiner Name:
- Date/Time:
- Evidence Item:

## Email Evidence
| Date | From | To | Subject | Key Content |
|------|------|-----|---------|-------------|
|      |      |     |         |             |

## SMS Evidence
| Date | Number | Message | Relevance |
|------|---------|---------|-----------|
|      |         |         |           |

## Location Data
| Date | Type | Location | Notes |
|------|------|----------|-------|
|      |      |          |       |

## Additional Notes
- 
- 
```

## Example Evidence Collection

### Email Evidence
```bash
# Collect all emails from specific date range
$ autopsy --query "
    SELECT * FROM emails 
    WHERE date BETWEEN '2023-01-01' AND '2023-12-31'
    AND (sender LIKE '%peter%' OR recipient LIKE '%peter%')
" > peter_emails_2023.csv
```

### Location History
```python
# Extract location history to KML
def export_locations_to_kml():
    kml = simplekml.Kml()
    for location in locations:
        point = kml.newpoint(
            name=location.timestamp,
            coords=[(location.longitude, location.latitude)]
        )
    kml.save("location_history.kml")
```

## Report Generation

### Evidence Summary
```bash
# Generate evidence summary
cat << EOF > evidence_summary.md
# Case Evidence Summary

## Email Analysis
- Total emails processed: $(wc -l emails.csv)
- Key conversations: $(grep -c "important" emails.csv)

## SMS Analysis
- Total messages: $(wc -l sms.csv)
- Timeline: $(head -n1 sms.csv) to $(tail -n1 sms.csv)

## Location Data
- Unique locations: $(sort -u locations.csv | wc -l)
- Time period covered: $(date -r locations.csv)
EOF
```

### Final Report Template
```markdown
# Digital Forensics Report

## Executive Summary
[Brief overview of findings]

## Evidence Examined
1. Email correspondence
2. SMS messages
3. Location data

## Key Findings
1. [Email evidence]
2. [SMS evidence]
3. [Location evidence]

## Timeline of Events
[Chronological listing of key events]

## Supporting Documentation
- Evidence worksheets
- Data exports
- Analysis logs

## Examiner Information
- Name:
- Date:
- Tools used:
```