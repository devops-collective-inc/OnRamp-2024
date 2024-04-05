return "This is a demo script file. Open in VSCode or the PowerShell ISE."

#region demo prep
  # open in the Demos folder
  # use Light (Visual Studio) color theme
<#
$host.PrivateData.VerboseForegroundColor = "Cyan"
Set-PSReadLineOption -Colors @{
    Command="$([char]0x1b)[38;5;200m"
    KeyWord="$([char]0x1b)[38;5;92m"
}
New-PSDrive -Name Demo -PSProvider FileSystem -Root .
cd Demo:
cls
#>
  # fold all regions
#endregion

#region Before you begin

# Use a PowerShell scripting editor
# Agree on scripting conventions and style
# Use source control
# Don't ignore the iterative process

#endregion

#region Start with a command

Get-CimInstance -ClassName win32_OperatingSystem |
Select-Object Caption,Version,LastBootUptime,TotalVirtualMemorySize,CSName

Get-CimInstance -ClassName Win32_ComputerSystem |
Select-Object NumberOfProcessors,NumberOfLogicalProcessors

#endregion

#region Create a script

#start thinking about scaling, re-use, and object output
psedit .\infoscript.ps1
.\info1.ps1 localhost

#endregion

#region Turn into a function
psedit .\info2.ps1
#dot source
. .\info2.ps1
Get-Info localhost -Verbose

#endregion

#region Create an advanced function
psedit .\info3.ps1
. .\info3.ps1

$r = Get-ServerInfo localhost,".",$env:computername -verbose
$r
#endregion

#region Leverage the pipeline
psedit .\info4.ps1
. .\info4.ps1
help Get-ServerInfo -full

#computer names via parameters
$r = Get-ServerInfo localhost,foo,$env:computername -Verbose
#computer names via the pipeline
"localhost","." | Get-ServerInfo

[PSCustomObject]@{Computername = "localhost"} | Get-ServerInfo

#endregion

#region Extend the command
psedit .\info5.ps1
. .\info5.ps1

help gsvi -full
$r = "localhost","foo",$env:computername | Get-ServerInfo -verbose -Timeout 3

<#
additional work:
 support alternate credentials
 support CIMSessions
#>
#endregion

#region Formatting output
psedit .\info6.ps1
. .\info6.ps1
$r = Get-ServerInfo
$r | Get-Member

$r |
Format-Table -GroupBy Computername -Property OperatingSystem,Version,
MemoryGB,LogicalProcessors,Uptime

<# Install-Module PSScriptTools

$splat = @{
    Path = ".\psserverinfo.format.ps1xml"
    GroupBy = "Computername"
    FormatType = "Table"
    ViewName = "default"
    Properties = "OperatingSystem","Version","MemoryGB","LogicalProcessors","Uptime"
}
$r | New-PSFormatXML @splat
#>

psedit .\psserverinfo.format.ps1xml

Update-FormatData .\psserverinfo.format.ps1xml
$r
$r | Select-Object *

#extend the type
Update-TypeData -TypeName PSServerinfo -MemberType NoteProperty -MemberName AuditDate -Value (Get-Date) -force
$r | Select-Object *

gsvi localhost,localhost,$env:computername | Tee-Object -variable r
$r | Format-List

#you could add the Update commands to the end of the function script file

#endregion



