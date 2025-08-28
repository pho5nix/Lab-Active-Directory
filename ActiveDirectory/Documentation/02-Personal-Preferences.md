# Active Directory Personal Preferences

## Create Reverse Lookup Zone

### Navigation Path
```
Windows Administrative Tools
└── DNS
    └── DC01 (double-click)
        └── Reverse Lookup Zones (double-click)
```

### Configuration Steps

1. **Right-click** `Reverse Lookup Zones`
2. Select **New Zone...**
3. Click **Next**

#### Zone Configuration
| Step | Setting | Value |
|------|---------|-------|
| 1 | Zone Type | **Primary zone** |
| 2 | Replication Scope | **To all DNS servers running on domain controllers in this forest: ADLAB.HOME** |
| 3 | Zone Type | **IPv4 Reverse Lookup Zone** → Next |
| 4 | Network ID | **172.23.150** → Next |
| 5 | Dynamic Updates | **Allow only secure dynamic updates** → Next |
| 6 | Complete | **Finish** |


<summary>💡 Quick Command Alternative</summary>

```powershell
Add-DnsServerPrimaryZone -NetworkID "172.23.150.0/24" -ReplicationScope "Forest" -DynamicUpdate "Secure"
```

---

## Add Preferred Columns to ADSI

### Navigation Path
```
Windows Administrative Tools
└── ADSI Edit
```

### Configuration Steps

1. **Right-click** `ADSI Edit`
2. Select **Connect to...**

#### Connection Settings
<pre>
Select a well known Naming Context:
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
|1️. **Find** | Property: `extraColumns` |
|2. **Edit** | Click Edit button |
|3. **Add Value** | `operatingSystem,Operating System,0,200,0` |
|4. **Confirm** | Add → OK → Apply → OK |

> **Note:** The format is: `attributeName,Display Name,unused,width,unused`

---

##  View Operating System Column

### Location
```
Active Directory Users and Computers (Maximize window)
```

### Add Column to Domain Controllers

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

### Add Column to Member Servers

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



## Additional Notes

> **Important:** Always ensure you have proper administrative privileges before making these changes.

> **Tip:** The Operating System column helps quickly identify server versions across your infrastructure.

> **Security:** "Allow only secure dynamic updates" ensures DNS records are protected by Active Directory authentication.

---
