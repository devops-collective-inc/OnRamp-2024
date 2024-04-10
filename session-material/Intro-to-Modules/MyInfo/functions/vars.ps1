#variables to export to user in this module

#this could also go in the psm1 file
$HelpDesk = "Please contact the HelpDesk at x1234"

#import the list of computers, filtering out blanks and trimming spaces.
$DomainComputers = (Get-Content $PSScriptRoot\computers.txt).where({$_ -match "\w+"}).foreach({$_.trim()})
#add the local host
$DomainComputers.Add($env:COMPUTERNAME)

#this variable will be used internally

$secret = "abracadabra"