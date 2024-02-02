function Get-DiskUsage {
    # Get current date and time
    $CurrentDateTime = Get-Date -Format "MM/dd/yyyy HH:mm:ss"

    # Get disk usage information for all drives
    $diskUsage = Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, VolumeName, @{Name="Size(GB)"; Expression={[math]::Round($_.Size / 1GB, 2)}}, @{Name="FreeSpace(GB)"; Expression={[math]::Round($_.FreeSpace / 1GB, 2)}}, @{Name="UsedSpace(GB)"; Expression={[math]::Round(($_.Size - $_.FreeSpace) / 1GB, 2)}}

    # Output disk usage information to console
    $diskUsage | Format-Table -Property @{Name="Date"; Expression={$CurrentDateTime}}, DeviceID, VolumeName, "Size(GB)", "FreeSpace(GB)", "UsedSpace(GB)" -AutoSize

    Write-Host "Disk usage information has been displayed"
}

# Invoke the function
Get-DiskUsage

