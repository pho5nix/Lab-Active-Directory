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
