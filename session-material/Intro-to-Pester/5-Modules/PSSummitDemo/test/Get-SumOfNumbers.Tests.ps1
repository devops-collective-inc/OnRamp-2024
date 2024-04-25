BeforeAll {
    Import-Module $PSScriptRoot/../src/PSSummitDemo.psd1 -Force
}

Describe 'Get-SumOfNumbers' {
    Context 'Adding Numbers' {
        BeforeAll {
            Mock -ModuleName PSSummitDemo Get-SumOfNumbers {
                return @(
                    8
                )
            }
            $result = Get-SumOfNumbers -FirstNumber 3 -SecondNumber 5
        }

        It 'Returns type should be Int32' {
            $result.GetType().Name | Should -Be 'Int32'
        }

        It 'Should Correcty Sum: 3 + 5 = 8' {
            $result | Should -Be 8
        }

    }
}

