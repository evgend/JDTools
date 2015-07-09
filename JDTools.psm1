$JD_LogsFolder = "$env:SystemDrive\Logs"
$JD_LogFileName = "logfile-$(Get-Date -UFormat '%Y-%m-%d').log"

Function Write-log
{
    [cmdletbinding()]
        Param(
            [Parameter(Mandatory = $false,Position = 0)]
                [string]$Message,
                        
            [Parameter(Mandatory = $false,Position = 1,HelpMessage='Используйте окончание файла - .log')]
                [ValidatePattern(".log$")]
                [string]$Path = "$JD_LogsFolder",

            [Parameter(Mandatory = $false,Position = 2)]
                [string]$Name = "$JD_LogFileName",
                        
            [Parameter(Mandatory = $false,Position = 2)]
                [ValidateSet('SUCCESS','OPERATION','WARNING','ERROR')]
                [string]$MessageType,
                        
            [Parameter(Mandatory = $false,Position = 3)]
                [switch]$WriteBegin,
                        
            [Parameter(Mandatory = $false,Position = 4)]
                [switch]$WriteEnd,
            
            [Parameter(Mandatory = $false,Position = 5)]
                [switch]$WriteDate
        )
    PROCESS
    {        
        if ($PSBoundParameters['WriteBegin'])
        {
            Add-Content ' --- START --- --- --- --- --- --- --- --- --- ' -Path "$Path\$Name"
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

        Add-Content "$Date$Type$Message" -Path "$Path\$Name"
            
        if ($PSBoundParameters['WriteEnd'])
        {
            Add-Content ' ---  END  --- --- --- --- --- --- --- --- --- ' -Path "$Path\$Name"
        }
    }
}

Function Invoke-LogsRotation
{
     [cmdletbinding()]
        Param(
            [Parameter(ValueFromPipeline=$false)]
    		    [string]$LogDir = $JD_LogsFolder, # Directory log files are written to

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
     [cmdletbinding()]
        Param(
            [string]$Path = $JD_LogsFolder,
            [string]$Name = $JD_LogFileName,
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
            $Path = $JD_LogsFolder,
            $Name = $JD_LogFileName
        )
    $Param = @{Path = $Path;Name = $Name}
    
    if ( -not (ValidatePath @Param).FolderPathExists )
    {
        New-Item -Path $Path -ItemType 'directory' 
    }
    
    if ( -not (ValidatePath @Param).FileExists -and (ValidatePath @Param).FolderPathExists)
    {
        New-Item @Param -ItemType 'file'
    }
}

Function Get-LogFileName
{
     [cmdletbinding()]
        Param(
            $Path = $JD_LogsFolder,
            $Name = $JD_LogFileName
        )
    Get-Item "$Path\$Name" -ErrorAction stop
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
        [parameter(Mandatory = $true)][string]$name
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
# New-JDModuleFolder -ModuleName 'JDADReporting' -Path "J:\"
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

function Get-ProductKey {
     <#   
    .SYNOPSIS   
        Retrieves the product key and OS information from a local or remote system/s.
         
    .DESCRIPTION   
        Retrieves the product key and OS information from a local or remote system/s. Queries of 64bit OS from a 32bit OS will result in 
        inaccurate data being returned for the Product Key. You must query a 64bit OS from a system running a 64bit OS.
        
    .PARAMETER Computername
        Name of the local or remote system/s.
         
    .NOTES   
        Author: Boe Prox
        Version: 1.1       
            -Update of function from http://powershell.com/cs/blogs/tips/archive/2012/04/30/getting-windows-product-key.aspx
            -Added capability to query more than one system
            -Supports remote system query
            -Supports querying 64bit OSes
            -Shows OS description and Version in output object
            -Error Handling
     
    .EXAMPLE 
     Get-ProductKey -Computername Server1
     
    OSDescription                                           Computername OSVersion ProductKey                   
    -------------                                           ------------ --------- ----------                   
    Microsoft(R) Windows(R) Server 2003, Enterprise Edition Server1       5.2.3790  bcdfg-hjklm-pqrtt-vwxyy-12345     
         
        Description 
        ----------- 
        Retrieves the product key information from 'Server1'
    #>         
    [cmdletbinding()]
    Param (
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
        [Alias("CN","__Server","IPAddress","Server")]
        [string[]]$Computername = $Env:Computername
    )
    Begin {   
        $map="BCDFGHJKMPQRTVWXY2346789" 
    }
    Process {
        ForEach ($Computer in $Computername) {
            Write-Verbose ("{0}: Checking network availability" -f $Computer)
            If (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
                Try {
                    Write-Verbose ("{0}: Retrieving WMI OS information" -f $Computer)
                    $OS = Get-WmiObject -ComputerName $Computer Win32_OperatingSystem -ErrorAction Stop                
                } Catch {
                    $OS = New-Object PSObject -Property @{
                        Caption = $_.Exception.Message
                        Version = $_.Exception.Message
                    }
                }
                Try {
                    Write-Verbose ("{0}: Attempting remote registry access" -f $Computer)
                    $remoteReg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,$Computer)
                    If ($OS.OSArchitecture -eq '64-bit') {
                        $value = $remoteReg.OpenSubKey("SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('DigitalProductId4')[0x34..0x42]
                    } Else {                        
                        $value = $remoteReg.OpenSubKey("SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('DigitalProductId')[0x34..0x42]
                    }
                    $ProductKey = ""  
                    Write-Verbose ("{0}: Translating data into product key" -f $Computer)
                    for ($i = 24; $i -ge 0; $i--) { 
                      $r = 0 
                      for ($j = 14; $j -ge 0; $j--) { 
                        $r = ($r * 256) -bxor $value[$j] 
                        $value[$j] = [math]::Floor([double]($r/24)) 
                        $r = $r % 24 
                      } 
                      $ProductKey = $map[$r] + $ProductKey 
                      if (($i % 5) -eq 0 -and $i -ne 0) { 
                        $ProductKey = "-" + $ProductKey 
                      } 
                    }
                } Catch {
                    $ProductKey = $_.Exception.Message
                }        
                $object = New-Object PSObject -Property @{
                    Computername = $Computer
                    ProductKey = $ProductKey
                    OSDescription = $os.Caption
                    OSVersion = $os.Version
                } 
                $object.pstypenames.insert(0,'ProductKey.Info')
                $object
            } Else {
                $object = New-Object PSObject -Property @{
                    Computername = $Computer
                    ProductKey = 'Unreachable'
                    OSDescription = 'Unreachable'
                    OSVersion = 'Unreachable'
                }  
                $object.pstypenames.insert(0,'ProductKey.Info')
                $object                           
            }
        }
    }
} 
Export-ModuleMember -Function Get-LogFileName, New-LogFile, New-TempLogs, Write-log, Invoke-LogsRotation, Get-LogFile, Load-Module, New-JDModuleFolder, Get-ProductKey -Variable JD_LogsFolder, JD_LogFileName