Remove-Neocities
----------------

### Synopsis
Removes files from neocities

---

### Description

Removes files from a neocities site using the neocities API.

---

### Parameters
#### **FileName**
The name of the file to remove.

|Type        |Required|Position|PipelineInput        |Aliases          |
|------------|--------|--------|---------------------|-----------------|
|`[String[]]`|true    |1       |true (ByPropertyName)|FullName<br/>Path|

#### **Credential**
The neocities credential
Plural aliases are nice
so are parameters that match the type name.
A contextual alias is a good idea, too.
And you may need to pluralize that contextual alias.

|Type            |Required|Position|PipelineInput        |Aliases                                                                      |
|----------------|--------|--------|---------------------|-----------------------------------------------------------------------------|
|`[PSCredential]`|false   |2       |true (ByPropertyName)|Credentials<br/>PSCredential<br/>NeocitiesCredential<br/>NeocitiesCredentials|

#### **AccessToken**
The neocities access token.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.

If you pass ```-Confirm:$false``` you will not be prompted.

If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---

### Syntax
```PowerShell
Remove-Neocities [-FileName] <String[]> [[-Credential] <PSCredential>] [[-AccessToken] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
