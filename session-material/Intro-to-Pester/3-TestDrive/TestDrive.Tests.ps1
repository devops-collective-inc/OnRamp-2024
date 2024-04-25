# This one is largerly referenced from the Pester docs, but it's that simple
BeforeAll {
    function Add-Footer($Path, $Footer) {
        Add-Content -Path $Path -Value $Footer
    }
}

Describe "Add-Footer" {
    BeforeAll {
        $testPath = "TestDrive:\pester.txt"
        Set-Content -Path $testPath -Value "Hello OnRamp! "
        Add-Footer -Path $testPath "Hello Summit 2024!"
        $result = Get-Content $testPath
    }

    It "Adds a footer" {
        (-join $result) | Should -Be "Hello OnRamp! Hello Summit 2024!"
    }
}