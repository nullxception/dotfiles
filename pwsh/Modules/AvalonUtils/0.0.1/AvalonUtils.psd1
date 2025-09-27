@{
    RootModule        = 'AvalonUtils.psm1'
    ModuleVersion     = '0.0.1'
    GUID              = 'f8cee14d-de54-458f-9407-a8e8729194c6'
    Author            = 'Nauval'
    CompanyName       = 'Chaldeastudio'
    Description       = 'Set of utilities for the chaldeans'
    Copyright         = '(c) Nauval. All rights reserved.'
    FunctionsToExport = @("Register-Path", "Register-Env", "Update-CurrentEnv")
    CmdletsToExport   = @()
    VariablesToExport = '*'
    AliasesToExport   = @()
    PrivateData       = @{
        PSData = @{}
    }
}
