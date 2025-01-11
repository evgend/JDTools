---
external help file: JDTools-help.xml
Module Name: JDTools
online version:
schema: 2.0.0
---

# New-JDModuleFolder

## SYNOPSIS
This function allow us to faster create folder for new PowerShell module.

## SYNTAX

```
New-JDModuleFolder [-ModuleName] <String> [-Path] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This function allow us to faster create folder for new PowerShell module.


## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ModuleName
New module name

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

### -Path
Path to filder where module will be placed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LanguageCode
Language folder for external based help.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: en-US
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
