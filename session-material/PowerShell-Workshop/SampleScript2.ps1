#requires -version 5.1

#this is a sample script
<#
.Synopsis
Sample script
.Description
This is a sample script that doesn't do anything but write a random number
.Parameter Count
How many numbers do you want?
#>

Param ([int]$Count = 1)

Write-Host "This is a sample script that doesn't do anything but write a random number" -ForegroundColor Yellow

#get numbers
1..$count | ForEach-Object {
    Get-Random -Minimum 1 -Maximum 1000
}

Write-Host 'Ending script' -ForegroundColor yellow

#eof