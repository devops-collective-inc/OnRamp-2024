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
