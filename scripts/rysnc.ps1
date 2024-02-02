function Invoke-Rsync {
    # Prompt user for source directory (target) and destination directory
    $sourceDir = Read-Host "Enter the source directory (target) path:"
    $destDir = Read-Host "Enter the destination directory path:"

    # Check if source directory exists
    if (-not (Test-Path -Path $sourceDir -PathType Container)) {
        Write-Host "Source directory does not exist."
        return
    }

    # Check if destination directory exists, if not, create it
    if (-not (Test-Path -Path $destDir -PathType Container)) {
        Write-Host "Destination directory does not exist. Creating..."
        New-Item -Path $destDir -ItemType Directory | Out-Null
    }

    # Perform rsync-like operation to synchronize data from source directory to destination directory
    $cmd = "robocopy `"$sourceDir`" `"$destDir`" /mir /xo /fft /ndl /np"
    Write-Host "Executing command: $cmd"
    Invoke-Expression -Command $cmd
}

