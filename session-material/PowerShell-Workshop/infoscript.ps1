#this is the PowerShell code that works interactively in the console

#Start using full cmdlet names and parameters. Start thinking about parameters
Param($Computername)

Get-CimInstance -ClassName win32_OperatingSystem -ComputerName $computername |
Select-Object -Property Caption, Version,
@{Name = "Uptime"; Expression = { (Get-Date) - $_.LastBootUptime } },
@{Name = "MemoryGB"; Expression = { $_.TotalVisibleMemorySize / 1MB -as [int32] } },
@{Name = "PhysicalProcessors"; Expression = { (Get-CimInstance -ClassName win32_ComputerSystem -ComputerName $computername -Property NumberOfProcessors).NumberOfProcessors } },
@{Name = "LogicalProcessors"; Expression = { (Get-CimInstance -ClassName win32_ComputerSystem -ComputerName $computername -Property NumberOfLogicalProcessors).NumberOfLogicalProcessors } },
@{Name = "ComputerName"; Expression = { $_.CSName } }

#this code doesn't have to perfect but it should be functional