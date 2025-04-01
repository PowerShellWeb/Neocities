function Remove-Neocities
{
    <#
    .SYNOPSIS
        Removes files from neocities
    .DESCRIPTION
        Removes files from a neocities site using the neocities API.
    #>
    [CmdletBinding(DefaultParameterSetName='delete',SupportsShouldProcess,ConfirmImpact='High')]
    param(
    # The name of the file to remove.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('FullName','Path')]
    [string[]]
    $FileName,

    
    # The neocities credential
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias(
        'Credentials', # Plural aliases are nice
        'PSCredential', # so are parameters that match the type name.
        'NeocitiesCredential', # A contextual alias is a good idea, too.
        'NeocitiesCredentials' # And you may need to pluralize that contextual alias.
    )]
    [PSCredential]
    $Credential,

    # The neocities access token.  
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $AccessToken
    )

    begin {
        $NeocitiesApi = "https://neocities.org/api"
    }

    process {
        $parameterSet = $PSCmdlet.ParameterSetName
        $psuedoNamespace = "neocities"
        $pseudoType = "$parameterSet"
        $InvokeSplat = [Ordered]@{
            Uri = "$NeocitiesApi", $PSCmdlet.ParameterSetName -join '/'
            Method = 'POST'
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

        # For every file name provided, we need to remove it from the neocities site.
        foreach ($file in $fileName) {
            # Despite the name taking an array, we need to remove one file at a time.
            $InvokeSplat.Body = 
                [web.httputility]::UrlEncode("filenames[]"),'=',[web.httputility]::UrlEncode($file) -join ''
            Write-Verbose "Requesting $($InvokeSplat.Uri)"
            # If -WhatIf was specified, we need to remove the credential and headers from the splat
            if ($WhatIfPreference) {
                $splatCopy = [Ordered]@{} + $InvokeSplat
                $splatCopy.Remove('Credential')
                $splatCopy.Remove('Headers')
                # and then output the splat to the pipeline
                $splatCopy
                continue
            }
            # If we did not confirm the deletion
            if (-not $PSCmdlet.ShouldProcess("Delete $file")) {
                # skip it.
                continue
            }
            
            # Get the response from neocities.
            $neocitiesResponse = Invoke-RestMethod @InvokeSplat
            # and decorate any response so that we know it was a deletion. 
            foreach ($neoResponse in $neocitiesResponse) {
                $neoResponse.pstypenames.clear()
                $neoResponse.pstypenames.insert(0, ($psuedoNamespace, $pseudoType -join '.'))
                $neoResponse
            }
        }                                
    }
}
