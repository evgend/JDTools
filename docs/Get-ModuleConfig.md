---
external help file: JDTools-help.xml
Module Name: JDTools
online version:
schema: 2.0.0
---

# Get-ModuleConfig

## SYNOPSIS
Retrieves configuration settings from a specified module.

## SYNTAX

```
Get-ModuleConfig [-Module] <String> [[-XPath] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-ModuleConfig function retrieves configuration settings from a specified module's configuration file (Config.xml) based on the provided XPath.

## EXAMPLES

### Example 1 Get config for module JDTools.
```powershell
PS C:\> Get-ModuleConfig -Module JDTools

LogFileName LoggingEnabled LogsFolder LogFileDate
----------- -------------- ---------- -----------
logfile.log          False C:\Logs    Get-Date -UFormat '%Y-%m-%d'
```

### Example 2 Get config for module DbADSync and serching for a spesial parameter.
```powershell
PS C:\> Get-ModuleConfig -Module DbADSync -XPath '//Entity[@name="ADDomain"]/Properties/Property'

#text
-----
ComputersContainer
DeletedObjectsContainer
DistinguishedName
DNSRoot
DomainControllersContainer
DomainMode
Forest
InfrastructureMaster
LostAndFoundContainer
Name
NetBIOSName
ObjectClass
ObjectGUID
PDCEmulator
QuotasContainer
RIDMaster
SystemsContainer
UsersContainer
```

## PARAMETERS

### -Module
The name of the module whose configuration settings are to be retrieved. This parameter is mandatory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -XPath
The XPath query to select specific nodes from the configuration file. If not provided, all parameters are returned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
The ProgressAction parameter in PowerShell is used to control how progress is displayed when running cmdlets or functions that support progress reporting. It is often available in cmdlets that involve long-running operations, such as downloading files, processing large datasets, or other intensive tasks.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
