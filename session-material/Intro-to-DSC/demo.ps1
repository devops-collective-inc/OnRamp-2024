return "This is a demo script file."

#this should be run in Windows PowerShell NOT PowerShell 7.

#Configuration Management concepts
# Infrastructure from Code (IaC)

# Desired State Configuration (DSC)
# DSC v3 is in development - Implementation will differ from what I will show
# but concepts are the same

# DSC is a declarative model for configuration management
# Don't write a script to implement a configuration
# Describe what the configuration should look like

# DSC Resources

#run this in Windows PowerShell
Get-Module PSDesiredStateConfiguration -ListAvailable
Get-Module PSDesiredStateConfiguration -ListAvailable | Import-Module
Get-DscResource file -Syntax
Get-DscResource -Module ComputerManagementDS

powershell_ise .\MemberServer.ps1
powershell_ise .\deploy.ps1