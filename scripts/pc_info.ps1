# Define a hashtable of WMI classes and their display names
$WMI_Classes = @{
    "Win32_Processor"       = "CPU"
    "Win32_VideoController" = "GPU"
    "Win32_PhysicalMemory"  = "RAM"
    "Win32_DiskDrive"       = "Disk"
    "Win32_BIOS"            = "BIOS"
}

# Loop through each key-value pair in the hashtable
foreach ($class in $WMI_Classes.Keys) {
    # Get information for the current WMI class
    $Info = Get-WmiObject -Class $class

    # Output the class name
    Write-Output "$($WMI_Classes[$class]):"

    # Output the information
    $Info
}
