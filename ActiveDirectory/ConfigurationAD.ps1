$myDomainName = "domain.com"
$myNetBiosName = "domain"
$myStaticIP = "172.23.150.50"
$myGateway = "172.23.150.254"
$myDNS = "("172.23.150.50","172.23.150.254")"

Install-WindowsFeature AD-Domain-Services,DNS -IncludeManagementTools
Install-ADDSForest -DomainName $myDomainName -ForestMode Default -DomainMode Default -DomainNetbiosName $myNetBiosName -InstallDns
