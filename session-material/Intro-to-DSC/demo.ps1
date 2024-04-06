return "This is a demo script file."

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

ise .\MemberServer.ps1
ise .\deploy.ps1