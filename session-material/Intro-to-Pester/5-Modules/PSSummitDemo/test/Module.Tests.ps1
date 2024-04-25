Describe 'Module Structure and Syntax' {
    
    BeforeAll {
        $modulePath = Get-Item -Path $PSScriptRoot\..\src
        $moduleName = (Get-Item -Path "$modulePath\*.psd1").BaseName
        $moduleManifest = Join-Path -Path $modulePath -ChildPath "$moduleName.psd1"
        $manifest = Test-ModuleManifest -Path $moduleManifest -ErrorAction Stop -WarningAction SilentlyContinue
    }
    
    Context 'Module Manifest' {
        It 'has a valid manifest' {
			{ Test-ModuleManifest -Path $moduleManifest -ErrorAction Stop -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'has a valid name in the manifest' {
			$manifest.Name | Should -Be $moduleName
		}

		It 'has a valid root module' {
			$manifest.RootModule | Should -Be ($moduleName + ".psm1")
		}

		It 'has a valid version in the manifest' {
			$manifest.Version -as [Version] | Should -Not -BeNullOrEmpty
		}

		It 'has a valid description' {
			$manifest.Description | Should -Not -BeNullOrEmpty
		}

		It 'has a valid author' {
			$manifest.Author | Should -Not -BeNullOrEmpty
		}

		It 'has a valid guid' {
			{
				[guid]::Parse($manifest.Guid)
			} | Should -Not -Throw
		}

		It 'has a valid copyright' {
			$manifest.CopyRight | Should -Not -BeNullOrEmpty
		}
    }
    
    Context 'Public Functions' {
        BeforeAll {
            $functionsPublicPath = Join-Path -Path $modulePath -ChildPath 'Functions\Public'
            $functionsPublic = Get-ChildItem -Path $functionsPublicPath -Filter *.ps1
        }
        
        It 'has the same number of exported public functions for function ps1 files' {
            ($manifest.ExportedFunctions.GetEnumerator() | Measure-Object).Count | Should -Be ($functionsPublic | Measure-Object).Count
        }
        
        Context "Public Function Exported: <_.BaseName>" -ForEach $functionsPublic {

            It 'is exported in the module manifest' {
                $manifest.ExportedCommands.Keys.GetEnumerator() -contains $_.BaseName | Should -Be $true
            }
        }
	}
    
    Context 'All Functions' {
        BeforeAll {
            $functionsPrivatePath = Join-Path -Path $modulePath -ChildPath 'Functions\Private'
            if (Test-Path $functionsPrivatePath) {
                $functionsAll = Get-ChildItem -Path $functionsPublicPath, $functionsPrivatePath
            } else {
                $functionsAll = $functionsPublic
            }
        }
        
        Context "Function Syntax: <_.BaseName>" -ForEach $functionsAll {

            It 'has no syntax errors' {

                $functionContents = $null
                $psParserErrorOutput = $null
                $functionContents = Get-Content -Path $_.FullName
                [System.Management.Automation.PSParser]::Tokenize($functionContents, [ref]$psParserErrorOutput)

                ($psParserErrorOutput | Measure-Object).Count | Should -Be 0

            }
    	}
    }
}

