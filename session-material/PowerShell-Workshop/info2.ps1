#requires -version 5.1

# get server information for the help desk

#use Verb-Noun naming convention
Function Get-Info {
  #you need cmdletbinding for -Verbose
  [cmdletbinding()]
  Param (
    [Parameter(Mandatory, HelpMessage = "Enter the name of a Windows computer." )]
    [alias("server", "cn")]
    #you can't guarantee you'll know where parameter values originate
    [ValidateNotNullOrEmpty()]
    #you may want to handle this kind of validation outside of the function
    [ValidateScript( { Test-Connection -ComputerName $_ -Count 1 -Quiet })]
    [string]$Computername
  )

  <#
  provide feedback to the user or for yourself when troubleshooting
  put verbose messaging in from the very beginning. It can double as
  documentation.
  #>
  Write-Verbose "[$(Get-Date)] Starting Get-Info"

  Write-Host "Getting server information for $Computername" -ForegroundColor Cyan
  Write-Verbose "[$(Get-Date)] Querying $computername"
  <#
    Get computer information with Get-CimInstance (WMI) and
    create a custom object. Note the use of full cmdlet and parameter names.
  #>

  Get-CimInstance -ClassName win32_OperatingSystem -ComputerName $computername |
  Select-Object -Property Caption, Version,
  @{Name = "Uptime"; Expression = { (Get-Date) - $_.LastBootUptime } },
  @{Name = "MemoryGB"; Expression = { $_.TotalVisibleMemorySize / 1MB -as [int32] } },
  @{Name = "PhysicalProcessors"; Expression = { (Get-CimInstance -ClassName win32_ComputerSystem -ComputerName $computername -Property NumberOfProcessors).NumberOfProcessors } },
  @{Name = "LogicalProcessors"; Expression = { (Get-CimInstance -ClassName win32_ComputerSystem -ComputerName $computername -Property NumberOfLogicalProcessors).NumberOfLogicalProcessors } },
  @{Name = "ComputerName"; Expression = { $_.CSName } }

  Write-Verbose "[$(Get-Date)] Ending Get-Info"

} #end Get-Info function