# 🛠️ Active Directory Personal Preferences Reference

## 📌 Quick Navigation
- [Create Reverse Lookup Zone](#-create-reverse-lookup-zone)
- [Add Preferred Columns to ADSI](#-add-preferred-columns-to-adsi)
- [View Operating System Column](#-view-operating-system-column)

---

## 🔄 Create Reverse Lookup Zone

### 📍 Navigation Path
```
Windows Administrative Tools
└── DNS
    └── DC01 (double-click)
        └── Reverse Lookup Zones (double-click)
```

### 🔧 Configuration Steps

1. **Right-click** `Reverse Lookup Zones`
2. Select **New Zone...**
3. Click **Next**

#### Zone Configuration
| Step | Setting | Value |
|------|---------|-------|
| 1️⃣ | Zone Type | **Primary zone** |
| 2️⃣ | Replication Scope | **To all DNS servers running on domain controllers in this forest: ADLAB.HOME** |
| 3️⃣ | Zone Type | **IPv4 Reverse Lookup Zone** → Next |
| 4️⃣ | Network ID | **172.23.150** → Next |
| 5️⃣ | Dynamic Updates | **Allow only secure dynamic updates** → Next |
| 6️⃣ | Complete | **Finish** |

<details>
<summary>💡 Quick Command Alternative</summary>

```powershell
Add-DnsServerPrimaryZone -NetworkID "172.23.150.0/24" -ReplicationScope "Forest" -DynamicUpdate "Secure"
```
</details>

---

## 📊 Add Preferred Columns to ADSI

### 📍 Navigation Path
```
Windows Administrative Tools
└── ADSI Edit
```

### 🔧 Configuration Steps

1. **Right-click** `ADSI Edit`
2. Select **Connect to...**

#### Connection Settings
<pre>
📁 Select a well known Naming Context:
    ✅ Configuration → OK
</pre>

#### Navigate to Display Specifiers
```
Configuration
└── CN=Configuration
    └── CN=DisplaySpecifiers
        └── CN=409
            └── CN=organizationalUnit
```

#### Add Extra Columns

| Action | Details |
|--------|---------|
| 1️⃣ **Find** | Property: `extraColumns` |
| 2️⃣ **Edit** | Click Edit button |
| 3️⃣ **Add Value** | `operatingSystem,Operating System,0,200,0` |
| 4️⃣ **Confirm** | Add → OK → Apply → OK |

> 📝 **Note:** The format is: `attributeName,Display Name,unused,width,unused`

---

## 👁️ View Operating System Column

### 📍 Location
```
Active Directory Users and Computers (Maximize window)
```

### 🔧 Add Column to Domain Controllers

<pre>
📁 AD.LAB (Expand)
    └── 📁 Domain Controllers (Click)
</pre>

**Steps:**
1. Go to **View** menu
2. Select **Add/Remove Columns...**
3. Find **Operating System** in available columns
4. Click **Add →**
5. Click **OK**

### 🔧 Add Column to Member Servers

<pre>
📁 LAB (Expand)
    └── 📁 Member Servers (Click)
</pre>

**Steps:**
1. Go to **View** menu
2. Select **Add/Remove Columns...**
3. Find **Operating System** in available columns
4. Click **Add →**
5. Click **OK**

---

## 🎯 Quick Reference Card

### Common Paths
| Tool | Path |
|------|------|
| **DNS Manager** | `Windows Administrative Tools → DNS` |
| **ADSI Edit** | `Windows Administrative Tools → ADSI Edit` |
| **AD Users & Computers** | `Windows Administrative Tools → Active Directory Users and Computers` |

### Keyboard Shortcuts
| Action | Shortcut |
|--------|----------|
| Refresh | `F5` |
| Properties | `Alt + Enter` |
| New Object | `Ctrl + N` |

### Common Values
| Setting | Value |
|---------|-------|
| **Network ID** | `172.23.150` |
| **Forest** | `ADLAB.HOME` |
| **Locale ID** | `409` (English-US) |

---

## 📚 Additional Notes

> ⚠️ **Important:** Always ensure you have proper administrative privileges before making these changes.

> 💡 **Tip:** The Operating System column helps quickly identify server versions across your infrastructure.

> 🔒 **Security:** "Allow only secure dynamic updates" ensures DNS records are protected by Active Directory authentication.

---

*Last Updated: Documentation for AD Lab Environment*



# Create reverse lookup zone
Windows Administrative Tools
	DNS
Double-click DC01
Double-click Reverse Lookup Zones
Right-click Reverse Lookup Zones
	New Zone...
	Next
	Primary zone
	To all DNS servers running on domain controllers in this forest: ADLAB.HOME
	IPv4 Reverse Lookup Zone
	Next
	Network ID: 172.23.150
	Next
	Allow only secure dynamic updates
	Next
	Finish


# Add preffered columns to ADSI
Windows Administrative Tools	
	ADSI Edit
Right-click ADSI Edit
Connect to...
Select a well known Naming Context:
	Configuration
		OK
	Configuration
	CN=Configuration
	CN=DisplaySpecifiers
	CN=409
	CN=organizationalUnit
		extraColumns
		Edit
		Value to add: operatingSystem,Operating System,0,200,0
		Add
		OK
		Apply
		OK

# View Operating System column
Active Directory Users and Computers
Maximize
	Expand AD.LAB
	Click Domain Controllers
	View
	Add/Remove Columns...
	Operating System
	Add ->	OK
	
	Expand LAB
	Click Member Servers
	View
	Add/Remove Columns...
	Operating System
	Add ->	OK	
