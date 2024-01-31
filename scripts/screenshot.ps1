function Screenshot {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
    $Width  = $Screen.Width
    $Height = $Screen.Height
    $Left   = $Screen.Left
    $Top    = $Screen.Top

    $bitmap  = New-Object System.Drawing.Bitmap $Width, $Height
    $graphic = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)

    # Get the current username dynamically
    $Username = $env:USERNAME

    # Get the current date and time in a specific format
    $CurrentDateTime = Get-Date -Format "yyyyMMdd_HHmmss"

    # Construct the filename with the current username and time
    $ScreenshotPath = "C:\Users\$Username\Desktop\$CurrentDateTime.png"

    $bitmap.Save($ScreenshotPath)
    Write-Output "Screenshot saved to:"
    Write-Output $ScreenshotPath
}

# Call the function to capture a screenshot
Screenshot
