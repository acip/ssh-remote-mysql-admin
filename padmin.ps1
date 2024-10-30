param (
    [string]$HostName
)

if (-not $HostName) {
    Write-Host "Usage: .\start_server.ps1 hostname"
    exit 1
}

# Get the script's directory path
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Start the SSH tunnel and capture the process
Write-Host "Establishing SSH tunnel to $HostName..."
$sshProcess = Start-Process -NoNewWindow -PassThru -FilePath "ssh" -ArgumentList "-NT -L 3306:localhost:3306 $HostName"

# Start the PHP server in the script's directory and capture the process
Write-Host "Starting PHP server on localhost:8000 in $scriptDirectory..."
$phpProcess = Start-Process -NoNewWindow -PassThru -FilePath "php" -ArgumentList "-S localhost:8000 -t `"$scriptDirectory`""

# Function to clean up processes
function Cleanup {
    Write-Host "Cleaning up background processes..."
    if ($sshProcess -and !$sshProcess.HasExited) {
        $sshProcess.Kill()
    }
    if ($phpProcess -and !$phpProcess.HasExited) {
        $phpProcess.Kill()
    }
}

# Ensure cleanup runs when script ends
try {
    # Wait for user input to end the server
    Write-Host "Press Enter to stop the server..."
    $null = Read-Host
} finally {
    # Run cleanup to terminate background processes
    Cleanup
}
