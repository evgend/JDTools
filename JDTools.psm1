function Import-ModuleConfig
{
    #.ExternalHelp JDTools.Help.xml
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Module
    )
    
    process
    {
        try
        {
            $ModuleBase = Get-Module -Name $Module -ListAvailable -ErrorAction Stop | Select-Object -ExpandProperty ModuleBase
        }
        catch
        {
            # Error handling
            [Management.Automation.ErrorRecord]$e = $_
            $Message = "`nException`t: $($e.Exception.Message)`nReason`t`t: $($e.CategoryInfo.Reason)`nTarget`t`t: $($e.CategoryInfo.TargetName)`nScript`t`t: $($e.InvocationInfo.ScriptName)`nLine`t`t: $($e.InvocationInfo.ScriptLineNumber)`nColumn`t`t: $($e.InvocationInfo.OffsetInLine)"
			Write-Warning -Message $Message
            Break
        }
        finally
        {
            $ModuleConfigPath = "$($ModuleBase)\Config.xml"
            if (Test-Path $ModuleConfigPath)
            {
                Write-Output (Get-Content -Path $ModuleConfigPath)
            }
            else
            {
                $Message = "Configuration file: $ModuleConfigPath not found"
                Write-Warning -Message $Message
            }
        }
    }
}
#[xml]$script:JDToolsModuleConfig = Import-ModuleConfig -Module 'JDTools'

