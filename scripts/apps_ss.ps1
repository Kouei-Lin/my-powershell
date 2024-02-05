# Define the URL of the webpage you want to open
$url = "https://www.google.com"

# Launch Microsoft Edge in private mode and navigate to the specified URL
Start-Process msedge.exe -ArgumentList "-inprivate", $url

# Wait for Edge to load the webpage (adjust the sleep time as needed)
Start-Sleep -Seconds 5

#Define date
$date = Get-Date -Format "yyyyMMdd_HHmmss"

# Define the path where you want to save the screenshot
$screenshotPath = "C:\Users\User\Desktop\$date.png"

# Take a screenshot of the entire screen and save it to the specified path
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$screenshot = New-Object System.Drawing.Bitmap $screen.width, $screen.height
$graphics = [System.Drawing.Graphics]::FromImage($screenshot)
$graphics.CopyFromScreen([System.Drawing.Point]::Empty, [System.Drawing.Point]::Empty, $screen.size)
$screenshot.Save($screenshotPath)

