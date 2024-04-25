BeforeAll {
    Import-Module $PSScriptRoot/../src/PSSummitDemo.psd1 -Force
}

Describe 'Out-SummitMessage' {
    Context 'No Parameters' {
        BeforeAll {
            Mock -ModuleName PSSummitDemo Out-SummitMessage {
                return @(
                    [PSCustomObject]@{
                         'Message' = 'Hello Summit 2024!'
                         'SecondaryMessage' = 'Has Anyone Really Been Far Even as Decided to Use Even Go Want to do Look More Like?'
                    }
                )
            }
            $result = Out-SummitMessage -Message 'Test'
        }

        It 'Returns type should be PSCustomObject' {
            $result.GetType().Name | Should -Be 'PSCustomObject'
        }
    }
    Context 'When "Message" parameter is passed' {
        BeforeAll {
            Mock -ModuleName PSSummitDemo Out-SummitMessage -Verifiable -ParameterFilter {$Message -eq 'Test'} {
                return @(
                    [PSCustomObject]@{
                         'Message' = 'Test'
                         'SecondaryMessage' = 'Pester City USA'
                    }
                )
            }
            $result = Out-SummitMessage -Message 'Test'
        }

        It 'Returns type should be PSCustomObject' {
            $result.GetType().Name | Should -Be 'PSCustomObject'
        }
    }
}

