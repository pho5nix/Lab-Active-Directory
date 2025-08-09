$myStaticIP = "172.23.150.50"
$myGateway = "172.23.150.254"
$myDNS = ("172.23.150.50","172.23.150.254")
$myDCHostname = "DC01"

# Find the interface to set the IP address
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1
$interfaceIndex = $adapter.ifIndex

# Set IP address, Set primary and secondary DNS
New-NetIPAddress -InterfaceIndex $interfaceIndex -AddressFamily IPv4 -IPAddress $myStaticIP -PrefixLength 24 -DefaultGateway $myGateway
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses $myDNS

# Disable AllowNT4Crypto
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" -Name "AllowNT4Crypto" -Value 0

# Configure NTP server
w32tm /config /manualpeerlist:"time.windows.com" /syncfromflags:MANUAL
net stop w32time
net start w32time
w32tm /resync

# Set new hostname
Rename-Computer -NewName $myDCHostname -Restart -Force
