function Out-SummitMessage {
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param (
        # Message
        [Parameter(Mandatory=$false, Position=0)]
        [String]
        $Message = 'Hello Summit 2024!'
    )
    process {
        $addedMessage = Get-Message 

        $out = [PSCustomObject]@{
            Message = $Message
            SecondaryMessage = $addedMessage
        }

        $out
    }
}
