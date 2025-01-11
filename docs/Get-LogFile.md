---
external help file: JDTools-help.xml
Module Name: JDTools
online version:
schema: 2.0.0
---

# Get-LogFile

## SYNOPSIS
Getting log file.

## SYNTAX

```
Get-LogFile [[-Module] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Getting log file.
By default function searching for log file inside C:\Logs

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-LogFile -Module DBAdSync


    Directory: C:\SyncManager\Logs


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----          1/8/2025   6:30 AM           4484 SyncManager-2025-01-08.log
```

## PARAMETERS

### -Module
Name of PowerShell module that contains logs parameter in their Config.xml

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: JDTools
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
