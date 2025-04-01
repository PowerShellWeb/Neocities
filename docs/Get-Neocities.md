Get-Neocities
-------------

### Synopsis
Gets neocities information

---

### Description

Gets neocities information from the neocities API, or lists the files in your neocities site.

---

### Examples
> EXAMPLE 1

```PowerShell
Get-Neocities
```
> EXAMPLE 2

```PowerShell
Get-Neocities -Credential $neocitiesCredential
```
> EXAMPLE 3

```PowerShell
Get-Neocities -List
```

---

### Parameters
#### **List**
If set, will list the files in your neocities site

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

#### **Credential**
The credential used to connect.  
This only needs to be provided once per module session
(every time the module is imported)
Plural aliases are nice
so are parameters that match the type name.
A contextual alias is a good idea, too.
And you may need to pluralize that contextual alias.

|Type            |Required|Position|PipelineInput        |Aliases                                                                      |
|----------------|--------|--------|---------------------|-----------------------------------------------------------------------------|
|`[PSCredential]`|false   |named   |true (ByPropertyName)|Credentials<br/>PSCredential<br/>NeocitiesCredential<br/>NeocitiesCredentials|

#### **AccessToken**
The access token used to connect.
This only needs to be provided once per module session
(every time the module is imported)

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Get-Neocities [-Credential <PSCredential>] [-AccessToken <String>] [<CommonParameters>]
```
```PowerShell
Get-Neocities -List [-Credential <PSCredential>] [-AccessToken <String>] [<CommonParameters>]
```
