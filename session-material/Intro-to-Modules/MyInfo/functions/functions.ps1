
Function Get-HWInfo {
    #this is demo function that doesn't really do anything
    [cmdletbinding()]
    Param(
        [Parameter(Position = 0, Mandatory,HelpMessage = "Enter the name of a managed computer")]
        [ArgumentCompleter({$DomainComputers})]
        [string]$Computername,
        [Parameter(HelpMessage = "Enter an optional alternate credential.")]
        [PSCredential]$Credential
        )
    #call the helper function
    $data = _DoFoo

    [PSCustomObject]@{
        Name    = $computername.toUpper()
        Version = $data.version
        OS      = "Windows Unicorn"
        FreeGB  = $data.size
    }
}

Function Get-VolumeReport {
    [cmdletbinding(DefaultParameterSetName = "computer")]
    Param(
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = "session")]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Management.Infrastructure.CimSession[]]$CimSession,
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter a computername",
            ParameterSetName = "computer"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Computername = $env:computername,
        [Parameter(HelpMessage = "Enter a drive letter like C or D without the colon.")]
        [ValidatePattern("[c-zC-Z")]
        [string]$Drive = "C"
    )

    Begin {
        Write-Verbose "[BEGIN] Starting $($MyInvocation.MyCommand)"
    }
    Process {
        if ($PSCmdlet.ParameterSetName -eq "computer") {
            Write-Verbose "[PROCESS] Creating a temporary CimSession to $($Computername.toUpper())"
            Try {
            $CimSession = New-CimSession -ComputerName $computername -ErrorAction Stop
            #set a flag to indicate this session was created here
            #so PowerShell can clean up
            $TempSession = $True
            }
            Catch {
                Write-Warning "Failed to create a CimSession to $($Computername.toUpper()). $($_.exception.message)"
                #bail out
                return
            }
        }

        $params = @{
            ErrorAction = "Stop"
            DriveLetter = $Drive.toUpper()
            CimSession  = $CimSession
        }
        Write-Verbose "[PROCESS] Getting volume information for drive $Drive on $(($CimSession.computername).toUpper())"

        Get-Volume @params |
            Select-Object DriveLetter, Size, SizeRemaining, HealthStatus,
        @{Name = "Date"; Expression = {(Get-Date)}},
        @{Name = "Computername"; Expression = {$_.PSComputerName.toUpper()}}

        if ($TempSession) {
            Write-Verbose "[PROCESS] Removing temporary CimSession"
            Remove-CimSession -CimSession $CimSession
        }
    } #process
    End {
        Write-Verbose "[END] Ending $($MyInvocation.MyCommand)"

    }
} #close Get-VolumeReport

# private helper function that won't be exported
Function _DoFoo {
    [PSCustomObject]@{
        size    = [math]::Round((Get-Random -Minimum 1gb -Maximum 10gb) / 1GB, 2)
        Version = "v{0}.0.0" -f (Get-Random -Minimum 2 -Maximum 6)
    }
}
