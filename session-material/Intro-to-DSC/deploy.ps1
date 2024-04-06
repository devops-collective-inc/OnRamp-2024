#requires -version 5.1

return "This is a demo script file"

#checkpoint for my demo
Get-VM Srv1 | Checkpoint-VM -SnapshotName DSCDemo

dir \\srv1\c$
invoke-command { Get-WindowsFeature *backup*,"*V2*" } -ComputerName SRV1 | Select Name,Installed

#load the configuration
. .\MemberServer.ps1
Get-Command MemberServer
Help MemberServer
MemberServer srv1 -OutputPath .
psedit .\MemberServer\srv1.mof
Start-DscConfiguration -Wait -Path .\MemberServer -Verbose

Get-DscConfiguration -CimSession SRV1
Test-Path '\\srv1\c$\CorpData'
invoke-command { Get-WindowsFeature *backup*,"*V2*" } -ComputerName SRV1 | Select Name,Installed
Test-DscConfiguration -ComputerName srv1
Test-DscConfiguration -ComputerName srv1 -Detailed

#need to make a change? Update the configuration and push the new version