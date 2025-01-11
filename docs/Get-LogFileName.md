---
external help file: JDTools-help.xml
Module Name: JDTools
online version:
schema: 2.0.0
---

# Get-LogFileName

## SYNOPSIS
Getting name of current log file.

## SYNTAX

```
Get-LogFileName [[-Path] <Object>] [[-Name] <Object>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The name of the current log file.
This name will looks like logfile-2025-01-08.log
Function will return log file with currnet date.

## EXAMPLES

### Example 1 Get Currnet log file but furst we need to create it.
```powershell
PS C:\> New-LogFile

    Directory: C:\Logs

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----          1/8/2025  12:38 PM              0 logfile-2025-01-08.log

PS C:\> Get-LogFileName

    Directory: C:\Logs

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----          1/8/2025  12:40 PM              0 logfile-2025-01-08.log
```

## PARAMETERS

### -Name
Log File Name

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: logfile.log
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Path to log folder

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: C:\Logs
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
