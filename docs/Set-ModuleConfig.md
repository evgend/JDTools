---
external help file: JDTools-help.xml
Module Name: JDTools
online version:
schema: 2.0.0
---

# Set-ModuleConfig

## SYNOPSIS
Sets configuration parameters for a specified module.

## SYNTAX

```
Set-ModuleConfig [-Module] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Set-ModuleConfig function allows you to set configuration parameters for a specified module by modifying its configuration file (Config.xml). It supports dynamic parameters based on the module's configuration.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-ModuleConfig -Module JDTools -LogsFolder C:\Logs
```

This command sets the specified parameters for the JDTools module.

## PARAMETERS

### -Module
The name of the module whose configuration settings need to set. This parameter is mandatory.

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
