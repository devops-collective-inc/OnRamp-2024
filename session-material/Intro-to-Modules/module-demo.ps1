return "This is a demo script file."

#region Module basics and concepts

#PSModulePath
#this is using the .NET framework to identify the path separator
#which makes this cross-platform
$env:PSModulePath -split [IO.Path]::PathSeparator

#Listing modules
Get-Module
Get-Module -ListAvailable

#Find-Module
Find-Module -Name PSCalendar
# Install-Module -Name PSCalendar -Scope CurrentUser

start https://github.com/jdhitsolutions/psgalleryreport

#endregion

#region Build a module

Set-Location MyInfo
# review Module layout
psedit .\MyInfo.psm1
#look at files in functions

# New-ModuleManifest -Path .\MyInfo.psd1 -RootModule myInfo.psm1 -FunctionsToExport Get-ServerInfo
psedit .\MyInfo.psd1
import-module .\MyInfo.psd1 -force
get-command -module MyInfo

#create help with Platyps
# Install-Module Platyps
# https://github.com/PowerShell/platyPS
Get-Command -module Platyps

#generate markdown
# import the latest version of the module
# New-MarkdownHelp -Module MyInfo -OutputFolder .\docs
# edit markdown files
# Comment-based help will be imported.

#create external help - Use -Force to overwrite existing files
New-ExternalHelp -Path .\docs -OutputPath .\en-us -Force
Get-ChildItem .\en-us

# you would need to re-import the module
# import-module .\MyInfo.psd1 -force

#but now you have external help
help Get-ServerInfo -full

# module can be deployed

#endregion

#region module scope

psedit .\MyInfo\functions\vars.ps1
Import-Module .\MyInfo -Force
Get-ServerInfo Write-Verbose

#endregion