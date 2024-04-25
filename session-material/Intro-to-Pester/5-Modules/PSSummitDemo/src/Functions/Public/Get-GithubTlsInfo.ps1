function Get-GithubTlsInfo {
    [CmdletBinding()]
    param ()
    process {
        $ghTls = Get-TlsInformation
        $ghTls
    }
}
