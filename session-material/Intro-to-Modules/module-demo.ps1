return "This is a demo script file."

#Module basics and concepts

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