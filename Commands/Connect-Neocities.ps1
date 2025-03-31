function Connect-Neocities
{
    <#
    .SYNOPSIS
        Connect to Neocities
    .DESCRIPTION
        Connect to Neocities using a credential object. 
        
        This will create a session that can be used to authenticate to the Neocities API.
    .LINK
        Get-Neocities
    #>
    param(
    # The Neocities credential
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias(
        'Credentials', # Plural aliases are nice
        'PSCredential', # so are parameters that match the type name.
        'NeocitiesCredential', # A contextual alias is a good idea, too.
        'NeocitiesCredentials' # And you may need to pluralize that contextual alias.
    )]
    [PSCredential]
    $Credential
    )

    begin {
        $NeocitiesApi = "https://neocities.org/api"
    }

    process {
        Invoke-RestMethod -Uri ($NeocitiesApi,'key' -join '/') -Credential $Credential -Authentication Basic
    }
}
