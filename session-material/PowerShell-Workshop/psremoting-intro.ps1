return "This is a demo script file."

#region legacy remoting

help Get-WinEvent -param computername
Get-WinEvent -LogName System -ComputerName srv1 -MaxEvents 5

#endregion
#region PSRemoting fundamentals

#remoting architecture
#remoting should be enabled by default
# Enable-PSRemoting
#WSman vs SSH (ssh is out of scope)
Test-WSMan
Test-WSMan -ComputerName srv1
Test-WSMan foo
Get-Service WinRM
#Credentials

$cred = Get-Credential company\artd
$cred
$cred | Get-Member
$cred.GetNetworkCredential() | select *
#object notation
$cred.GetNetworkCredential().Password

#endregion
#region Interactive remoting

Enter-PSSession -ComputerName srv1 -Credential $cred
whoami
Get-Host
Hostname
$PSVersionTable
Get-PSSessionConfiguration
$proc = Get-Process
$proc | sort ws -Descending | select -First 5
#no profile scripts
$profile
exit

<#
You try:
    verify remoting is enabled on your computer
    enter a PSSession to yourself
    Try some commands
    exit
#>

#endregion
#region Using PSSessions
Enter-PSSession -ComputerName srv1 -Credential $cred
$proc
Exit
New-PSSession -ComputerName srv1 -Credential $cred -Name s1
Get-PSSession

Enter-PSSession -Name s1
$proc
$proc = Get-Process
Exit
Enter-PSSession -Name s1
$proc
Get-Process wsmprovhost -IncludeUserName | select ID, Username, WS, CPU, StartTime

#endregion
#region 2nd hop problem (WSMan)

Get-WinEvent -LogName System -ComputerName srv2 -MaxEvents 5
Get-WinEvent -LogName System -ComputerName srv2 -MaxEvents 5 -Credential company\artd
#or setup and use CredSSP or kerberos delegation
Exit
Remove-PSSession -Name S1
#endregion
#region One to Many remoting

Invoke-Command { Get-Service Bits } -ComputerName srv1, srv2, Dom1 -Credential $cred

$all = New-PSSession -ComputerName srv1, srv2, Dom1 -Credential $cred
$all
Invoke-Command { Get-Service Bits } -Session $all
Invoke-Command { Get-WinEvent -FilterHashtable @{LogName = 'System'; Level = 2 } -MaxEvents 5 } -Session $all

#this one-line command could be broken down into multiple steps
#think about where each part of the pipeline is being processed
Invoke-Command { Get-WinEvent -FilterHashtable @{LogName = 'System'; Level = 2 } -MaxEvents 1000 } -Session $all |
Group-Object PSComputerName | ForEach-Object {
    $CN = $_.Name
    $_.Group |
    Group-Object -Property ProviderName -NoElement |
    Select-Object -Property @{Name = 'ComputerName'; Expression = { $CN } }, Name, Count
}

#Advanced: Using disconnected sessions

Get-PSSession | Remove-PSSession

#endregion
#region CIM Cmdlets

#a brief history of WMI/CIM
wbemtest

Get-CimInstance -ClassName win32_process  #| Get-Member
$c = Get-CimClass win32_process
$c
$c.CimClassProperties | select Name, CimType

Get-CimInstance -ClassName win32_process -Filter 'ThreadCount>=25' |
sort ThreadCount -Descending |
Select-Object -Property ProcessID, Name, ThreadCount, WorkingSetSize

Get-CimInstance -ClassName win32_service -ComputerName DOM1

#you need a session if you want alternate credentials
$cs = New-CimSession -ComputerName srv1,srv2,dom1 -Credential $cred
$cs
$cs | Get-CimInstance -ClassName win32_service -Filter "Name='RemoteRegistry'"
#don't do this
$cs | Get-CimInstance -ClassName win32_service | Where-Object { $_.Name -eq 'RemoteRegistry' }
#compare performance
Get-History

$cs | Get-CimInstance -ClassName win32_service -Filter "Name='WinRM'"|
Select-Object -Property PSComputername,ProcessID,Name,
@{Name="WS";Expression={
    #$_ can change in the pipeline
    $id = $_.ProcessID
    $cn = $_.PSComputerName
    #get the associated Win32_process
    $proc = $cs | Where-Object {$_.ComputerName -eq $cn} |
    Get-CimInstance -ClassName win32_process -Filter "ProcessID=$($ID)"
    #this is the expression result or value
    $proc.WorkingSetSize
}}

Get-CimSession | Remove-CimSession

#endregion
