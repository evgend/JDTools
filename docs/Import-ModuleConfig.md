---
external help file: JDTools-help.xml
Module Name: JDTools
online version:
schema: 2.0.0
---

# Import-ModuleConfig

## SYNOPSIS
The Import-ModuleConfig allows to import module config

## SYNTAX

```
Import-ModuleConfig [-Module] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Import-ModuleConfig allows to import module config file in case that this XML config.xml file present in the module folder.

## EXAMPLES

### Example 1 Import module config to script variable to be able to access config properties.
```powershell
PS C:\> [xml]$script:JDToolsModuleConfig = Import-ModuleConfig -Module JDTools
```

## EXAMPLES

### Example 2 Import module config to script variable to be able to access config properties.
```powershell
PS C:\> [xml]$script:DbAdSyncModuleConfig = Import-ModuleConfig -Module DbAdSync
```

## PARAMETERS

### -Module
PowerShell module name

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
