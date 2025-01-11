function Import-ModuleConfig {
    #.ExternalHelp JDTools.Help.xml
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Module
    )    
    process {
        try {
            $ModuleBase = Get-Module -Name $Module -ListAvailable -ErrorAction Stop | Select-Object -ExpandProperty ModuleBase
        } catch {
            # Error handling
            [Management.Automation.ErrorRecord]$e = $_
            $Message = "`nException`t: $($e.Exception.Message)`nReason`t`t: $($e.CategoryInfo.Reason)`nTarget`t`t: $($e.CategoryInfo.TargetName)`nScript`t`t: $($e.InvocationInfo.ScriptName)`nLine`t`t: $($e.InvocationInfo.ScriptLineNumber)`nColumn`t`t: $($e.InvocationInfo.OffsetInLine)"
			Write-Warning -Message $Message
            Break
        } finally {
            $ModuleConfigPath = "$($ModuleBase)\Config.xml"
            if (Test-Path $ModuleConfigPath) {
                Write-Output (Get-Content -Path $ModuleConfigPath)
            } else {
                $Message = "Configuration file: $ModuleConfigPath not found"
                Write-Warning -Message $Message
            }
        }
    }
}#END Function
[xml]$script:JDToolsModuleConfig = Import-ModuleConfig -Module JDTools
Function Get-LogFile {
    #.ExternalHelp JDTools.Help.xml
    [cmdletbinding()]
    Param (
        [string]$Module = 'JDTools'
    )
    begin {
        $Path = Get-LogFilePath -Module $Module
    }
    process {
        Get-Item "$Path" -ErrorAction stop
    }
}#END Function
Function Get-LogFileName {
    #.ExternalHelp JDTools.Help.xml
    [cmdletbinding()]
    Param (
        $Path = $script:JDToolsModuleConfig.Configuration.Logs.LogsFolder,
        $Name = $($script:JDToolsModuleConfig.Configuration.Logs.LogFileName.split('.')[0] + '-'+ 
        (Invoke-Expression $script:JDToolsModuleConfig.Configuration.Logs.LogFileDate) + '.'+ 
        $script:JDToolsModuleConfig.Configuration.Logs.LogFileName.split('.')[1])
    )
    process {
        Get-Item "$Path\$Name" -ErrorAction stop
    }
}#END Function
Function Get-LogFilePath {
    #.ExternalHelp JDTools.Help.xml
    [cmdletbinding()]
        Param (
            [string]$Module = 'JDTools'
        )
    begin {
        [xml]$ModuleConfig = Import-ModuleConfig -Module $Module
        $Path = $ModuleConfig.Configuration.Logs.LogsFolder
        $Name = $( $ModuleConfig.Configuration.Logs.LogFileName.split('.')[0] + '-'+ 
            (Invoke-Expression  $ModuleConfig.Configuration.Logs.LogFileDate) + '.'+ 
            $ModuleConfig.Configuration.Logs.LogFileName.split('.')[1])
    }
    process {
        Write-Output "$Path\$Name"
    }
}#END Function
Function Write-log {
    #.ExternalHelp JDTools.Help.xml
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $false,Position = 0)]
            [string]$Message,
        [Parameter(Mandatory = $false,Position = 1)]
            [string]$Module = 'JDTools',
        [Parameter(Mandatory = $false,Position = 2,HelpMessage='Please use .log in the end of the file name')]
            [string]$Path = $(Get-LogFilePath -Module $Module),
        [Parameter(Mandatory = $false,Position = 3)]
            [ValidateSet('SUCCESS','OPERATION','WARNING','ERROR')]
            [string]$MessageType,
        [Parameter(Mandatory = $false,Position = 4)]
            [switch]$WriteBegin,
        [Parameter(Mandatory = $false,Position = 5)]
            [switch]$WriteEnd,
        [Parameter(Mandatory = $false,Position = 6)]
            [switch]$WriteDate
    )
    begin {
        if (-not (Test-Path $Path)) {
            New-LogFile -Module $Module | Out-null
        }
    }
    process {        
        if ($PSBoundParameters['WriteBegin']) {
            Add-Content ' --- START --- --- --- --- --- --- --- --- --- ' -Path $Path
        }
        if ($PSBoundParameters['MessageType']) {
            if ($MessageType -eq 'SUCCESS'){$Type = 'SUCCESS: '}
            if ($MessageType -eq 'OPERATION'){$Type = 'OPERATION: '}
            if ($MessageType -eq 'WARNING'){$Type = 'WARNING: '}
            if ($MessageType -eq 'ERROR'){$Type = 'ERROR: '}
        }
        if ($PSBoundParameters['WriteDate']) {
            $Date = Get-Date -UFormat '%Y-%m-%d %T '
        }
        Add-Content "$Date$Type$Message" -Path $Path
        if ($PSBoundParameters['WriteEnd']) {
            Add-Content ' ---  END  --- --- --- --- --- --- --- --- --- ' -Path $Path
        }
    }
}#END Function
Function Invoke-LogsRotation {
    #.ExternalHelp JDTools.Help.xml
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$false)]
        [string]$LogDir = $script:JDToolsModuleConfig.Configuration.Logs.LogsFolder,
        [Parameter(ValueFromPipeline=$false)]
        [int]$DayOfWeek = 2,
        [Parameter(ValueFromPipeline=$false)]
        [int]$DayOfMonth = 1,
        [Parameter(ValueFromPipeline=$false)]
        [int]$RotationDaily = 7,
        [Parameter(ValueFromPipeline=$false)]
        [int]$RotationWeekly = 6,
        [Parameter(ValueFromPipeline=$false)]
        [int]$RotationMonthly = 5
    )
    begin {
        if (-not (Test-Path $LogDir)) {
            Write-Warning "Folder $LogDir does not exist."
            Break
        }
    }
    process {
        # Get all log files in the directory
        $logFiles = Get-ChildItem -Path $LogDir -File

        # Daily rotation
        $dailyFiles = $logFiles | Sort-Object LastWriteTime -Descending
        if ($dailyFiles.Count -gt $RotationDaily) {
            $dailyFiles[$RotationDaily..($dailyFiles.Count - 1)] | Remove-Item -Force
        }

        # Weekly rotation
        $weeklyFiles = $logFiles | Where-Object {
            $_.LastWriteTime.DayOfWeek -eq $DayOfWeek
        } | Sort-Object LastWriteTime -Descending
        if ($weeklyFiles.Count -gt $RotationWeekly) {
            $weeklyFiles[$RotationWeekly..($weeklyFiles.Count - 1)] | Remove-Item -Force
        }

        # Monthly rotation
        $monthlyFiles = $logFiles | Where-Object {
            $_.LastWriteTime.Day -eq $DayOfMonth
        } | Sort-Object LastWriteTime -Descending
        if ($monthlyFiles.Count -gt $RotationMonthly) {
            $monthlyFiles[$RotationMonthly..($monthlyFiles.Count - 1)] | Remove-Item -Force
        }

        Write-Verbose "Log rotation completed successfully for directory $LogDir."
    }#END Process
}#END Function
Function New-TempLogs {
    #.ExternalHelp JDTools.Help.xml
    [CmdletBinding()]
    Param (
        [string]$Path = $script:JDToolsModuleConfig.Configuration.Logs.LogsFolder,
        [string]$Name = $($script:JDToolsModuleConfig.Configuration.Logs.LogFileName.split('.')[0] + '-'+ 
        (Invoke-Expression $script:JDToolsModuleConfig.Configuration.Logs.LogFileDate) + '.'+ 
        $script:JDToolsModuleConfig.Configuration.Logs.LogFileName.split('.')[1]),
        [int]$NumberOfDays = 30
    )
    process {
        for ($i = 1; $i -le $NumberOfDays; $i++) { 
            $Date = (Get-Date).AddDays(-$i) 
            $Name_Part = Get-Date -Date $Date -UFormat '%Y-%m-%d'
            if ( $Name -ne $JD_LogFileName ) {
                $LogFileName = $Name -replace '\.log',"-$($Name_Part).log"
            } else {
                $LogFileName = "logfile-$Name_Part.log"
            }            
            if ( -not (Test-Path "$Path")) {
                New-Item -Path $Path -ItemType file -Name $LogFileName
            }
            if ( -not (Test-Path "$Path\$LogFileName")) {
                New-Item -Path $Path -ItemType file -Name $LogFileName
            }
            Write-Debug -Message 'Debuging'
            (Get-Item -Path ("$Path\$LogFileName")).CreationTime = $Date
            (Get-Item -Path ("$Path\$LogFileName")).LastWriteTime = $Date
        }
    }
}#END Function
Function New-LogFile {
    #.ExternalHelp JDTools.Help.xml
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false,Position = 1)]
        [string]$Module = 'JDTools',
        [Parameter(Mandatory = $false,Position = 2,HelpMessage='Please use .log in the end of the file name')]
        [string]$Path = $(Get-LogFilePath -Module $Module)
    )
    process {
        New-Item -Path $Path -Force
    }    
}#END Function
function New-JDModuleFolder {
    #.ExternalHelp JDTools.Help.xml
    [CmdletBinding()]
    [OutputType()]
    Param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [string]$ModuleName,
        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [string]$Path,
        [ValidateSet('en-US','fr-FR','de-DE','es-ES','it-IT','ja-JP','ko-KR','pt-BR','ru-RU','zh-CN','zh-TW')]
        [string]$LanguageCode = 'en-US'
    )
    process {
        if ( -not (Test-Path -Path "$Path\$ModuleName") ) {
            Write-Verbose -Message "Creating $Path\$ModuleName"
            New-item -ItemType directory -Path "$Path\$ModuleName" -Force | Out-null
        }
        if ( -not (Test-Path "$Path\$ModuleName\$LanguageCode") ) {
            New-item -ItemType directory -Path "$Path\$ModuleName\$LanguageCode" -Force | Out-null
            if ( -not (Test-Path "$Path\$ModuleName\$LanguageCode\$ModuleName.Help.xml") ) {
                New-Item -itemtype file -Path "$Path\$ModuleName\$LanguageCode\$ModuleName.Help.xml"
            }
        }
        if ( -not (Test-Path "$Path\$ModuleName\docs") ) {
            New-item -ItemType directory -Path "$Path\$ModuleName\docs" -Force | Out-null
        }
        if ( -not (Test-Path "$Path\$ModuleName\$ModuleName.psm1") ) {
            New-Item -itemtype file -Path "$Path\$ModuleName\$ModuleName.psm1"
        }
        if ( -not (Test-Path "$Path\$ModuleName\$ModuleName.psd1") ) {
            New-Item -itemtype file -Path "$Path\$ModuleName\$ModuleName.psd1"
            #TODO Generate new module manifest.
        }
    }
}#END Function
function Write-EventLogEntry {
    #.ExternalHelp JDTools.Help.xml
    param (
        [string]$LogName = "JDToolsLog",
        [string]$Source = "JDTools",
        [string]$EntryType = "Information", # Can be Information, Warning, Error
        [string]$Message
    )

    # Function to check if the script is running with elevated privileges
    function Test-IsAdmin {
        $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
        return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    }

    # Check if the source exists, if not create it
    if (-not [System.Diagnostics.EventLog]::SourceExists($Source)) {
        if (Test-IsAdmin) {
            [System.Diagnostics.EventLog]::CreateEventSource($Source, $LogName)
        } else {
            throw "Creating an event source requires administrative privileges. Please run this script as an administrator."
        }
    }
    # Write the entry to the event log
    Write-EventLog -LogName $LogName -Source $Source -EntryType $EntryType -EventId 1 -Message $Message
}
Export-ModuleMember -Function 'Import-ModuleConfig',
'New-LogFile',
'New-TempLogs',
'Write-log', 
'Invoke-LogsRotation',  
'New-JDModuleFolder',
'Get-LogFilePath',
'Get-LogFile',
'Get-LogFileName',
'Write-EventLogEntry'