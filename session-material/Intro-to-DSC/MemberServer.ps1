#requires -version 5.1
Configuration MemberServer {
    Param(
    [Parameter(Position=0,Mandatory)]
    [string[]]$ComputerName
    )

    #built-in
    Import-DSCResource -ModuleName 'PSDesiredStateConfiguration' -ModuleVersion '1.1'
    #installed
    Import-DSCResource -ModuleName 'ComputerManagementDSC' -ModuleVersion  '9.0.0'


    Node $ComputerName {

        File CorpData {
            DestinationPath = 'C:\CorpData'
            Ensure          = 'Present'
            Type            = 'Directory'
        }

        WindowsFeature PSv2 {
            Name   = 'PowerShell-V2'
            Ensure = 'Absent'
        }

        WindowsFeature Backup {
            Name                 = 'Windows-Server-Backup'
            Ensure               = 'Present'
            IncludeAllSubFeature = $true
        }

        Service TermSvc {
            Name        = 'TermService'
            StartupType = 'Manual'
            State       = 'Stopped'
        }

        #this requires the ComputerManagementDSC module to be installed on the remote computer
        WindowsCapability SSH {
            Name   = 'OpenSSH.Server~~~~0.0.1.0'
            Ensure = 'Present'
        }

    } #Node

}