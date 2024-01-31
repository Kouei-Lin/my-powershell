# Function to download and install Nmap
function Get-NmapInstaller {
    # Define the Nmap version
    $nmapVersion = "7.94"

    # Define the URL to download the Nmap installer
    $nmapInstallerUrl = "https://nmap.org/dist/nmap-$nmapVersion-setup.exe
"

    # Download the Nmap installer
    Start-Process $nmapInstallerUrl

    # Sleep for 10 seconds
    Start-Sleep -Seconds 10

    # Start the Nmap installer
    Start-Process "$env:USERPROFILE\Downloads\nmap*.exe"
}

# Function to invoke an Nmap scan
function Invoke-NmapScan {
    # Prompt the user to input the scan range
    $scanRange = Read-Host "Enter the scan range (e.g., 192.168.1.0/24):"

    # Define the command to run Nmap
    $nmapCommand = "C:\Program Files (x86)\Nmap\nmap.exe"

    # Define the parameters for the Nmap scan
    $nmapParameters = "-sn $scanRange"
    
    # Define filename
    $CurrentTime = Get-Date -Format "yyyyMMdd_HHmmss"
    $FileName = "$CurrentTime.txt"
    # Start the Nmap process
    Start-Process -FilePath $nmapCommand -ArgumentList $nmapParameters -NoNewWindow -Wait > $FileName
}

# Define the menu options
$menuOptions = @(
    "1. Invoke Nmap Scan",
    "2. Download and Install Nmap",
    "3. Quit"
)

# Display the menu options
Write-Host "Select an option:"
$menuOptions

# Loop to handle user selection
do {
    # Prompt user to select an option
    $selection = Read-Host "Enter your choice (1-3):"

    # Process the user's selection
    switch ($selection) {
        "1" {
            Invoke-NmapScan
        }
        "2" {
            Get-NmapInstaller
        }
        "3" {
            Write-Host "Exiting..."
            break
        }
        default {
            Write-Host "Invalid selection. Please try again."
        }
    }
} while ($selection -ne "3")
