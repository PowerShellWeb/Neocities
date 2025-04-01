@{
    ModuleVersion = '0.1'
    RootModule = 'Neocities.psm1'
    Guid = 'd62958e7-1cc7-470b-bde3-da29e96579fd'
    Author = 'James Brundage'
    CompanyName = 'Start-Automating'
    Copyright = '2025 Start-Automating'
    Description = 'Neocities PowerShell - Personal Webpages in PowerShell'
    FunctionsToExport = @('Connect-Neocities','Get-Neocities','Set-Neocities','Remove-Neocities')
    AliasesToExport = @('Neocities')
    FormatsToProcess = @('Neocities.format.ps1xml')
    TypesToProcess = @('Neocities.types.ps1xml')
    PrivateData = @{
        PSData = @{
            Tags = @('neocities', 'PowerShell', 'Web', 'PowerShellWeb')
            ProjectURI = 'https://github.com/PowerShellWeb/NeoPS'
            LicenseURI = 'https://github.com/PowerShellWeb/NeoPS/blob/main/LICENSE'
            ReleaseNotes = @'            
> Like It? [Star It](https://github.com/PowerShellWeb/NeoPS)
> Love It? [Support It](https://github.com/sponsors/StartAutomating)

## Neocities 0.1

Initial Neocities module (#1):

* Get-Neocities (#2)
* Set-Neocities (#3)
* Remove-Neocities (#5)
* Connect-Neocities (#4)

---
'@
        }
    }
}