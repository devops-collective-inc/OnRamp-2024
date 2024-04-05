return "This is a demo script file."

#region Scripting basics

# .ps1 text file
# same commands plus logic and scripting constructs

#endregion
#region Scripting security

#ExecutionPolicy
Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
#default association
invoke-item .\SampleScript.ps1
#specify path
dir samplescript.ps1
samplescript.ps1
#file extension not required
.\SampleScript
#I prefer it for clarity
.\SampleScript.ps1

#endregion
#region Scope

help about_Scopes

#endregion

psedit .\SampleScript.ps1
psedit .\SampleScript2.ps1

#region profile scripts

$profile
$profile | Get-Member -MemberType NoteProperty | gm
$profile.CurrentUserAllHosts

$profile | Get-Member -MemberType NoteProperty |
ForEach-Object {
    $file = Get-Item $profile.$($_.Name) -ErrorAction SilentlyContinue
    $hash = [ordered]@{
        Profile = $_.Name
        Path = $profile.$($_.Name)
        Exists = Test-Path $profile.$($_.Name)
        Size = $file.Length
        LastUpdated = $file.LastWriteTime
        Host = $Host.Name
        User = $env:USERNAME
    }
    New-Object PSObject -property $hash
}


#an advanced alternative
$profile.PSObject.Properties |
Where {$_.MemberType -eq 'NoteProperty' } | Select-Object Name,
@{Name="Path";Expression={$_.Value}},
@{Name="Exists";Expression={Test-Path $_.Value}},
@{Name="Size";Expression={
    #my profiles use symbolic links
    $file = Get-Item $_.Value
    If ($file.Target) {
        Get-Item $file.Target | Select-Object -ExpandProperty Length
    }
    Else {
        $file.Length
    }
}},
@{Name="LastUpdated";Expression={
    $file = Get-Item $_.Value
    If ($file.Target) {
        Get-Item $file.Target | Select-Object -ExpandProperty LastWriteTime
    }
    Else {
        $file.LastWriteTime
    }
}},
@{Name="Host";Expression={$Host.Name}},
@{Name="User";Expression={$env:USERNAME}}

#endregion
