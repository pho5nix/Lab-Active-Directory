# Windows Server 2022 VM Template Creation Guide

## System Specifications

**Operating System:** Windows Server 2022 - Standard Eval Desktop Experience
- **Processors:** 1
- **Cores:** 2
- **RAM:** 2GB
- **Storage:** 60GB NVMe

## Initial Configuration

### Basic Setup
1. **Time Zone Configuration**
   - Run `timedate.cpl` to adjust time zone settings

2. **VMware Tools Installation**
   - Install VMware Tools for optimal performance

### Service Configuration

Open **Windows PowerShell (Admin)** and execute the following commands:

```powershell
# Set configuration for DPS service
sc.exe config DPS start=auto
sc.exe failure DPS reset=0 actions=restart/0/restart/0/restart/0

# Set configuration for UsoSvc service
sc.exe config UsoSvc start=auto
sc.exe failure UsoSvc reset=0 actions=restart/0/restart/0/restart/0

# Set configuration for UALSVC service
sc.exe config UALSVC start=auto
sc.exe failure UALSVC reset=0 actions=restart/0/restart/0/restart/0

# Set configuration for MSDTC service
sc.exe config MSDTC start=auto
sc.exe failure MSDTC reset=0 actions=restart/0/restart/0/restart/0

# Set configuration for BITS service
sc.exe config BITS start=auto
sc.exe failure BITS reset=0 actions=restart/0/restart/0/restart/0
```

### Network Configuration

```powershell
# Set rules for ICMP (Allow Ping)
New-NetFirewallRule -DisplayName "Inbound ICMPv4" -Direction Inbound -Protocol ICMPv4 -Action Allow -Profile Any -Enabled True
New-NetFirewallRule -DisplayName "Outbound ICMPv4" -Direction Outbound -Protocol ICMPv4 -Action Allow -Profile Any -Enabled True
```

### System Optimization

```powershell
# Set Service Pipe Timeout to 90 seconds (1.5 minutes)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "ServicesPipeTimeout" -Value 0x15f90 -Type DWord

# Disable Shipped With Reserved Storage
DISM /Online /Set-ReservedStorageState /State:Disabled
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v "ShippedWithReserves" /t REG_DWORD /d 0 /f

# Disable UAC prompt for Administrators
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
```

### Windows Features Installation

```powershell
# Install the .NET Framework 3.5 Core
Install-WindowsFeature -Name NET-Framework-Core -Source D:\Sources\SxS

# Install BitLocker and BitLocker Management Tools
Install-WindowsFeature BitLocker -IncludeAllSubFeature -IncludeManagementTools -Restart
```

## Recovery Partition Resize

**Reference:** [KB5028997 - Instructions to manually resize your partition to install the WinRE update](https://support.microsoft.com/en-us/topic/kb5028997-instructions-to-manually-resize-your-partition-to-install-the-winre-update-400faa27-9343-461c-ada9-24c8229763bf)

Open **Command Prompt (Admin)** and execute:

```cmd
:: Disable Windows Recovery Environment (WinRE)
reagentc /disable

:: Start Diskpart
diskpart
sel disk 0
sel part 3
shrink desired=250 minimum=250
sel part 4
del part override
create part primary id=de94bba4-06d1-4d40-a16a-bfd50179d6ac
gpt attributes=0x8000000000000001
format quick fs=ntfs label="Windows RE tools"
exit

:: Enable Windows Recovery Environment (WinRE)
reagentc /enable

:: Restart the system
shutdown /r /t 1
```

## ADMX Templates Update

1. Download the latest ADMX Templates
2. Save them to `C:\Temp\Group_Policy\ADMX_Templates`

Open **PowerShell 7 (Admin)** and run:

```powershell
$sourceDir = "C:\Temp\Group_Policy\ADMX_Templates"
$destinationDir = "C:\Windows\PolicyDefinitions"

# Get all .admx files in the source directory
$admxFiles = Get-ChildItem -Path $sourceDir -Filter *.admx -Recurse

# Loop through each .admx file
foreach ($admxFile in $admxFiles) {
    # Construct the destination path for the .admx file
    $destinationFile = Join-Path -Path $destinationDir -ChildPath $admxFile.Name
	
    # Copy the .admx file to the destination
    Copy-Item -Path $admxFile.FullName -Destination $destinationFile -Force -Verbose
	
    # Get the corresponding .adml folder
    $admlFolder = Join-Path -Path $admxFile.Directory.FullName -ChildPath "en-US"
	
    # If the .adml folder exists, copy .adml files to the destination en-US folder
    if (Test-Path $admlFolder) {
        $admlFiles = Get-ChildItem -Path $admlFolder -Filter *.adml
        foreach ($admlFile in $admlFiles) {
            $destinationAdmlFile = Join-Path -Path $destinationDir -ChildPath ("en-US\" + $admlFile.Name)
            Copy-Item -Path $admlFile.FullName -Destination $destinationAdmlFile -Force -Verbose
        }
    }
}
```

## Personal Preferences Configuration

1. **Disable Server Manager auto logon**
2. **Rename C:\ drive** to "Windows"
3. **Set system power options** to never sleep
4. **Install PowerShell 7**
5. **Install Notepad++**
6. **Install Visual C++ 2015-2022** (both x86 & x64)

7. **Install Edge for Business**
   ```powershell
   Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"C:\MicrosoftEdgeEnterpriseX64.msi`" /qn /quiet /norestart DONOTCREATEDESKTOPSHORTCUT=true" -Wait
   ```

8. **Convert Eval to Standard** (Requires 2 restarts)
   ```cmd
   DISM /online /Set-Edition:ServerStandard /ProductKey:VDYBN-27WPP-V4HQT-9VMD4-VMK7H /AcceptEula /NoRestart
   ```

9. **Check for and Install Windows Updates**

10. **Disable AzureArcSysTray** from startup applications

11. **Remove Edge Standard (Stable)**
    > ⚠️ **Warning:** Remove because it can cause problems with sysprep

    Open **Windows PowerShell (Admin)** and execute:
    ```powershell
    net stop wuauserv
    Remove-Item C:\Windows\SoftwareDistribution\* -Recurse -Force
    net start wuauserv
    Get-AppxPackage -Name Microsoft.MicrosoftEdge.Stable | Remove-AppxPackage
    Stop-Computer
    ```

## Final Steps

### Template Creation
1. **Create a Full Clone** - Template
2. **Proceed with cloning** the current machine for lab machines
3. **After finalizing lab machine VM configurations** - power on and sysprep all machines

---

## Notes

- Use Windows PowerShell (Admin) for cross-compatibility where specified
- Ensure all steps are completed before creating the template
- Test the template with a single clone before mass deployment
- Keep the original template powered off to preserve its state
