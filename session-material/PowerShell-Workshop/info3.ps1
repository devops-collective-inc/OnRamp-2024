#requires -version 5.1

<#
an improved version that supports multiple computer names
and simplifies the Get-CimInstance queries
#>

Function Get-ServerInfo {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory, HelpMessage = "Enter the name of a Windows computer." )]
        [alias("server", "cn")]
        [ValidateNotNullOrEmpty()]
        [string[]]$Computername
    )

    Write-Verbose "[$(Get-Date)] Starting Get-ServerInfo"

    foreach ($computer in $computername) {

        Write-Verbose "[$(Get-Date)] Querying $Computer"
        #for the sake of the demo I am suppressing verbose output
        #from Get-CimInstance
        $cs = Get-CimInstance -ClassName win32_OperatingSystem -ComputerName $computer -Verbose:$false

        if ($cs) {
            Write-Verbose "[$(Get-Date)] Getting details"

            $cs | Select-Object -Property Caption, Version,
            @{Name = "Uptime"; Expression = { (Get-Date) - $_.LastBootUptime } },
            @{Name = "MemoryGB"; Expression = { $_.TotalVisibleMemorySize / 1MB -as [int32] } },
            @{Name = "PhysicalProcessors"; Expression = { (Get-CimInstance win32_ComputerSystem -ComputerName $_.CSName -Property NumberOfProcessors -Verbose:$false).NumberOfProcessors } },
            @{Name = "LogicalProcessors"; Expression = { (Get-CimInstance win32_ComputerSystem -ComputerName $_.CSName -Property NumberOfLogicalProcessors -Verbose:$false).NumberOfLogicalProcessors } },
            @{Name = "ComputerName"; Expression = { $_.CSName } }
        } #if

    } #foreach

    Write-Verbose "[$(Get-Date)] Ending Get-ServerInfo"

} #end Get-ServerInfo function

