# Get CPU information
$CPU = Get-WmiObject -Class Win32_Processor

# Get GPU information
$GPU = Get-WmiObject -Class Win32_VideoController

# Get RAM information
$RAM = Get-WmiObject -Class Win32_PhysicalMemory

# Get disk information
$Disk = Get-WmiObject -Class Win32_DiskDrive

# Get BIOS information
$BIOS = Get-CimInstance -ClassName Win32_BIOS

# Output the gathered information
Write-Output "CPU:"
$CPU
Write-Output "GPU:"
$GPU
Write-Output "RAM:"
$RAM
Write-Output "Disk:"
$Disk
Write-Output "BIOS:"
$BIOS
