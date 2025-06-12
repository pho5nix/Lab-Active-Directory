$myDomainName = "domain.com"
$myNetBiosName = "domain"
$myExternalDNS = "1.1.1.1","208.67.222.222"

# Install AD DS and DNS services, Install management tools
Install-WindowsFeature AD-Domain-Services,DNS -IncludeManagementTools
Install-ADDSForest -DomainName $myDomainName -ForestMode Default -DomainMode Default -DomainNetbiosName $myNetBiosName -InstallDns

# Add DNS forwarders for Cloudflare and OpenDNS
Add-DnsServerForwarder -IPAddress $myExternalDNS
