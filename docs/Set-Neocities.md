Set-Neocities
-------------

### Synopsis
Sets Neocities files

---

### Description

Sets files on Neocities website using the neocities API.

---

### Parameters
#### **File**
The path to the file to upload, or a dictionary of files and their contents.

|Type        |Required|Position|PipelineInput        |Aliases                       |
|------------|--------|--------|---------------------|------------------------------|
|`[PSObject]`|false   |1       |true (ByPropertyName)|Fullname<br/>FilePath<br/>Path|

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
The access token

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

---

### Syntax
```PowerShell
Set-Neocities [[-File] <PSObject>] [[-Credential] <PSCredential>] [[-AccessToken] <String>] [<CommonParameters>]
```
