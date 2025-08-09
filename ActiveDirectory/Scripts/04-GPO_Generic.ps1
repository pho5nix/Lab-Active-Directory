# Lab User Settings - Registry PowerShell Snippets
# Each snippet can be run independently

# ========================================
# DESKTOP SETTINGS
# ========================================

# Set JPEG wallpaper quality to maximum (100)
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -Value 100 -PropertyType DWORD -Force

# ========================================
# SHOW DESKTOP ICONS
# ========================================

# Show "This PC" icon on desktop
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -PropertyType DWORD -Force

# Show "User Folder" icon on desktop  
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 0 -PropertyType DWORD -Force

# Show "Network" icon on desktop
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 0 -PropertyType DWORD -Force

# ========================================
# DARK THEME
# ========================================

# Enable dark theme for apps
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -PropertyType DWORD -Force

# Enable dark theme for system
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -PropertyType DWORD -Force

# ========================================
# INTERNET EXPLORER
# ========================================

# Lock Internet Explorer toolbar
New-ItemProperty -Path "HKCU:\Software\Microsoft\Internet Explorer\Toolbar" -Name "Locked" -Value 1 -PropertyType DWORD -Force

# ========================================
# COLOR SETTINGS
# ========================================

# Show accent color on window title bars
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "ColorPrevalence" -Value 1 -PropertyType DWORD -Force

# Show accent color on Start menu and taskbar
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "ColorPrevalence" -Value 1 -PropertyType DWORD -Force

# ========================================
# FILE EXPLORER SETTINGS
# ========================================

# Open File Explorer to "This PC" instead of Quick Access
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -PropertyType DWORD -Force

# Expand the ribbon in File Explorer
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" -Name "MinimizedStateTabletModeOff" -Value 0 -PropertyType DWORD -Force

# Expand navigation pane to current folder
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -Value 1 -PropertyType DWORD -Force

# Show all folders in navigation pane
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneShowAllFolders" -Value 1 -PropertyType DWORD -Force

# Show file extensions
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -PropertyType DWORD -Force

# ========================================
# TASKBAR SETTINGS
# ========================================

# Show search icon only (not search box) on taskbar
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 1 -PropertyType DWORD -Force

# Hide Task View button from taskbar
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0 -PropertyType DWORD -Force

# Hide Copilot button from taskbar
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCoPilotButton" -Value 0 -PropertyType DWORD -Force

# Hide News and Interests from taskbar
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2 -PropertyType DWORD -Force

# ========================================
# THUMBNAILS
# ========================================

# Enable thumbnails in File Explorer
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisableThumbnails" -Value 0 -PropertyType DWORD -Force

# ========================================
# MACHINE POLICY (Requires Admin Rights)
# ========================================

# Disable News and Interests (Machine-level policy)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Value 0 -PropertyType DWORD -Force

# ========================================
# APPLY ALL SETTINGS AT ONCE
# ========================================

# One-liner to apply all user settings (combine with semicolons)
New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -Value 100 -PropertyType DWORD -Force; New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -PropertyType DWORD -Force; New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Value 0 -PropertyType DWORD -Force; New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Value 0 -PropertyType DWORD -Force

# ========================================
# RESTART EXPLORER TO APPLY CHANGES
# ========================================

# Restart Windows Explorer to apply visual changes immediately
Stop-Process -Name explorer -Force; Start-Process explorer

# ========================================
# CREATE GPO WITH THESE SETTINGS
# ========================================

# Create a new GPO named "Lab User Settings"
New-GPO -Name "Lab User Settings" -Comment "User customization settings for lab environment"

# Link the GPO to the domain
New-GPLink -Name "Lab User Settings" -Target "DC=domain,DC=com"

# Add a single registry preference to the GPO (example)
Set-GPPrefRegistryValue -Name "Lab User Settings" -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "HideFileExt" -Type DWORD -Value 0
