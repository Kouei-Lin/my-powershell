# Define the environment variables
$apps = @{
    "chrome" = "http://dl.google.com/chrome/install/latest/chrome_installer.exe"
    "7zip" = "https://www.7-zip.org/a/7z2301-x64.exe"
    "skype" = "https://go.skype.com/windows.desktop.download"
    "line" = "https://desktop.line-scdn.net/win/new/LineInst.exe"
    "anydesk" = "https://anydesk.com/zht/downloads/thank-you?dv=win_exe"
    "adobe" = "https://get.adobe.com/tw/reader/download?os=Windows+10&name=Reader+2023.008.20533+TradChines+Windows%2864Bit%29&lang=tw&nativeOs=Windows+10&accepted=&declined=mss&preInstalled=&site=landing"
    "wireguard" = "https://download.wireguard.com/windows-client/wireguard-installer.exe"
}

# Define the function to initiate the download process for each application
function Get-Installer {
    param (
        [hashtable]$Applications
    )

    foreach ($key in $Applications.Keys) {
        Start-Process $Applications[$key]
        Start-Sleep -Seconds 10
    }
}

# Call the function to initiate the download process for each application
Get-Installer -Applications $apps
