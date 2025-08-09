# ========================================
# COMPLETE SCRIPT - RUN ALL AT ONCE
# ========================================

# Create GPO and apply all settings
$GPOName = "Lab User Settings"

# Create GPO
New-GPO -Name $GPOName -Comment "Lab user customization settings"

# Apply all user preferences
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Control Panel\Desktop" -ValueName "JPEGImportQuality" -Type DWORD -Value 100
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -ValueName "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWORD -Value 0
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -ValueName "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Type DWORD -Value 0
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -ValueName "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Type DWORD -Value 0
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -ValueName "AppsUseLightTheme" -Type DWORD -Value 0
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -ValueName "SystemUsesLightTheme" -Type DWORD -Value 0
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Internet Explorer\Toolbar" -ValueName "Locked" -Type DWORD -Value 1
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\DWM" -ValueName "ColorPrevalence" -Type DWORD -Value 1
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -ValueName "ColorPrevalence" -Type DWORD -Value 1
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "LaunchTo" -Type DWORD -Value 1
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" -ValueName "MinimizedStateTabletModeOff" -Type DWORD -Value 0
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "NavPaneExpandToCurrentFolder" -Type DWORD -Value 1
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "NavPaneShowAllFolders" -Type DWORD -Value 1
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "HideFileExt" -Type DWORD -Value 0
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" -ValueName "SearchboxTaskbarMode" -Type DWORD -Value 1
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "ShowTaskViewButton" -Type DWORD -Value 0
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -ValueName "ShowCoPilotButton" -Type DWORD -Value 0
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" -ValueName "ShellFeedsTaskbarViewMode" -Type DWORD -Value 2
Set-GPPrefRegistryValue -Name $GPOName -Context User -Action Update -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ValueName "DisableThumbnails" -Type DWORD -Value 0

# Apply machine policy
Set-GPRegistryValue -Name $GPOName -Key "HKLM\SOFTWARE\Policies\Microsoft\Dsh" -ValueName "AllowNewsAndInterests" -Type DWORD -Value 0

# Link to domain
New-GPLink -Name $GPOName -Target "DC=domain,DC=com"

Write-Host "GPO 'Lab User Settings' created and linked successfully!" -ForegroundColor Green
