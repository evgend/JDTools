---
external help file: JDTools-help.xml
Module Name: JDTools
online version:
schema: 2.0.0
---

# New-LogFile

## SYNOPSIS
The New-LogFile create new log file.

## SYNTAX

```
New-LogFile [[-Module] <String>] [[-Path] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The New-LogFile create new log file by the prperties from config.xml

## EXAMPLES

### Example 1 Default config 
```powershell
PS C:\> New-LogFile

    Directory: C:\Logs

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            1/9/2025  2:56 PM              0 logfile-2025-01-09.log
```

### Example 2
```powershell
PS C:\> New-LogFile -Module DbAdSync

    Directory: C:\SyncManager\Logs

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            1/9/2025  2:56 PM              0 SyncManager-2025-01-09.log
```
## PARAMETERS

### -Module
PowerShell module name

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

### -Path
Please use .log in the end of the file name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
