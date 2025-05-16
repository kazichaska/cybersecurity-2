````markdown
# Important Files for Digital Forensics

## User Data & Communications

### Contact Information
| File | Description |
|------|-------------|
| `AddressBook.sqlitedb` | Contact information (names, emails, birthdays, organizations) |
| `AddressBookImages.sqlitedb` | Contact photos and associated images |

### Communication Records
| File | Description |
|------|-------------|
| `call_history.db` | Call logs with timestamps |
| `sms.db` | Text and multimedia messages |
| `voicemail.db` | Stored voicemail messages |
| `xxxxx.emlx` | Email message contents |

## Web & Location Data

### Browser Information
| File | Description |
|------|-------------|
| `Safari/Bookmarks.db` | Saved URLs and bookmarks |
| `Safari/History.db` | Browsing history and timestamps |

### Location Data
| File | Description |
|------|-------------|
| `Maps/History.plist` | Location search history |
| `Maps/Bookmarks.plist` | Saved location bookmarks |
| `consolidated.db` | GPS tracking and location data |

## Device Information

### System Details
| File | Description |
|------|-------------|
| `data_ark.plist` | Host name and OS version |
| `activation_record.plist` | Device identifiers (ICCID, IMEI, Serial) |

### Usage Data
| File | Description |
|------|-------------|
| `CellularUsage.db` | Phone number and usage details |
| `accounts3.sqlite` | User email accounts |

## Forensic Analysis Tips
```bash
# Extract SQLite databases
sqlite3 AddressBook.sqlitedb .dump > contacts.txt

# View plist files
plutil -p data_ark.plist

# Convert EMLX to readable format
emlxconvert xxxxx.emlx > email.txt
```

### Common File Locations
```plaintext
/private/var/mobile/Library/AddressBook/
/private/var/mobile/Library/Safari/
/private/var/mobile/Library/Maps/
/private/var/mobile/Library/Mail/
```
````