# IPAM_Query_and_Assign
Summary
Performs a remote query on an IPAM server for available IPs in a specified pool and assigns one.

Detail
This script will perform the following actions:

1. Create a new Powershell session to a defined Microsoft Windows 2012 IPAM host (via New-PSSession)
2. Query IPv4 address ranges belonging to a specified "owner" for the next available address
3. Create an assignment for this address

Dependencies
1. The IPAM account needs to be a member of the "IPAM ASM Administrators" group on the IPAM server.
2. The IPAM account needs to be a member of the "WinRMRemoteWMIUsers__" group on the IPAM server.
3. Powershell remoting needs to be configured appropriately on the IPAM server

Variables
$Server - IPAM server hostname or IP
$Password - IPAM account password
$username - IPAM accout name
$convertedpassword - Secure string conversion of the $password variable
$credential - Powershell credential object for the remote session
$devicename - Identifier of the device for the IP assignment (ie. hostname)
$forwardlookupzone - Forward Lookup DNS zone
$forwardlookupserver - Forward Lookup DNS server
