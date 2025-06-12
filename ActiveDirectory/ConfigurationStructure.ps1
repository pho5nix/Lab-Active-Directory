Import-Module ActiveDirectory

$givenName = "Arthur"
$surName = "Morgan"
$fullUserName = "arthurmorgan"
$passPhrase = "Password!@#1"
$topOU = "OU=Valentine,DC=domain,DC=com"
$tier0OU = "OU=Tier0-Control,OU=Valentine,DC=domain,DC=com"
$tier1OU = "OU=Tier1-Management,OU=Valentine,DC=domain,DC=com"
$tier2OU = "OU=Tier2-Users,OU=Valentine,DC=domain,DC=com"

# Create Top level container and Tiers
New-ADOrganizationalUnit -Name "Hierarchy-Top"
New-ADOrganizationalUnit -Name "Tier0-Control" -Path $topOU
New-ADOrganizationalUnit -Name "Tier1-Management" -Path $topOU
New-ADOrganizationalUnit -Name "Tier2-Users" -Path $topOU

# Create Tier0-Control Structure
New-ADOrganizationalUnit -Name "Domain-Controllers" -Path $tier0OU
New-ADOrganizationalUnit -Name "Tier0-Admin-Accounts" -Path $tier0OU
New-ADOrganizationalUnit -Name "Tier0-Infrastructure-Servers" -Path $tier0OU
New-ADOrganizationalUnit -Name "Tier0-Security-Groups" -Path $tier0OU
New-ADOrganizationalUnit -Name "Tier0-Service-Accounts" -Path $tier0OU

# Create Tier1-Management Structure
New-ADOrganizationalUnit -Name "Tier1-Admin-Accounts" -Path $tier1OU
New-ADOrganizationalUnit -Name "Tier1-Admin-Workstations" -Path $tier1OU
New-ADOrganizationalUnit -Name "Tier1-Security-Groups" -Path $tier1OU
New-ADOrganizationalUnit -Name "Tier1-Servers" -Path $tier1OU
New-ADOrganizationalUnit -Name "Tier1-Service-Accounts" -Path $tier1OU

# Create Tier2-Users Structure
New-ADOrganizationalUnit -Name "AD-Standard-Users" -Path $tier2OU
New-ADOrganizationalUnit -Name "Endpoints" -Path $tier2OU
New-ADOrganizationalUnit -Name "Tier2-Local-Admin-Accounts" -Path $tier2OU
New-ADOrganizationalUnit -Name "Tier2-Security-Groups" -Path $tier2OU

Set-ADComputer -Identity "CN=DC01,OU=Domain Controllers,OU=Tier0-Control,OU=Valentine,DC=domain,DC=com" -Description "Primary Domain Controller"

# Create Domain Admin
New-ADUser -Name $givenName" $surName - Tier0 Domain Admin" -AccountPassword(ConvertTo-SecureString -String $passPhrase -AsPlainText -Force) -DisplayName $givenName" $surName - Tier0 Domain Admin" -GivenName $givenName -Surname $surName" - Tier0 Doamin Admin" -Description "Domain Administrator" -Path "OU=Tier0-Admin-Accounts,OU=Tier0-Control,OU=Valentine,DC=domain,DC=com" -Enabled $true -SamAccountName "admin-"$fullUserName -UserPrincipalName "admin-"$fullUserName"@domain.com"
Set-ADUser -Identity "admin-"$fullUserName -PasswordNeverExpires $true

Add-ADGroupMember -Identity 'Domain Admins' -Members "admin-"$fullUserName
Add-ADGroupMember -Identity 'Enterprise Admins' -Members "admin-"$fullUserName

# Create a Standard account
New-ADUser -Name $givenName" "$surName -AccountPassword(ConvertTo-SecureString -String "password" -AsPlainText -Force) -DisplayName $givenName" "$surName -GivenName $givenName -Surname $surName -Description "General User Account" -Path "OU=AD-Standard-Userss,OU=Tier2-Users,OU=Hierarchy,DC=ADLAB,DC=HOME" -Enabled $true -SamAccountName $fullUserName -UserPrincipalName "$fullUserName@ADLAB.HOME"

# Create AD Group
# New-ADGroup -Name "SQL Admins" -SamAccountName "SQL Admins" -GroupCategory Security -GroupScope Global -DisplayName "SQL Admins" -Path "OU=Groups,OU=LAB,DC=AD,DC=LAB" -Description "Members of this group are SQL Administrators"
