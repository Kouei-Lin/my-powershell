# Define the target IP addresses
$wanAddress = "1.1.1.1"

# Ping 1.1.1.1 to check WAN connectivity
Write-Host "Pinging $wanAddress to check WAN connectivity..."
ping $wanAddress

# Get the default gateway IP address
$gateway = (Get-NetRoute | Where-Object { $_.DestinationPrefix -eq '0.0.0.0/0' }).NextHop

if ($gateway -ne $null) {
    Write-Host "Default gateway found: $gateway"
    Write-Host "Pinging the gateway..."
    ping $gateway
} else {
    Write-Host "Default gateway not found."
}
