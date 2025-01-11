---
external help file: JDTools-help.xml
Module Name: JDTools
online version:
schema: 2.0.0
---

# New-TempLogs

## SYNOPSIS
The New-TempLogs cmdlet create temporary files for testing

## SYNTAX

```
New-TempLogs [[-Path] <String>] [[-Name] <String>] [[-NumberOfDays] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The New-TempLogs cmdlet create temporary files for testing

## EXAMPLES

### Example 1 New log files for 30 days in C:\Logs folder.
```powershell
PS C:\> New-TempLogs

    Directory: C:\Logs

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2025-01-08.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2025-01-07.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2025-01-06.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2025-01-05.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2025-01-04.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2025-01-03.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2025-01-02.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2025-01-01.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-31.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-30.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-29.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-28.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-27.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-26.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-25.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-24.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-23.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-22.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-21.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-20.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-19.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-18.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-17.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-16.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-15.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-14.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-13.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-12.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-11.log
-a---            1/9/2025  3:19 PM              0 logfile-2025-01-09-2024-12-10.log
```

{{ Add example description here }}

## PARAMETERS

### -Name
Log file name.

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

### -NumberOfDays
Number of days that we want to generate log files.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Folder Path

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
