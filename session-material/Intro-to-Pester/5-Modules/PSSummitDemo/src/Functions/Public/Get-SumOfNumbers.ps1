function Get-SumOfNumbers {
    [CmdletBinding()]
    [OutputType([Int])]
    param (
        # First Int
        [Parameter(Mandatory=$true, Position=0)]
        [Int]
        $FirstNumber,

        # Second Int
        [Parameter(Mandatory=$true, Position=1)]
        [Int]
        $SecondNumber
    )
    process {
        #$myUnusedVariable = 'Bobby'

        $sum = $FirstNumber + $SecondNumber
        $sum
    }
}
