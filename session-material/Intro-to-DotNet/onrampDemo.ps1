Write-Host "return so pressing F5 doesn't accidentally run everything"
return

#region Environment Variables

Write-Host "Process Implicit: " -ForegroundColor Green -NoNewline
Write-Host $env:OnRamp

Write-Host "Process Explicit: " -ForegroundColor Green -NoNewline
Write-Host ([Environment]::GetEnvironmentVariable('OnRamp', [System.EnvironmentVariableTarget]::Process))

Write-Host "User: " -ForegroundColor Green -NoNewline
Write-Host ([Environment]::GetEnvironmentVariable('OnRamp', [System.EnvironmentVariableTarget]::User))

Write-Host "System: " -ForegroundColor Green -NoNewline
Write-Host ([Environment]::GetEnvironmentVariable('OnRamp', [System.EnvironmentVariableTarget]::Machine))

#endregion


#region Special Folders

[Environment]::GetFolderPath([environment+specialfolder]::LocalApplicationData)

#endregion

#region Find Admin

$currentUser = [Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())
$currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

#endregion

#region Encoding Things

$project = [System.Web.HttpUtility]::UrlEncode('corbob/test-package-creation')
# This command may not work for anyone that isn't corbob.
Write-Host $project
glab api "projects/$project"
[System.Web.HttpUtility]::UrlDecode('corbob/test-package%20creation')

#endregion

#region String Comparisons

$empty = ""
$whitespace = " `t"
if ($null -eq $empty -or $empty -eq "") {
    "string was null - empty"
}
[string]::IsNullOrEmpty($whitespace)
$null -eq $whitespace
[string]::IsNullOrWhitespace($null)
[string]::IsNullOrWhiteSpace($whitespace)

#endregion

#region Email Mike Robbins

$mikeEmail = 'JwBtAGkAawBlAGYAcgBvAGIAYgBpAG4AcwBAAGcAbQBhAGkAbAAuAGMAbwBtACcA'
[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($mikeEmail))

#endregion

#region File System Separators

# If you need to know the $env:PATH separator character
[System.IO.Path]::PathSeparator

# If you're building a path and for some reaon can't use Join-Path or Split-Path
[System.IO.Path]::DirectorySeparatorChar

#region