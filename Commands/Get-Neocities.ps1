function Get-Neocities
{
    <#
    .SYNOPSIS
        Gets neocities information
    .DESCRIPTION
        Gets neocities information from the neocities API, or lists the files in your neocities site.
    .EXAMPLE
        Get-Neocities
    .EXAMPLE    
        Get-Neocities -Credential $neocitiesCredential
    .EXAMPLE
        Get-Neocities -List
    #>
    [Alias('neocities')]
    [CmdletBinding(DefaultParameterSetName='info')]
    param(
    # If set, will list the files in your neocities site
    [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='list')]
    [switch]
    $List,

    # The credential used to connect.  
    # This only needs to be provided once per module session
    # (every time the module is imported)
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias(
        'Credentials', # Plural aliases are nice
        'PSCredential', # so are parameters that match the type name.
        'NeocitiesCredential', # A contextual alias is a good idea, too.
        'NeocitiesCredentials' # And you may need to pluralize that contextual alias.
    )]
    [PSCredential]
    $Credential,

    # The access token used to connect.
    # This only needs to be provided once per module session
    # (every time the module is imported)
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $AccessToken
    )

    begin {
        $NeocitiesApi = "https://neocities.org/api"
    }

    process {
        # The parameter set name contains the route
        $parameterSet = $PSCmdlet.ParameterSetName        
        # and we want to use this to decorate all returned values with a type name
        $psuedoNamespace = "neocities"
        $pseudoType = "$parameterSet"
        # Start by constructing the parameters for Invoke-RestMethod
        $InvokeSplat = [Ordered]@{
            Uri = "$NeocitiesApi", $PSCmdlet.ParameterSetName -join '/'
        }        

        # If an access token was provided
        if ($AccessToken)
        {
            # use it
            $InvokeSplat.Headers = @{Authorization = "Bearer $AccessToken"}
            # and cache it for later use
            $script:NeocitiesAccessToken = $AccessToken
        } 
        elseif ($Credential)
        {
            # If a credential was provided, use it
            $InvokeSplat.Credential = $Credential
            # and cache it for later use
            $script:NeoCitiesCredential = $Credential
            # (don't forget to set authentication to basic)
            $InvokeSplat.Authentication = 'Basic'
        }
        elseif ($script:NeocitiesAccessToken) {
            # If we had a cached access token, use it
            $InvokeSplat.Headers = @{Authorization = "Bearer $($script:NeocitiesAccessToken)"}
        }
        elseif ($script:NeoCitiesCredential) {
            # If we had a cached credential, use it
            $InvokeSplat.Credential = $script:NeoCitiesCredential
            # and don't forget to set authentication to basic.
            $InvokeSplat.Authentication = 'Basic'
        }

        # If neither an access token nor a credential was provided, we can't do anything.
        if (-not $InvokeSplat.Credential -and -not $InvokeSplat.Headers)
        {
            # so error out.
            Write-Error "No -Credential provided"
            return
        }


        # Write a little verbose message to let the user know what we're doing
        Write-Verbose "Requesting $($InvokeSplat.Uri)"
        # and get a response from neocities.
        $neocitiesResponse = Invoke-RestMethod @InvokeSplat
        switch ($parameterSet) {
            info {
                # If we're getting info, we want to return the info object
                $neocitiesResponse = $neocitiesResponse.info        
            }
            list {
                # If we're listing files, we want to return the files object
                $neocitiesResponse = @($neocitiesResponse.files)
                # and we want to return each as a 'file', not a 'list'
                $pseudoType = 'file'
            }
        }

        # Go over each response
        foreach ($neoResponse in $neocitiesResponse) {
            # and decorate them with the type name
            $neoResponse.pstypenames.clear()
            $neoResponse.pstypenames.insert(0, ($psuedoNamespace, $pseudoType -join '.'))
            # and output the response.
            $neoResponse
        }        
    }
}
