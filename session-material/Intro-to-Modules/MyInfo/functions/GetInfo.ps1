
# comment based help has been removed after generating external help
Function Get-ServerInfo {

    [cmdletbinding()]
    [outputType("PSServerinfo")]
    [alias("gsvi")]
    Param (
        [Parameter(
            Position = 0,
            HelpMessage = "Enter the name of a Windows computer.",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
            )]
        [Alias("server", "cn")]
        [ValidateNotNullOrEmpty()]
        [string[]]$Computername = $env:computername,

        [ValidateRange(1, 10)]
        [int32]$Timeout
    )

    Begin {
        Write-Verbose "[BEGIN] Starting $($MyInvocation.MyCommand)"

        #define a hashtable of parameter values to splat to Get-CimInstance
        $cimParams = @{
            ClassName    = "win32_OperatingSystem"
            ErrorAction  = "Stop"
            Computername = ""
        }

        if ($timeout) {
            Write-Verbose "[BEGIN] Adding timeout value of $timeout"
            $cimParams.add("OperationTimeOutSec", $Timeout)
        }
    } #begin

    Process {

        foreach ($computer in $computername) {

            Write-Verbose "[PROCESS] Processing computer: $($computer.toUpper())"

            $cimParams.computername = $computer

            Try {
                $os = Get-CimInstance @cimParams

                #moved this to the Try block so if there
                #is an error querying the Win32_ComputerSystem class, the same
                #catch block will be used
                if ($os) {
                    Write-Verbose "[PROCESS] Getting ComputerSystem info"

                    $csParams = @{
                        ClassName    = "win32_ComputerSystem"
                        computername = $os.CSName
                        Property     = 'NumberOfProcessors', 'NumberOfLogicalProcessors'
                        ErrorAction  = 'Stop'
                    }

                    if ($timeout) {
                        $csParams.add("OperationTimeOutSec", $Timeout)
                    }

                    $cs = Get-CimInstance @csParams

                    Write-Verbose "[PROCESS] Creating output object"
                    [PSCustomObject]@{
                        PSTypename         = "PSServerInfo"
                        OperatingSystem    = $os.caption
                        Version            = $os.version
                        Uptime             = (Get-Date) - $os.LastBootUpTime
                        MemoryGB           = $os.TotalVisibleMemorySize / 1MB -as [int32]
                        PhysicalProcessors = $cs.NumberOfProcessors
                        LogicalProcessors  = $cs.NumberOfLogicalProcessors
                        ComputerName       = $os.CSName
                    }

                } #if
            }
            Catch {
                #variation on warning message
                $msg = "Failed to contact $($computer.ToUpper()). $($_.exception.message)"

                Write-Warning $msg

            }

        } #foreach
    } #process
    End {
        Write-Verbose "[END] Exiting $($MyInvocation.MyCommand)"
    }

} #end Get-ServerInfo

