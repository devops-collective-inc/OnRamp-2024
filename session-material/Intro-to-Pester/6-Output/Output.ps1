###########
# -Output #
###########

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
