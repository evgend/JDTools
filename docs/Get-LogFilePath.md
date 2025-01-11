---
external help file: JDTools-help.xml
Module Name: JDTools
online version:
schema: 2.0.0
---

# Get-LogFilePath

## SYNOPSIS
CmdLet shows current log file name it depends from config.xml

## SYNTAX

```
Get-LogFilePath [[-Module] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1 Getting logfile for Module JD Tools.
```powershell
PS C:\> Get-LogFilePath
C:\Logs\logfile-2025-01-08.log
```

### Example 1 Getting log file fro module DbAdSync.
```powershell
PS C:\> Get-LogFilePath -Module DbAdSync
C:\SyncManager\Logs\SyncManager-2025-01-08.log
```

## PARAMETERS

### -Module
Name of th powershell module

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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
