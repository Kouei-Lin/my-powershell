# Define the environment variables
$apps = @{
    "chrome" = "http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
    "7zip" = "https://www.7-zip.org/a/7z2301-x64.exe"
    "skype" = "https://go.skype.com/windows.desktop.download"
    "line" = "https://desktop.line-scdn.net/win/new/LineInst.exe"
    "anydesk" = "https://anydesk.com/zht/downloads/thank-you?dv=win_exe"
    "adobe" = "https://get.adobe.com/tw/reader/download?os=Windows+10&name=Reader+2023.006.20380+TradChines+Windows%2864Bit%29&lang=tw&nativeOs=Windows+10&accepted=mss&declined=&preInstalled=&site=landing"
    "wireguard" = "https://download.wireguard.com/windows-client/wireguard-installer.exe"
}

# Loop through each URL and start the download process
foreach ($key in $apps.Keys) {
    Start-Process $apps[$key]
    Start-Sleep -Seconds 10
}
