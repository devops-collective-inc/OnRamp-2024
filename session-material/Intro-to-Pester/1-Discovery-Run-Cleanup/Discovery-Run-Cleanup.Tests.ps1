# We likely will see $planetTests flagged as an unused variable. This is currently a bug.
BeforeDiscovery {
    $planetTests = Get-ChildItem -Path "$PSScriptRoot/../0-Pester/*.Tests.ps1"
}

Describe 'Pester Discovery and Run' {
    # Before all the tests in this block we're going to define a PSCustomObject
    BeforeAll {
        $myObject = [PSCustomObject]@{
            Number = 1
            Name = 'Rob'
        }
    }

    # We saw before all in our planets example but here is one where BeforeAll is within a Describe
    # If you have specific parameters for a test you the BeforeAll doesn't always need to be in the root
    It 'Should be a PSCustomObject' {
        $myObject.GetType().name | Should -BeOfType [PSCustomObject]
    }

    # Note how our setup in BeforeAll can be used in child blocks.
    Context 'BeforeAll from above available to child containers' {
        It 'Should have a property "Name" with a value "Rob"' {
            $myObject.Name | Should -Be 'Rob'
        }
    }
}

####################################################

<#
    In this case Pester ran it's Discovery phase we want to get all files in the previous planets directory.
    We're going to iterate over them to run an test with It on each file.
#>
Describe 'Using Setup from BeforeDiscovery - File <_>' -ForEach $planetTests {
    It "<_.Name> Should be a ps1" {
        $_.Extension | Should -Be '.ps1'
    }
}

####################################################

# We can use AfterAll or AfterEach for cleanup
# We will use a BeforeEach to generate 5 text files with a random ID (GUID) then clean them up
Describe 'Teardown' {
    BeforeAll {
        $file = New-Item -Path $PSScriptRoot -Name "$([Guid]::NewGuid()).txt"
    }
    
    It 'Should be a text file' {
        $file.Extension | Should -Be '.txt'
    }

    AfterAll {
        # Sleep to show the file in VS Code before it gets deleted
        Start-Sleep -Seconds 5
        Remove-Item -Path "$PSScriptRoot/*.txt"
    }
}