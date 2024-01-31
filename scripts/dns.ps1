# Get current DNS servers in use
$dnsServers = Get-DnsClientServerAddress
# Print current DNS servers
Write-Host "Current DNS Servers:"
$dnsServers

# --- 
Write-Host "-------------------------"

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

