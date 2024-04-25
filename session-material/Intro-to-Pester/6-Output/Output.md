# Pester

## Output

Pester is able to output test results in multiple different ways.

### CLI `-Output`

`Invoke-Pester -Path . -Output <OutputType>

```powershell
# None
Invoke-Pester -Path ../5-Modules/PSSummitDemo/test/ -Output None

# Normal (Default)
# No need to specify the -Out=put param
Invoke-Pester -Path ../5-Modules/PSSummitDemo/test/

# Detailed
# My favorite view <3
Invoke-Pester -Path ../5-Modules/PSSummitDemo/test/ -Output Detailed

# Diagnostic
# This is great to see how Pester is running Discovery, Run, Mock setup etc.
# Great for test debugging!
Invoke-Pester -Path ../5-Modules/PSSummitDemo/test/ -Output Diagnostic
```

### Alternative Outputs as of Pester 5.3

#### `-CIFormat`

Often times you'll run Pester as part of a CI/CD pipeline on a platform like Github.

In order for these platforms to better parse the tests you can use `-CIFormat` for your specific provider.

#### `StackTraceVerbosity`

This setting can be adjusted so if your test fails you get a much deeper level of detail on the stack trace returned.
