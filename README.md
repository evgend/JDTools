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

2. Module configuration

In order to automate some task it is good to have a configuration file. The structure of these files can be very different.
For convenience, I chose two attributes: name and type.
For the name, a simple string will be used. The main thing is that it does not repeat. It will be used as the parameter name in the object.
The sheath type is to help the Set-ModuleConfig function with assigning values ​​to the text field.
If the type is dynamic - the text parameter can be changed.
If the type is static - the text parameter cannot be changed.

Import-ModuleConfig cmdlet helps to import preconfigured setting on config.xml file inside module folder and then for example wirte logs in a specific file. 

Example of config.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration>
    <Logs>
        <Parameter name="LoggingEnabled" type="dynamic">False</Parameter>
        <Parameter name="LogsFolder" type="dynamic">C:\Logs</Parameter>
        <Parameter name="LogFileName" type="dynamic">logfile.log</Parameter>
        <Parameter name="LogFileDate" type="static">Get-Date -UFormat '%Y-%m-%d'</Parameter>
    </Logs>
</Configuration>
```

You can use it to store some settings and then read them using Import-ModuleConfig function

```powershell
PS C:\> [xml]$script:YourModuleConfig = Import-ModuleConfig
```

Also to simplify output we can use Get-ModuleConfig. This function converts config.xml file stored inside module folder to Powershell object.

```powershell
PS C:\> Get-ModuleConfig -Module 'JDTools'

LoggingEnabled LogsFolder LogFileName LogFileDate
-------------- ---------- ----------- -----------
         False C:\Logs    logfile.log Get-Date -UFormat '%Y-%m-%d'
```

Get config for module DbADSync and serching for a spesial parameter.

```powershell
PS C:\> Get-ModuleConfig -Module DbADSync -XPath '//Entity[@name="ADDomain"]/Properties/Property'

#text
-----
ComputersContainer
DeletedObjectsContainer
DistinguishedName
DNSRoot
DomainControllersContainer
DomainMode
Forest
InfrastructureMaster
LostAndFoundContainer
Name
NetBIOSName
ObjectClass
ObjectGUID
PDCEmulator
QuotasContainer
RIDMaster
SystemsContainer
UsersContainer
```

The Set-ModuleConfig function allows you to set configuration parameters for a specified module by modifying its configuration file (Config.xml). It supports dynamic parameters based on the module's configuration.
In this case function reads config.xml file and retries all paramets with dinamic type. 

```powershell
PS C:\> Set-ModuleConfig -Module 'JDTools' -LogsFolder C:\MySuperLogFolder
```

3. Function New-JDModuleFolder helps to create PowerShell module folder.

```powershell
PS C:\> New-JDModuleFolder -ModuleName MyNewModule -Path $env:UserProfile\Documents\WindowsPowerShell\Modules\
```