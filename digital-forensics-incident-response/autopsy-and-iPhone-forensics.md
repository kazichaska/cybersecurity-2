````markdown
# iPhone and Smartphone Forensics Guide

## Overview
This guide covers the fundamentals of iPhone forensics, including data extraction, analysis methods, and evidence handling using Autopsy.

## Smartphone Forensics Methods

### Physical Acquisition
```bash
# Using iPhone Backup Analyzer
$ iphone_backup_extractor -i backup_folder -o evidence_folder
```

### Logical Acquisition
```sql
-- Query iPhone Backup Database
SELECT * FROM Messages 
WHERE date > '2023-01-01'
ORDER BY date DESC;
```

## iPhone File Structure

### Key Directories
```plaintext
/private/var/mobile/
├── Applications/        # App data
├── Library/            # System data
│   ├── SMS/           # Messages
│   ├── CallHistory/   # Phone calls
│   └── Photos/        # Camera roll
└── Media/             # User media
```

### Common Evidence Locations
```plaintext
SMS Database: /var/mobile/Library/SMS/sms.db
Photos: /var/mobile/Media/DCIM/
Contacts: /var/mobile/Library/AddressBook/
Voice Memos: /var/mobile/Media/Recordings/
```

## Establishing Device Ownership

### Basic Information
```sql
-- Query device info from backup
SELECT 
    device_name,
    GUID,
    last_backup_date
FROM device_info;
```

### User Data Analysis
```plaintext
Evidence Sources:
1. iCloud account details
2. Device name format
3. Contact information
4. Photo metadata
5. App login data
```

## Autopsy iPhone Analysis

### Creating New Case
```plaintext
1. File → New Case
2. Case Name: iPhone_Investigation_001
3. Base Directory: /Cases/iPhone/
4. Case Type: Single-user
```

### Adding iPhone Image
```plaintext
1. Add Data Source
2. Select "Disk Image or VM File"
3. Navigate to iPhone backup/image
4. Configure ingest modules:
   - Picture Analyzer
   - Email Parser
   - Recent Activity
```

## Evidence Extraction Examples

### Text Messages
```sql
-- Extract messages with attachments
SELECT 
    message_text,
    date_created,
    attachment_path
FROM message_table
WHERE has_attachment = 1;
```

### Photo Evidence
```bash
# Extract all JPG files
$ find /Cases/iPhone_001/Export -name "*.jpg" -exec cp {} /Evidence/Photos/ \;
```

### Call Logs
```sql
-- Get recent calls
SELECT 
    number,
    date,
    duration,
    call_type
FROM calls
ORDER BY date DESC
LIMIT 10;
```

## Practical Examples

### Finding Device Owner
```plaintext
1. Check Settings app data:
   /private/var/mobile/Library/Preferences/
   - Look for Apple ID
   - Device name
   - Phone number

2. Review contacts marked as "ME":
   /var/mobile/Library/AddressBook/
```

### Extracting WhatsApp Data
```sql
-- Get WhatsApp messages
SELECT 
    message_text,
    timestamp,
    sender_name
FROM WhatsApp.sqlite
WHERE timestamp > '2023-01-01';
```

### Photo Analysis
```bash
# Extract photo metadata
$ exiftool -csv /Evidence/Photos/* > photo_metadata.csv
```

## Best Practices

### Documentation
```markdown
1. Evidence Collection
   - Device make/model
   - iOS version
   - Acquisition method
   - Tool versions used

2. Analysis Steps
   - Searches performed
   - Files examined
   - Evidence found
```

### Data Export
```bash
# Create structured export
mkdir -p Evidence/{Photos,Messages,Calls,Contacts}
cp /Case/*/photos.* Evidence/Photos/
cp /Case/*/sms.* Evidence/Messages/
```
````