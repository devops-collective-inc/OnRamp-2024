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
    Now we're adding some context within our Describe.
    We didn't need to do this but it allows us to better group the tests!
#>
Describe 'Get-Planet' {
    Context 'No Parameter passed' {
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
    Context '"Name" Parameter Passed' {
        It 'filters based on a planet name' {
            $planet = Get-Planet -Name 'Mars'
            $planet.Name | Should -Be 'Mars'
        }
    }
}


