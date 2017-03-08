function Get-ComputerInfo
{
    [CmdletBinding()]
    Param
    (
        [Parameter()]
        [string[]]$ArrComputers = "."
    )

    Begin
    { 
        $cim = New-CimSession -ComputerName $ArrComputers
    }
    Process
    {
       
        
        $computerBIOS   = Get-CimInstance -CimSession $cim -ClassName Win32_BIOS -Property 'SerialNumber'
        $computerSystem = Get-CimInstance -CimSession $cim -ClassName Win32_ComputerSystem -Property 'Manufacturer','Model','TotalPhysicalMemory','UserName'
        $computerOS     = Get-CimInstance -CimSession $cim -ClassName Win32_OperatingSystem -Property 'caption','LastBootUpTime'
        $computerCPU    = Get-CimInstance -CimSession $cim -ClassName Win32_Processor -Property 'Name'
        $computerHDD    = Get-CimInstance -CimSession $cim -ClassName Win32_LogicalDisk -Property 'Size','FreeSpace'
        
        
        foreach ($computer in $ArrComputers)
        {
            $BIOS   = $computerBIOS  | Where-Object -Property PScomputername -EQ $computer
            $System = $computerSystem| Where-Object -Property PScomputername -EQ $computer
            $OS     = $computerOS    | Where-Object -Property PScomputername -EQ $computer
            $CPU    = $computerCPU   | Where-Object -Property PScomputername -EQ $computer
            $HDD    = $computerHDD   | Where-Object -Property PScomputername -EQ $computer
            
            New-Object -TypeName psobject -Property @{
                'computer'        = $computer
                'Manufacturer'    = $System.Manufacturer
                'Model'           = $System.Model
                'Serial_Number'   = $BIOS.SerialNumber
                'CPU'             = $CPU.Name
                'HDD_Capacity'    = $HDD.Size
                'HDD_Space'       = $HDD.FreeSpace
                'RAM'             = $System.TotalPhysicalMemory
                'Operating System'= "$($OS.caption) $($OS.ServicePackMajorVersion)"
                'User_logged'     = $System.UserName
                'Last_Reboot'     = $OS.LastBootUpTime
            }
        }

    }
    End
    {
        $cim | Remove-CimSession
    }
}
