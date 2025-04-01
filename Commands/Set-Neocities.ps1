function Set-Neocities
{
    <#
    .SYNOPSIS
        Sets Neocities files
    .DESCRIPTION
        Sets files on Neocities website using the neocities API.
    #>
    [CmdletBinding(DefaultParameterSetName='upload')]
    param(
    # The path to the file to upload, or a dictionary of files and their contents.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Fullname','FilePath','Path')]
    [PSObject]
    $File,    
    
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

    # The access token
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $AccessToken
    )

    begin {
        $NeocitiesApi = "https://neocities.org/api"
        $multiparts = [Ordered]@{}
        $boundary = "boundary"
        $contentType = "multipart/form-data; boundary=`"$boundary`""
        
    }
    process {
        $parameterSet = $PSCmdlet.ParameterSetName
        $psuedoNamespace = "neocities"
        $pseudoType = "$parameterSet"
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

        $InvokeSplat.ContentType = $contentType

        # If we were piped in a file
        if ($_ -is [IO.FileInfo]) {
            $file = $_ # set the parameter directly             
        }

        # For every file passed in, we need to make a unique request.
        foreach ($fileInfo in $file) {
            # If this is a file, this is easy
            if ($fileInfo -is [IO.FileInfo]) {
                # just get the string representation of the file's bytes and add them to the multipart collection
                $multiparts[$file.Name] = $OutputEncoding.GetString([IO.File]::ReadAllBytes($file))
            }
            # If the file was a path, we need to get the file's contents
            elseif ($fileInfo -is [string] -and (Test-Path $fileInfo)) {
                $multiparts[$fileInfo] = Get-Content -Raw $fileInfo
            }
            # If the file was a dictionary, treat each key as a file name and each value as the file's contents
            elseif ($fileInfo -is [Collections.IDictionary]) {
                foreach ($keyValuePair in $fileInfo.GetEnumerator()) {
                    # If the value is a byte array, convert it to a string
                    if ($keyValuePair.Value -is [byte[]]) {                        
                        $multiparts[$keyValuePair.Key] = $OutputEncoding.GetString($keyValuePair.Value)                    
                    }
                    # If the value is a file, read the file's bytes and convert them to a string
                    elseif ($keyValuePair.Value -is [IO.FileInfo]) {
                        $multiparts[$keyValuePair.Key] = $OutputEncoding.GetString([IO.File]::ReadAllBytes($keyValuePair.Value))
                    }
                    # If the value is a pth to  file, read the file's bytes and convert them to a string
                    elseif ($keyValuePair.Value -is [string] -and (Test-Path $keyValuePair.Value)) {
                        $multiparts[$keyValuePair.Key] = Get-Content -Raw $keyValuePair.Value
                    }
                    # last but not least, stringify the value and add it to the collection
                    else
                    {
                        $multiparts[$keyValuePair.Key] = "$($keyValuePair.Value)"
                    }                           
                }
            }
        }
        
    }

    end {
        # Despite the content type being multipart, we can actually only send one part at a time:

        # Any way we slice it, we'll need to POST the data to the API.
        $InvokeSplat.Method = 'POST'


        # For each part we've found
        foreach ($filePart in $multiparts.GetEnumerator()) {
            $InvokeSplat.Body = @(
                # Create a bounary
                "--$boundary"
                # Add the file name and content type to the header
                "Content-Disposition: form-data; name=`"$($filePart.Key)`"; filename=`"$($filePart.Key)`""
                # We're always uploading this a text/plain with neocities, and we need to set the encoding to whatever we passed.
                "Content-Type: text/plain; charset=$($OutputEncoding.WebName)"
                # The bounary MIME data must be followed by a newline
                "`r`n"
                # followed by the file contents
                $filePart.Value
                # followed by an additional boundary
                "--$boundary--"
            ) -join "`r`n" # (all of these pieces are joined by a newline)

            # If -WhatIf was passed, don't actually upload the file, just show the splatted parameters.
            if ($WhatIfPreference) {
                # (Remove the headers and credential from the splatted parameters, so we don't leak any sensitive information)
                $InvokeSplat.Remove('Headers')
                $InvokeSplat.Remove('Credential')
                $InvokeSplat
                continue
            }

            # Invoke-RestMethod with our splatted parameters, and we'll upload the file.
            Invoke-RestMethod @InvokeSplat
        }
    }
}