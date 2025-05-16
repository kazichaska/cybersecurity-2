````markdown
# Digital Forensics Tools Guide

## 1. Disk Imaging Tools

### FTK Imager
```bash
# Create forensic image
ftk-imager -t dd -s /dev/sda -o case001/evidence.dd
```

### DD (Unix/Linux)
```bash
# Create bit-by-bit copy
dd if=/dev/sda of=disk_image.dd bs=512 status=progress
```

## 2. Memory Analysis Tools

### Volatility
```python
# Analyze Windows memory dump
vol.py -f memory.dump windows.pslist
vol.py -f memory.dump windows.netscan
```

### Memoryze
```bash
# Capture live memory
memoryze.exe -o memory.dump -process all
```

## 3. File System Analysis

### Autopsy
```bash
# Create new case
autopsy --new-case "Case001" --data-source "disk_image.dd"
```

### Sleuth Kit
```bash
# List files and metadata
fls -r disk_image.dd
istat disk_image.dd 12345  # Examine inode
```

## 4. Network Forensics

### Wireshark
```bash
# Capture and analyze traffic
tshark -i eth0 -w capture.pcap
tshark -r capture.pcap -Y "http.request.method==POST"
```

### NetworkMiner
```powershell
# Extract files from PCAP
NetworkMiner.exe -r capture.pcap --export-files
```

## 5. Mobile Forensics

### iPhone Backup Analyzer
```python
# Extract iPhone backup data
iphone_backup_extractor.py -i backup/ -o evidence/
```

### Android Debug Bridge
```bash
# Pull data from Android device
adb pull /data/data/com.app.name/ evidence/
```

## 6. Email Analysis

### Email Header Analyzer
```python
# Parse email headers
email_analyzer.py -f suspicious_email.eml
```

### MailXaminer
```bash
# Extract email attachments
mailxaminer -i mailbox.pst -o extracted_files/
```

## 7. Password Recovery

### Hashcat
```bash
# Crack NTLM hashes
hashcat -m 1000 -a 0 hashes.txt wordlist.txt
```

### John the Ripper
```bash
# Crack Linux shadow passwords
john --format=sha512crypt shadow.txt
```

## 8. Timeline Analysis

### Log2Timeline/Plaso
```bash
# Create super timeline
log2timeline.py timeline.plaso disk_image.dd
psort.py -o l2tcsv -w timeline.csv timeline.plaso
```

## 9. Registry Analysis

### RegRipper
```bash
# Analyze Windows Registry
rip.exe -r NTUSER.DAT -p all
```

## 10. Anti-Forensics Detection

### Timestomp Detector
```bash
# Detect timestamp manipulation
python3 timestomp_detector.py -f suspicious_file.exe
```

## Best Practices

### Documentation
```markdown
1. Tool Selection
   - Document tool version
   - Command line parameters
   - Output files generated

2. Chain of Custody
   - Hash all evidence files
   - Document all actions
   - Maintain access logs
```

### Evidence Collection
```bash
# Calculate file hashes
sha256sum evidence.dd > evidence.hash
# Write protect devices
blockdev --setro /dev/sdb
```
````