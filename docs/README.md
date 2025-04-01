## Neocities

Manage Neocities with PowerShell

[https://neocities.org](Neocities) is a wonderful site for free personal webpages.

It's bringing back the ethos of old internet: one of the most popular free hosting services of the 90s was [geocities](https://en.wikipedia.org/wiki/GeoCities).

## The Neocities Module

Neocities is also the name a PowerShell module to manage Neocities (no official relation).

The Neocities module PowerShell is built atop the [neocities api](https://neocities.org/api).

### Installing and Importing

You can install the Neocities module by using the [PowerShell Gallery](https://powershellgallery.com)

~~~PowerShell
Install-Module Neocities
~~~

Once installed, you can import it with:

~~~PowerShell
Import-Module Neocities -PassThru
~~~

### Neocities Commands 

* [Get-Neocities](Get-Neocities.md) gets neocities content
* [Set-Neocities](Set-Neocities.md) sets neocities content
* [Remove-Neocities](Remove-Neocities.md) removes neocities content
* [Connect-Neocities](Connect-Neocities.md) connects with a credential and gives you an access token
