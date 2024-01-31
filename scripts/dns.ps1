# Function to get current DNS servers
function Get-DNS {
    $dnsServers = Get-DnsClientServerAddress -AddressFamily "IPv4"
    Write-Host "Current DNS Servers:"
    $dnsServers
}

# Function to test domain availability
function Domain-Test {
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

# Call the functions
Get-DNS
Domain-Test

