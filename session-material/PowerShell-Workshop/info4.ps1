#requires -version 5.1

<#
Support pipeline input
Error handling with Try/Catch
Custom object
#>
Function Get-ServerInfo {
    [cmdletbinding()]
    Param (
        [Parameter(
            Position = 0,
            HelpMessage = 'Enter the name of a Windows computer.',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('server', 'cn')]
        [ValidateNotNullOrEmpty()]
        [string[]]$Computername = $env:computername
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
    } #begin
    Process {

        #loop through each computername that is part of $Computername
        foreach ($computer in $computername) {

            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing $computer"

            Try {
                #get Operating system information from WMI on each computer
                $os = Get-CimInstance -ClassName win32_OperatingSystem -ComputerName $computer -ErrorAction stop

                #moved this to the Try block so if there
                #is an error querying win32_ComputerSystem, the same
                #catch block will be used
                if ($os) {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting ComputerSystem info"

                    #get computer system information from WMI on each computer
                    $cs = Get-CimInstance win32_ComputerSystem -ComputerName $os.CSName -Property NumberOfProcessors, NumberOfLogicalProcessors -ErrorAction Stop

                    #create an ordered hashtable that will be turned into an object
                    $properties = [ordered]@{
                        OperatingSystem    = $os.caption
                        Version            = $os.version
                        Uptime             = (Get-Date) - $os.LastBootUptime
                        MemoryGB           = $os.TotalVisibleMemorySize / 1MB -as [int32]
                        PhysicalProcessors = $cs.NumberOfProcessors
                        LogicalProcessors  = $cs.NumberOfLogicalProcessors
                        ComputerName       = $os.CSName
                    }

                    #create a custom object using the hashtable as properties and values
                    New-Object -TypeName PSObject -Property $properties

                } #if $OS has a value

            } #try

            Catch {
                Write-Warning "Failed to contact $($computer.ToUpper()). $($_.Exception.Message)."
            } #catch

        } #foreach
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Exiting $($MyInvocation.MyCommand)"
    } #end

} #end Get-ServerInfo

