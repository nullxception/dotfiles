@{
    RootModule        = 'envutil.psm1'
    ModuleVersion     = '0.0.1'
    GUID              = 'f8cee14d-de54-458f-9407-a8e8729194c6'
    Author            = 'Chaldeaprjkt'
    CompanyName       = 'Chaldeaprjkt'
    Description       = 'Set of utilities for modifying environment variables'
    Copyright         = '(c) Chaldeaprjkt. All rights reserved.'
    FunctionsToExport = @('Register-Path', 'Register-Env', 'Update-CurrentEnv', 'Optimize-UserPath')
    CmdletsToExport   = @()
    VariablesToExport = '*'
    AliasesToExport   = @()
    PrivateData       = @{
        PSData = @{}
    }
}
