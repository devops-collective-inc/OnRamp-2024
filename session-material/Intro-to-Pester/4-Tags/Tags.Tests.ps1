Describe "Get-Beer" {

    Context "acceptance tests" -Tag "Acceptance" {

        It "acceptance test 1" -Tag "Slow", "Flaky" {
            1 | Should -Be 1
        }

        It "acceptance test 2" {
            1 | Should -Be 1
        }

        It "acceptance test 3" -Tag "WindowsOnly" {
            1 | Should -Be 1
        }

        It "acceptance test 4" -Tag "Slow" {
            1 | Should -Be 1
        }

        It "acceptance test 5" -Tag "LinuxOnly" {
            1 | Should -Be 1
        }
    }

    Context "unit tests" {

        It "unit test 1" {
            1 | Should -Be 1
        }

        It "unit test 2" -Tag "LinuxOnly" {
            1 | Should -Be 1
        }

    }
}

# Invoke-Pester $path -Tag "Acceptance" -ExcludeTag "Flaky", "Slow", "LinuxOnly"