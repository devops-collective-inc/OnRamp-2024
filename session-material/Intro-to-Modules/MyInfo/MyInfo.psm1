
#you could put your functions here

#I'm going to dot source the files

Get-ChildItem $PSScriptRoot\functions\*.ps1 |
Foreach-Object { . $_.FullName}

#Variables need to be exported here. Long time manifest bug.
Export-ModuleMember -Variable DomainComputers,HelpDesk