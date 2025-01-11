---
external help file: JDTools-help.xml
Module Name: JDTools
online version:
schema: 2.0.0
---

# Write-log

## SYNOPSIS
The Write-Log cmdlet helps us to build log file content.

## SYNTAX

```
Write-log [[-Message] <String>] [[-Module] <String>] [[-Path] <String>] [[-MessageType] <String>] [-WriteBegin]
 [-WriteEnd] [-WriteDate] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Write-Log cmdlet helps us to build log file content.
We can choose what type of record to put in the log file.

SUCCESS, OPERATION, WARNING, ERROR

Also we can choose start and end messages.

## EXAMPLES

### Example 1
```powershell
PS C:\> Write-Log -WriteDate -WriteBegin -Message "Success message" -MessageType SUCCESS
PS C:\> Write-Log -WriteDate -Message "OPERATION message" -MessageType OPERATION
PS C:\> Write-Log -WriteDate -Message "WARNING message" -MessageType WARNING
PS C:\> Write-Log -WriteDate -Message "ERROR message" -MessageType ERROR
PS C:\> Write-Log -WriteDate -WriteEnd
PS C:\> Get-Content (Get-LogFilePath)
 --- START --- --- --- --- --- --- --- --- --- 
2025-01-11 13:56:50 SUCCESS: Success message
2025-01-11 13:56:50 OPERATION: OPERATION message
2025-01-11 13:56:50 WARNING: WARNING message
2025-01-11 13:56:50 ERROR: ERROR message
2025-01-11 13:56:50 
 ---  END  --- --- --- --- --- --- --- --- ---
```

## PARAMETERS

### -Message
Specifies the message to output log.

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

### -MessageType
Specifies message type.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: SUCCESS, OPERATION, WARNING, ERROR

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Module
Specifies name of PowerShell module that have config.xml with LoggingEnabled specified.

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
Please use .log in the end of the file name. Path to log file.

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

### -WriteBegin
Specifies start message

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WriteDate
Specifies date time

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WriteEnd
Specifies end message

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
