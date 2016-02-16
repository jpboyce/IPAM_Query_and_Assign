# IPAM Query and Assignment Script
# This script will perform the following:
# 1. Create a remote powershell session to the IPAM server
# 2. Query the vRealize IP pool for the next available address
# 3. Create an assignment in IPAM for this address
#
# This allows the safe and automated allocation of IPs for the SQL-as-a-service cluster object

Write-Output "Initialising variables..."
$Server = "CHANGEME"
$Password = "CHANGEME"
$username = "CHANGEME"
$password = "CHANGEME"
$convertedpassword = $password | ConvertTo-SecureString -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username,$convertedpassword)
$devicename = "CHANGEME"
$forwardlookupzone = "CHANGEME"
$forwardlookupserver = "CHANGEME"
$owner = "CHANGEME"
$description = "CHANGEME"

Write-Output "Creating Powershell session to IPAM server..."
$session = New-PSSession -computername $Server -Credential $credential -usessl

Write-Output "Retrieving next free IP address..."
$freeIP = Invoke-Command -ComputerName $Server -ScriptBlock { Get-IpamRange -AddressFamily IPv4  | where {$_.owner -eq $args[0]} | Find-IpamFreeAddress | Select-Object -ExpandProperty IPAddress } -ArgumentList $owner

Write-Output "The next free IP is: " $freeip.IPAddressToString
Write-Output "Adding assignment of IP address..."
Invoke-Command -ComputerName $Server -ScriptBlock { Add-IpamAddress -IpAddress $args[0] -DeviceName $args[1]  -AssignmentType Static -Description $args[4] -Owner $args[5] -ForwardLookupZone $args[2] -ForwardLookupPrimaryServer $args[3] -PassThru -Verbose } -ArgumentList $freeIP,$devicename,$forwardlookupzone,$forwardlookupserver,$description,$owner

# END
