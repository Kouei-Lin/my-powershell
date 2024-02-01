function Get-DiskUsage {
    # Get current date and time
    $CurrentDateTime = Get-Date -Format "MM/dd/yyyy HH:mm:ss"

    # Get disk usage information for all drives
    $diskUsage = Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, VolumeName, @{Name="Size(GB)"; Expression={[math]::Round($_.Size / 1GB, 2)}}, @{Name="FreeSpace(GB)"; Expression={[math]::Round($_.FreeSpace / 1GB, 2)}}, @{Name="UsedSpace(GB)"; Expression={[math]::Round(($_.Size - $_.FreeSpace) / 1GB, 2)}}

    # Define CSV file path
    $csvFilePath = "disk_usage.csv"

    # Output disk usage information to CSV file
    $diskUsage | Select-Object @{Name="Date"; Expression={$CurrentDateTime}}, DeviceID, VolumeName, "Size(GB)", "FreeSpace(GB)", "UsedSpace(GB)" | Export-Csv -Path $csvFilePath -Append -NoTypeInformation

    Write-Host "Disk usage information has been appended to $csvFilePath"
}

# Invoke the function
Get-DiskUsage

