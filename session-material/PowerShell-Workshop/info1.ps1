#requires -version 5.1

# get server information for the help desk

Param ([string]$Computername = $env:ComputerName)

Write-Host "Getting server information for $Computername" -ForegroundColor Cyan

Get-CimInstance -ClassName win32_OperatingSystem -ComputerName $computername |
Select-Object -Property Caption, Version,
@{Name = "Uptime"; Expression = { (Get-Date) - $_.LastBootUptime } },
@{Name = "MemoryGB"; Expression = { $_.TotalVisibleMemorySize / 1MB -as [int32] } },
@{Name = "PhysicalProcessors"; Expression = { (Get-CimInstance -ClassName win32_ComputerSystem -ComputerName $computername -Property NumberOfProcessors).NumberOfProcessors } },
@{Name = "LogicalProcessors"; Expression = { (Get-CimInstance -ClassName win32_ComputerSystem -ComputerName $computername -Property NumberOfLogicalProcessors).NumberOfLogicalProcessors } },
@{Name = "ComputerName"; Expression = { $_.CSName } }
