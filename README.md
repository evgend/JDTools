# JDTools Powershell module
## Project description
This module provides some tools to help write modules and functions.

## What this project does?
1. This tool provides function to write logs into a log file.

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

2. Import-ModuleConfig cmdlet helps to import preconfigured setting on config.xml file inside module folder and then for example wirte logs in a specific file. 

Example of config.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration>
    <Logs>
        <LogsFolder>C:\Logs</LogsFolder>
        <LogFileName>logfile.log</LogFileName>        
        <LoggingEnabled>$True</LoggingEnabled>
    </Logs>
</Configuration>
```

You can use it to store some settings and then read use it by Import-ModuleConfig function

```powershell
PS C:\> [xml]$script:YourModuleConfig = Import-ModuleConfig

PS C:\> $script:YourModuleConfig.Configuration.Logs.LogFileName
logfile.log
```

3. Function New-JDModuleFolder helps to create PowerShell module folder.

```powershell
PS C:\> New-JDModuleFolder -ModuleName MyNewModule -Path $env:UserProfile\Documents\WindowsPowerShell\Modules\
```