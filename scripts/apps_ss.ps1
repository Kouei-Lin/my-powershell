# Define the URLs you want to open
$urls = @(
    "google.com"
    "en.wikipedia.org",
)

# Define base directory for saving screenshots
$baseDirectory = "D:\PATH"

# Loop through each URL
foreach ($url in $urls) {
    # Launch Microsoft Edge in private mode and navigate to the specified URL
    Start-Process msedge.exe -ArgumentList $url

    # Wait for Edge to load the webpage (adjust the sleep time as needed)
    Start-Sleep -Seconds 30

    # Define date
    $date = Get-Date -Format "yyyyMMdd"

    # Define the path where you want to save the screenshot
    $screenshotPath = Join-Path -Path $baseDirectory -ChildPath "$url.png"

    # Take a screenshot of the entire screen and save it to the specified path
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $screenshot = New-Object System.Drawing.Bitmap $screen.width, $screen.height
    $graphics = [System.Drawing.Graphics]::FromImage($screenshot)
    $graphics.CopyFromScreen([System.Drawing.Point]::Empty, [System.Drawing.Point]::Empty, $screen.size)
    $screenshot.Save($screenshotPath)
}

# Wait for all browser processes to exit
$browserProcesses | ForEach-Object {
    Wait-Process -Id $_
}
