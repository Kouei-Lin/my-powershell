# Function to download and install Nmap
function Get-NmapInstaller {
    # Define the Nmap version
    $nmapVersion = "7.94"

    # Define the URL to download the Nmap installer
    $nmapInstallerUrl = "https://nmap.org/dist/nmap-$nmapVersion-setup.exe"

    # Download the Nmap installer
    Start-Process $nmapInstallerUrl

    # Sleep for 10 seconds
    Start-Sleep -Seconds 10

    # Start the Nmap installer
    Start-Process "$env:USERPROFILE\Downloads\nmap*.exe"
}

function Invoke-NmapScan {
    # Prompt the user to input the scan range
    $scanRange = Read-Host "Enter the scan range (e.g. 192.168.1.0/24):"

    # Define the command to run Nmap
    $nmapCommand = "C:\Program Files (x86)\Nmap\nmap.exe"

    # Define the output file name using the scan range
    $outputFileName = "nmap_results_$scanRange.txt"

    # Define the parameters for the Nmap scan
    $nmapParameters = "-oN $outputFileName -sn $scanRange"  # Output in normal format

    # Start the Nmap process
    Start-Process -FilePath $nmapCommand -ArgumentList $nmapParameters -NoNewWindow -Wait

    # Inform the user about the completion and the file location
    Write-Host "Nmap scan results have been saved to $outputFileName"
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
    "1. Nmap Scan",
    "2. Download and Install Nmap",
    "3. Get DNS Resolve",
    "4. Get Default DNS",
    "5. Ping Custom IP",
    "6. Ping Default Gateway"
)

# Loop to handle user selection
do {
    # Display the menu options
    Write-Host "Select an option:"
    $menuOptions

    # Prompt user to select an option
    $selection = Read-Host "Enter your choice (0-6):"

    # Process the user's selection
    switch ($selection) {
        "0" {
            Write-Host "Exiting..."
            break
        }
        "1" {
            Invoke-NmapScan
        }
        "2" {
            Get-NmapInstaller
        }
        "3" {
            Domain-Resolve
        }
        "4" {
            Get-DefaultDNS
        }
        "5" {
            Ping-CustomIP
        }
        "6" {
            Ping-DefaultGateway
        }
        default {
            Write-Host "Invalid selection. Please try again."
        }
    }
    # Add separators for better readability
    Write-Host "====================================================================="
} while ($selection -ne "0")
