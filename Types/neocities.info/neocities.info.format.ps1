Write-FormatView -TypeName 'neocities.info' -Property SiteName, Views, Hits, CreatedAt, UpdatedAt, Url -AutoSize -VirtualProperty @{
    SiteName = { 
        if ($psStyle) {
            $PSStyle.FormatHyperlink($_.SiteName, $_.Url)
        } else {
            $_.SiteName
        }
    }
}
