return "This is a demo script file."

#region Objects

#everything is an object
1
"Hello"
Get-Process -id $PID
Get-Service w*

#properties and methods

#endregion

#region Using Get-Member

1 | Get-Member
"Hello" | gm
Get-Process -id $PID | gm -MemberType Methods
Get-Service w* | gm -MemberType Properties

#You try
# What type of object is pi? (3.1415)
# what type of object is $PSVersionTable?
# What method can you use for a string like 'hello' to make it all uppercase?

#endregion

#region Select-Object
#don't assume what you see is what you get
Get-Service BITS
Get-Service BITS | Get-Member -MemberType Properties
Get-Service BITS | Select-Object -Property *
Get-Service BITS | Select-Object -Property Status,Name,StartType,Description
Get-Service -ErrorAction SilentlyContinue | Select-Object -Property Status,Name,StartType,Description

Get-Process | Select-Object -first 10
Get-Process | Select-Object -first 10 -Property ID,Name,Path,StartTime

#endregion

#region object notation

$p = Get-Process -id $PID
$p.Name
$p.StartTime
$p.StartTime | Get-Member
$p.StartTime.DayOfWeek
#methods require ()
$p.StartTime.ToLongDateString()
$p.StartTime.ToString("yyyy-MM-dd-hh-mm")
$p.MainModule.FileVersionInfo.FileVersion

#endregion

#region objects in the pipeline
#cmdlets/functions emit and consume objects in the pipeline

#filtering
#early vs late filtering

Get-Service -Name w* | Where-Object {$_.status -eq "Running"}
Get-Service -Name w* | Where-Object {$_.status -eq "Running"} |
Select-Object -Property Name,DisplayName,BinaryPathName

#sorting
1,4,5,6,2,3,10 | Sort-Object
1,4,5,6,2,3,10 | Sort-Object -Descending
Get-Service m* | Sort-Object -Property Status,Name

#grouping
Get-Service | Group-Object -Property UserName
Get-Service | Group-Object -Property UserName| Get-Member
Get-Service | Group-Object -Property UserName | Sort Count -Descending

#object can change in the pipeline

dir c:\scripts\*.ps1 | Get-Member
dir c:\scripts\*.ps1 | Measure-Object -Property Length -Sum -Average -Maximum -Minimum #| Get-Member
dir c:\scripts\*.ps1 |
Measure-Object -Property Length -Sum -Average -Maximum -Minimum |
Select-Object -Property * -ExcludeProperty StandardDeviation,Property #| Get-Member

#this is using things we haven't covered yet
Get-Process | Where-Object {$_.Product} |
Group-Object Product | Where-Object {$_.count -gt 10} |
Sort-Object Count -Descending |
Select-Object -Property Count,Name,
@{Name="TotalWS";Expression={($_.Group | Measure-Object WorkingSet -Sum).Sum}}

#endregion

#region foreach-object

#use the pipeline where you can
Get-Service w* | Where-Object {$_.Status -eq 'running'} | Restart-Service -WhatIf

1..10 | ForEach-Object {$_ * 2}

"ALICE","BOB","CAROL" | ForEach-Object {$_.ToLower()}

#byvalue
help get-service -Parameter name
"bits" | get-service

#bypropertyname

$o = [PSCustomObject]@{
    Name = 'Bits'
    Size = 3
    Date= (Get-Date)
}
$o | Get-Service

#be careful
Get-Process -id $pid | Get-Service

help Get-WinEvent -parameter LogName

"system","application","Windows PowerShell" | Get-WinEvent -MaxEvents 5 |
Select TimeCreated,LogName,ProviderName,ID,LevelDisplayName | Format-Table

"system","application","Windows PowerShell" | Foreach-Object {
    Write-Host "Getting events from $_" -ForegroundColor green
    Get-WinEvent -LogName $_ -MaxEvents 5
} | Select-Object TimeCreated,LogName,ProviderName,ID,LevelDisplayName |
Out-GridView

#endregion

#region Exercises

<#
1. Get the top 10 processes sorted by working set in descending order,
showing only the name, id, working set, the process path, and when it started.

2. Show a sorted list of processes grouped by the company name in descending order
that have more than 10 processes.

3. Take the first 5 running services and display the service name in uppercase
#>

#endregion
