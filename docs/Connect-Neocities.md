Connect-Neocities
-----------------

### Synopsis
Connect to Neocities

---

### Description

Connect to Neocities using a credential object. 

This will create a session that can be used to authenticate to the Neocities API.

---

### Related Links
* [Get-Neocities](Get-Neocities.md)

---

### Parameters
#### **Credential**
The Neocities credential
Plural aliases are nice
so are parameters that match the type name.
A contextual alias is a good idea, too.
And you may need to pluralize that contextual alias.

|Type            |Required|Position|PipelineInput        |Aliases                                                                      |
|----------------|--------|--------|---------------------|-----------------------------------------------------------------------------|
|`[PSCredential]`|false   |1       |true (ByPropertyName)|Credentials<br/>PSCredential<br/>NeocitiesCredential<br/>NeocitiesCredentials|

---

### Syntax
```PowerShell
Connect-Neocities [[-Credential] <PSCredential>] [<CommonParameters>]
```
