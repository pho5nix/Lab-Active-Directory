# Create and Configure "Lab User Settings" GPO
# PowerShell for Group Policy Management

# ========================================
# CREATE THE GPO
# ========================================

New-GPO -Name "Lab User Settings" -Comment "Lab user customization settings"

# ========================================
# DESKTOP SETTINGS
# ========================================

# Set JPEG wallpaper quality to maximum
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Control Panel\Desktop" -ValueName "JPEGImportQuality" -Type DWORD -Value 100

# ========================================
# DESKTOP ICONS
# ========================================

# Show "This PC" icon on desktop
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -ValueName "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWORD -Value 0

# Show "User Folder" icon on desktop
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -ValueName "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Type DWORD -Value 0

# Show "Network" icon on desktop
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -ValueName "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Type DWORD -Value 0

# ========================================
# DARK THEME SETTINGS
# ========================================

# Enable dark theme for apps
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -ValueName "AppsUseLightTheme" -Type DWORD -Value 0

# Enable dark theme for system
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -ValueName "SystemUsesLightTheme" -Type DWORD -Value 0

# ========================================
# INTERNET EXPLORER
# ========================================

# Lock Internet Explorer toolbar
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Internet Explorer\Toolbar" -ValueName "Locked" -Type DWORD -Value 1

# ========================================
# COLOR SETTINGS
# ========================================

# Show accent color on window title bars
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\DWM" -ValueName "ColorPrevalence" -Type DWORD -Value 1

# Show accent color on Start menu and taskbar
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -ValueName "ColorPrevalence" -Type DWORD -Value 1

# ========================================
# FILE EXPLORER SETTINGS
# ========================================

# Open File Explorer to "This PC" instead of Quick Access
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "LaunchTo" -Type DWORD -Value 1

# Expand the ribbon in File Explorer
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" -ValueName "MinimizedStateTabletModeOff" -Type DWORD -Value 0

# Expand navigation pane to current folder
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "NavPaneExpandToCurrentFolder" -Type DWORD -Value 1

# Show all folders in navigation pane
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "NavPaneShowAllFolders" -Type DWORD -Value 1

# Show file extensions
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "HideFileExt" -Type DWORD -Value 0

# ========================================
# TASKBAR SETTINGS
# ========================================

# Show search icon only (not search box) on taskbar
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" -ValueName "SearchboxTaskbarMode" -Type DWORD -Value 1

# Hide Task View button from taskbar
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "ShowTaskViewButton" -Type DWORD -Value 0

# Hide Copilot button from taskbar
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "ShowCoPilotButton" -Type DWORD -Value 0

# Hide News and Interests from taskbar
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" -ValueName "ShellFeedsTaskbarViewMode" -Type DWORD -Value 2

# ========================================
# THUMBNAILS
# ========================================

# Enable thumbnails in File Explorer
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ValueName "DisableThumbnails" -Type DWORD -Value 0

# ========================================
# MACHINE POLICY (Computer Configuration)
# ========================================

# Disable News and Interests (Machine-level policy)
Set-GPRegistryValue -Name "Lab User Settings" -Key "HKLM\SOFTWARE\Policies\Microsoft\Dsh" -ValueName "AllowNewsAndInterests" -Type DWORD -Value 0

# ========================================
# LINK GPO TO DOMAIN
# ========================================

# Link the GPO to the domain root
New-GPLink -Name "Lab User Settings" -Target "DC=domain,DC=com"

# Or link to a specific OU
# New-GPLink -Name "Lab User Settings" -Target "OU=Users,DC=domain,DC=com"

# ========================================
# VERIFY AND REPORT
# ========================================

# Generate HTML report of the GPO
Get-GPOReport -Name "Lab User Settings" -ReportType HTML -Path "C:\Temp\LabUserSettings_GPO_Report.html"

# Get GPO information
Get-GPO -Name "Lab User Settings"

# View where GPO is linked
Get-GPLink -Name "Lab User Settings" -Target "DC=domain,DC=com"
