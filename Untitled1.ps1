$ArrComputers = "."
#This part chooses what computer you're gonna check the info from. "." is the local computer

$cim = New-CimSession -ComputerName $ArrComputers

$computerBIOS   = Get-CimInstance -CimSession $cim -ClassName Win32_BIOS
$computerSystem = Get-CimInstance -CimSession $cim -ClassName Win32_ComputerSystem
$computerOS     = Get-CimInstance -CimSession $cim -ClassName Win32_OperatingSystem
$computerCPU    = Get-CimInstance -CimSession $cim -ClassName Win32_Processor
$computerHDD    = Get-CimInstance -CimSession $cim -ClassName Win32_LogicalDisk
Get-CimSession | Remove-CimSession

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
