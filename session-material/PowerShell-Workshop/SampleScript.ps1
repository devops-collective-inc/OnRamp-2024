#requires -version 5.1
#requires -RunAsAdministrator
#requires -Modules SMBShare


<#
this is a multiline comment
#>

# this is a sample script

Write-Host "this is a sample script that doesn't do anything but write a random number" -ForegroundColor Yellow

#this is the output
$r = Get-Random -Minimum 1 -Maximum 1000

$r

#$global:r

new-psdrive foo  FileSystem C:\work
