function Log-MACAddress {
    # Prompt user for the name to be saved
    $name = Read-Host -Prompt "Enter the PC owner name, please"

    # Get the current date
    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Define the path for the CSV file
    $csvPath = "mac.csv"

    # Check if the CSV file exists, if not, create a new one with headers
    if (-not (Test-Path $csvPath)) {
        "Date,Name,MAC,First_Time,Interface,Ping 1.1.1.1" | Out-File -FilePath $csvPath -Encoding utf8
    }

    # Get all network adapters and loop through each one
    $networkAdapters = Get-NetAdapter
    foreach ($adapter in $networkAdapters) {
        # Get the MAC address and interface description
        $macAddress = $adapter.MacAddress
        $interface = $adapter.InterfaceDescription

        # Check if MAC address has appeared before
        $firstTime = "Yes"
        $existingMacAddresses = Import-Csv $csvPath | Select-Object -ExpandProperty MAC
        if ($existingMacAddresses -contains $macAddress) {
            $firstTime = "No"
        }

        # Perform ping test
        $pingResult = "Failed"
        if (Test-Connection -ComputerName 1.1.1.1 -Count 3 -Quiet) {
            $pingResult = "Success"
        }

        # Append the data to the CSV file
        "$date,$name,$macAddress,$firstTime,$interface,$pingResult" | Out-File -FilePath $csvPath -Encoding utf8 -Append
    }

    Write-Host "Script finished"
}

Log-MACAddress

