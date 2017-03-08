#$Arrcomp = net view | select -Skip 6 | %{$_ -match '^\\\\([^\t ]*)'|out-null;$matches[1]}
#Clear-Host
#$Arrcomp = $Arrcomp.Split("`n")

#The part above this text is used to check for all computers on the net but it doesn't work

$ArrComputers = "."
#This part chooses what computer you're gonna check the info from. "." is the local computer

Clear-Host
foreach ($Computer in $Arrcomputers) 
{
    #This part fetches the information through wmiobject that is located on the computer and puts it in arrays
    
    $computerSystem = get-wmiobject Win32_ComputerSystem -Computer $Computer
    $computerBIOS = get-wmiobject Win32_BIOS -Computer $Computer
    $computerOS = get-wmiobject Win32_OperatingSystem -Computer $Computer
    $computerCPU = get-wmiobject Win32_Processor -Computer $Computer
    $computerHDD = Get-WmiObject Win32_LogicalDisk -ComputerName $Computer -Filter drivetype=3
        
        #All of the parts below writes out the information it got for you with the use of the arrays used on top
        
        ""
        write-host "System Information for: " $computerSystem.Name -BackgroundColor DarkCyan
        "_______________________________________________________"
        ""
        "Manufacturer: " + $computerSystem.Manufacturer
        "Model: " + $computerSystem.Model
        "Serial Number: " + $computerBIOS.SerialNumber
        "CPU: " + $computerCPU.Name
        "HDD Capacity: "  + "{0:N2}" -f ($computerHDD.Size/1GB) + "GB"
        "HDD Space: " + "{0:P2}" -f ($computerHDD.FreeSpace/$computerHDD.Size) + " Free (" + "{0:N2}" -f ($computerHDD.FreeSpace/1GB) + "GB)"
        "RAM: " + "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB) + "GB"
        "Operating System: " + $computerOS.caption + ", Service Pack: " + $computerOS.ServicePackMajorVersion
        "User logged In: " + $computerSystem.UserName
        "Last Reboot: " + $computerOS.ConvertToDateTime($computerOS.LastBootUpTime)
        ""
        "_______________________________________________________"
}