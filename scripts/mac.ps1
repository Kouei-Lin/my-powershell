function Log-MACAddress {
    # Prompt user for the name to be saved
    $name = Read-Host -Prompt "Enter the PC owner name pls"

    # Get the current date
    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Define the path for the CSV file
    $csvPath = "mac.csv"

    # Check if the CSV file exists, if not, create a new one with headers
    if (-not (Test-Path $csvPath)) {
        "Date,Name,MAC,Interface" | Out-File -FilePath $csvPath -Encoding utf8
    }

    # Get all network adapters and loop through each one
    $networkAdapters = Get-NetAdapter
    foreach ($adapter in $networkAdapters) {
        # Get the MAC address and interface description
        $macAddress = $adapter.MacAddress
        $interface = $adapter.InterfaceDescription

        # Append the data to the CSV file
        "$date,$name,$macAddress,$interface" | Out-File -FilePath $csvPath -Encoding utf8 -Append
    }

    Write-Host "Script finished"
}

Log-MACAddress

