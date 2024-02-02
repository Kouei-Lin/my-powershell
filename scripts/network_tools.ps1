# Function to perform ARP scan
function Invoke-ARPScan {
    # Define the current date and time
    $CurrentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"

    # Define the output file name using the current date and time
    $outputFileName = "arp_results_$CurrentDateTime.txt"

    # Run the ARP command to scan the specified range
    $arpOutput = arp -a

    # Write the ARP scan results to the output file
    $arpOutput | Out-File -FilePath $outputFileName

    # Inform the user about the completion and the file location
    Write-Host "ARP scan results have been saved to $outputFileName"
}

# Function to get current DNS servers
function Get-DefaultDNS {
    $dnsServers = Get-DnsClientServerAddress -AddressFamily "IPv4" | Where-Object { $_.ServerAddresses -ne $null }
    Write-Host "Current DNS Servers:"
    $dnsServers
}

# Function to test domain availability
function Domain-Resolve {
    # Define an array of popular domain names to check
    $domains = @(
        "google.com",
        "skype.com"
        # Add more domains as needed
    )

    # Loop through each domain
    foreach ($domain in $domains) {
        # Attempt to resolve the domain name
        $result = Resolve-DnsName -Name $domain -ErrorAction SilentlyContinue

        # Check if the resolution was successful
        if ($result) {
            Write-Host "Domain '$domain' is available with IP $($result.IPAddress)"
        } else {
            Write-Host "Domain '$domain' is not available"
        }
    }
}

function Ping-CustomIP {
    # Prompt the user to input the IP address to ping
    $targetAddress = Read-Host "Enter the IP address to ping (e.g. 1.1.1.1):"

    # Ping the target IP address
    Write-Host "Pinging $targetAddress..."
    ping $targetAddress
}

function Ping-DefaultGateway {
    # Get the default gateway IP address
    $gateway = (Get-NetRoute | Where-Object { $_.DestinationPrefix -eq '0.0.0.0/0' }).NextHop

    if ($gateway -ne $null) {
        Write-Host "Default gateway found: $gateway"
        Write-Host "Pinging the gateway..."
        ping $gateway
    } else {
        Write-Host "Default gateway not found."
    }
}

# Define the menu options
$menuOptions = @(
    "0. Quit",
    "1. ARP Scan",
    "2. Get DNS Resolve",
    "3. Get Default DNS",
    "4. Ping Custom IP",
    "5. Ping Default Gateway"
)

# Loop to handle user selection
do {
    # Display the menu options
    Write-Host "Select an option:"
    $menuOptions

    # Prompt user to select an option
    $selection = Read-Host "Enter your choice (0-5):"

    # Process the user's selection
    switch ($selection) {
        "0" {
            Write-Host "Exiting..."
            break
        }
        "1" {
            Invoke-ARPScan
        }
        "2" {
            Domain-Resolve
        }
        "3" {
            Get-DefaultDNS
        }
        "4" {
            Ping-CustomIP
        }
        "5" {
            Ping-DefaultGateway
        }
        default {
            Write-Host "Invalid selection. Please try again."
        }
    }
    # Add separators for better readability
    Write-Host "====================================================================="
} while ($selection -ne "0")
