BeforeAll {
    function Get-Planet ([string]$Name = '*') {
        $planets = @(
            @{ Name = 'Mercury' }
            @{ Name = 'Venus'   }
            @{ Name = 'Earth'   }
            @{ Name = 'Mars'    }
            @{ Name = 'Jupiter' }
            @{ Name = 'Saturn'  }
            @{ Name = 'Uranus'  }
            @{ Name = 'Neptune' }
        ) | ForEach-Object { [PSCustomObject] $_ }

        $planets | Where-Object { $_.Name -like $Name }
    }
}

<#
    We've added some additional tests.
    Note that because we're still testing 'Get-Planet' we put them into the same describe box.
    We aren't required to do this, but it does make our test code cleaner.
#>
Describe 'Get-Planet' {
    It 'Given no parameters, it lists all 8 planets' {
        $allPlanets = Get-Planet
        $allPlanets.Count | Should -Be 8
    }

    It 'Earth is the third planet in our Solar System' {
        $allPlanets = Get-Planet
        $allPlanets[2].Name | Should -Be 'Earth'
    }

    It 'Pluto is not part of our Solar System' {
        $allPlanets = Get-Planet
        $plutos = $allPlanets | Where-Object Name -EQ 'Pluto'
        $plutos.Count | Should -Be 0
    }

    It 'Planets have this order: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune' {
        $allPlanets = Get-Planet
        $planetsInOrder = $allPlanets.Name -join ', '
        $planetsInOrder | Should -Be 'Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune'
    }
}