Function Get-LogFile
{
    [cmdletbinding()]
    Param(
        [string]$Module = 'JDTools'
    )
    BEGIN
    {
        $Path = Get-LogFilePath -Module $Module
    }
    PROCESS
    {
        Get-Item "$Path" -ErrorAction stop
    }
}
Function Get-LogFileName
{
     [cmdletbinding()]
        Param(
            $Path = $script:JDToolsModuleConfig.Configuration.Logs.LogsFolder,
            $Name = $($script:JDToolsModuleConfig.Configuration.Logs.LogFileName.split('.')[0] + '-'+ 
            (Invoke-Expression $script:JDToolsModuleConfig.Configuration.Logs.LogFileDate) + '.'+ 
            $script:JDToolsModuleConfig.Configuration.Logs.LogFileName.split('.')[1])
        )
    Get-Item "$Path\$Name" -ErrorAction stop
}
# Module config
# Get Module Config for log files.
# <LogsFolder>C:\Logs</LogsFolder>
# <LogFileName>logfile.log</LogFileName>
# <LogFileDate>Get-Date -UFormat '%Y-%m-%d'</LogFileDate>
# <LoggingEnabled>$True</LoggingEnabled>
Function Get-LogFilePath
{
     [cmdletbinding()]
        Param(
            [string]$Module = 'JDTools'
        )
    BEGIN
    {
        Write-Debug -Message "Test"
        if ($Module -eq 'JDTools')
        {
            [xml]$ModuleConfig = Import-ModuleConfig -Module 'JDTools'
        }
        else
        {
            [xml]$ModuleConfig = Import-ModuleConfig -Module $Module
        }
        $Path = $ModuleConfig.Configuration.Logs.LogsFolder
        $Name = $( $ModuleConfig.Configuration.Logs.LogFileName.split('.')[0] + '-'+ 
            (Invoke-Expression  $ModuleConfig.Configuration.Logs.LogFileDate) + '.'+ 
            $ModuleConfig.Configuration.Logs.LogFileName.split('.')[1])

    }
    PROCESS
    {
        Write-Output "$Path\$Name"
    }
    END
    {

    }
}
Function Write-log
{
    [cmdletbinding()]
        Param(
            [Parameter(Mandatory = $false,Position = 0)]
                [string]$Message,

            [Parameter(Mandatory = $false,Position = 1)]
                [string]$Module = 'JDTools',
          
            [Parameter(Mandatory = $false,Position = 2,HelpMessage='Please use .log in the end of the file name')]
                [string]$Path = $(Get-LogFilePath -Module $Module),

            #[Parameter(Mandatory = $false,Position = 2)]
            #[ValidatePattern(".log$")]
            #    [string]$Name = $($script:JDToolsModuleConfig.Configuration.Logs.LogFileName.split('.')[0] + '-'+ 
            #    (Invoke-Expression $script:JDToolsModuleConfig.Configuration.Logs.LogFileDate) + '.'+ 
            #    $script:JDToolsModuleConfig.Configuration.Logs.LogFileName.split('.')[1]),
                        
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
    BEGIN
    {
        if (-not (Test-Path $Path))
        {
            New-LogFile -Module $Module | Out-null
        }
    }
    PROCESS
    {        
        if ($PSBoundParameters['WriteBegin'])
        {
            Add-Content ' --- START --- --- --- --- --- --- --- --- --- ' -Path $Path
        }
            
        if ($PSBoundParameters['MessageType'])
        {
            if ($MessageType -eq 'SUCCESS'){$Type = 'SUCCESS: '}
            if ($MessageType -eq 'OPERATION'){$Type = 'OPERATION: '}
            if ($MessageType -eq 'WARNING'){$Type = 'WARNING: '}
            if ($MessageType -eq 'ERROR'){$Type = 'ERROR: '}
        }
    
        if ($PSBoundParameters['WriteDate'])
        {
            $Date = Get-Date -UFormat '%Y-%m-%d %T '
        }

        Add-Content "$Date$Type$Message" -Path $Path
            
        if ($PSBoundParameters['WriteEnd'])
        {
            Add-Content ' ---  END  --- --- --- --- --- --- --- --- --- ' -Path $Path
        }
    }
}
Function Invoke-LogsRotation
{
    #.ExternalHelp JDTools.Help.xml

     [CmdletBinding()]
        Param(
            [Parameter(ValueFromPipeline=$false)]
    		    [string]$LogDir = $script:JDToolsModuleConfig.Configuration.Logs.LogsFolder, # Directory log files are written to

		    [Parameter(ValueFromPipeline=$false)]
		    [int]$DayOfWeek = 2, # The day of the week to store for weekly files (1 to 7 where 1 is Sunday)
		    [Parameter(ValueFromPipeline=$false)]
		    [int]$DayOfMonth = 1, # The day of the month to store for monthly files (Max = 28 since varying last day of month not currently handled)
		    [Parameter(ValueFromPipeline=$false)]
		    [int]$RotationDaily = 7, # The number of daily files to keep
		    [Parameter(ValueFromPipeline=$false)]
		    [int]$RotationWeekly = 6, # The number of weekly files to keep
		    [Parameter(ValueFromPipeline=$false)]
		    [int]$RotationMonthly = 5 # The number of monthly files to keep
        )
        BEGIN
        {
            if ( -not (Test-Path $LogDir) )
            {
                Write-Warning "Folder $LogDir dose not exists."
                Break
            }
        }
        PROCESS
        {
            
        }
}

Function New-TempLogs
{
    #.ExternalHelp JDTools.Help.xml
     [CmdletBinding()]
        Param(
            [string]$Path = $script:JDToolsModuleConfig.Configuration.Logs.LogsFolder,

            [string]$Name = $($script:JDToolsModuleConfig.Configuration.Logs.LogFileName.split('.')[0] + '-'+ 
            (Invoke-Expression $script:JDToolsModuleConfig.Configuration.Logs.LogFileDate) + '.'+ 
            $script:JDToolsModuleConfig.Configuration.Logs.LogFileName.split('.')[1]),

            [int]$NumberOfDays = 30
        )
    PROCESS
    {
        for ($i = 1; $i -le $NumberOfDays; $i++)
        { 
            $Date = (Get-Date).AddDays(-$i) 
            $Name_Part = Get-Date -Date $Date -UFormat '%Y-%m-%d'

            if ( $Name -ne $JD_LogFileName )
            {
                $LogFileName = $Name -replace '\.log',"-$($Name_Part).log"
            }
            else
            {
                $LogFileName = "logfile-$Name_Part.log"
            }
            
            if ( -not (Test-Path "$Path"))
            {
                New-Item -Path $Path -ItemType file -Name $LogFileName
            }

            if ( -not (Test-Path "$Path\$LogFileName"))
            {
                New-Item -Path $Path -ItemType file -Name $LogFileName
            }
            Write-Debug -Message 'Debuging'
            (Get-Item -Path ("$Path\$LogFileName")).CreationTime = $Date
            (Get-Item -Path ("$Path\$LogFileName")).LastWriteTime = $Date
        }
    }
}

Function New-LogFile
{
     [cmdletbinding()]
        Param(
            [Parameter(Mandatory = $false,Position = 1)]
            [string]$Module = 'JDTools',
      
        [Parameter(Mandatory = $false,Position = 2,HelpMessage='Please use .log in the end of the file name')]
            [string]$Path = $(Get-LogFilePath -Module $Module)

        )
    PROCESS
    {
        New-Item -Path $Path -Force
    }    
}

Function ValidatePath ([Parameter(Mandatory = $true)]$Path,
                       [Parameter(Mandatory = $true)]$Name)
{
    if ( -not (Test-Path -Path "$Path"))
    {
        $FolderPathExists = $false
    }
    elseif ( Test-Path -Path "$Path" )
    {
        $FolderPathExists = $true
    }

    if ( -not (Test-Path -Path "$Path\$Name"))
    {
        $FileExists = $false
    }
    elseif ( Test-Path -Path "$Path\$Name" )
    {
        $FileExists = $true
    }

    $param =@{FolderPathExists=$FolderPathExists ;FileExists = $FileExists}

    Write-Output $param
}

function Load-Module
{
    param (
        [parameter(Mandatory = $true)]
        [string]$name
    )

    $retVal = $true

    if (-not (Get-Module -Name $name))
    {
        $retVal = Get-Module -ListAvailable | Where-Object { $_.Name -eq $name }

        if ($retVal)
        {
            try
            {
                Import-Module $name -ErrorAction SilentlyContinue
            }

            catch
            {
                $retVal = $false
            }
        }
    }

    return $retVal
}# function end

function New-JDModuleFolder 
{
#.ExternalHelp JDTools.Help.xml
    [CmdletBinding()]
    [OutputType()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
	    [string]$ModuleName,

        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
	    [string]$Path
    )
        if ( -not (Test-Path -Path "$Path\$ModuleName") )
        {
            Write-Verbose -Message "Создаем $Path\$ModuleName"
            New-item -ItemType directory -Path "$Path\$ModuleName" -Force | Out-null
        }
        if ( -not (Test-Path "$Path\$ModuleName\en-US") )
        {
            New-item -ItemType directory -Path "$Path\$ModuleName\en-US" -Force | Out-null
            if ( -not (Test-Path "$Path\$ModuleName\en-US\$ModuleName.Help.xml") )
            {
                New-Item -itemtype file -Path "$Path\$ModuleName\en-US\$ModuleName.Help.xml"
            }
        }
        if ( -not (Test-Path "$Path\$ModuleName\ru-RU") )
        {
            New-item -ItemType directory -Path "$Path\$ModuleName\ru-RU" -Force | Out-null
            if ( -not (Test-Path "$Path\$ModuleName\ru-RU\$ModuleName.Help.xml") )
            {
                New-Item -itemtype file -Path "$Path\$ModuleName\ru-RU\$ModuleName.Help.xml"
            }
        }
        if ( -not (Test-Path "$Path\$ModuleName\uk-UA") )
        {
            New-item -ItemType directory -Path "$Path\$ModuleName\uk-UA" -Force | Out-null
            if ( -not (Test-Path "$Path\$ModuleName\uk-UA\$ModuleName.Help.xml") )
            {
                New-Item -itemtype file -Path "$Path\$ModuleName\uk-UA\$ModuleName.Help.xml"
            }
        }
        if ( -not (Test-Path "$Path\$ModuleName\$ModuleName.psm1") )
        {
            New-Item -itemtype file -Path "$Path\$ModuleName\$ModuleName.psm1"
        }
        if ( -not (Test-Path "$Path\$ModuleName\$ModuleName.psd1") )
        {
            New-Item -itemtype file -Path "$Path\$ModuleName\$ModuleName.psd1"
        }
}

<<<<<<< HEAD
Export-ModuleMember -Function 
Get-LogFileName,
New-LogFile,
New-TempLogs,
Write-log, 
Invoke-LogsRotation, 
Get-LogFile,
Load-Module, 
New-JDModuleFolder -Variable JD_LogsFolder, JD_LogFileName
=======
Export-ModuleMember -Function 'Import-ModuleConfig',
'New-LogFile',
'New-TempLogs',
'Write-log', 
'Invoke-LogsRotation', 
'Load-Module', 
'New-JDModuleFolder',
'Get-LogFilePath',
'Get-LogFile',
'Get-LogFileName' #-Variable JD_LogsFolder, JD_LogFileName
>>>>>>> feature/AddNewFunctionality
