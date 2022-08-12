$GitHubRepositoryName = "install-dev-tools";
$ScriptFolder = Join-Path -Path $HOME -ChildPath ".ScriptInstall";
$ScriptWorkFolder = Join-Path -Path $ScriptFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath "src";
$ScriptHelpersFolder = Join-Path -Path $ScriptWorkFolder -ChildPath "Helpers";
$ScriptConfigFile = Join-Path -Path $ScriptFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath "config.json";

Write-Host "Welcome to Script Installer for Dev Tools for Microsoft Windows 10+" -ForegroundColor "Yellow";
Write-Host "Please don't use your device while the script is running." -ForegroundColor "Yellow";

# Load helpers
Write-Host "Loading helpers:" -ForegroundColor "Green";
$ScriptHelpers = Get-ChildItem -Path "${ScriptHelpersFolder}\*" -Include *.ps1 -Recurse;
foreach ($ScriptHelper in $ScriptHelpers) {
  . $ScriptHelper;
};

# Save user configuration in persistence
Set-Configuration-File -ScriptConfigFile $ScriptConfigFile -GitUserName $GitUserName -GitUserEmail $GitUserEmail -WorkspaceDisk $WorkspaceDisk;

# Load user configuration from persistence
$Config = Get-Configuration-File -ScriptConfigFile $ScriptConfigFile;

# Set alias for HKEY_CLASSES_ROOT
Set-PSDrive-HKCR;

# Register the script to start after reboot
Register-ScriptInstallDevTools-As-RunOnce;

# Run scripts
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "Chocolatey" | Join-Path -ChildPath "Chocolatey.ps1");
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "Fonts" | Join-Path -ChildPath "Fonts.ps1");
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "NodeLTS" | Join-Path -ChildPath "NodeLTS.ps1");
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "Git" | Join-Path -ChildPath "Git.ps1");
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "GitCredentialManager" | Join-Path -ChildPath "GitCredentialManager.ps1");
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "GitHubDesktop" | Join-Path -ChildPath "GitHubDesktop.ps1");
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "WindowsTerminal" | Join-Path -ChildPath "WindowsTerminal.ps1");
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "VSCode" | Join-Path -ChildPath "VSCode.ps1");
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "Notepad++" | Join-Path -ChildPath "Notepad++.ps1");
#Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "Dotnet" | Join-Path -ChildPath "Dotnet.ps1");
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "WSL.ps1");
Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "Docker" | Join-Path -ChildPath "Docker.ps1");

# Clean
# Unregister script from RunOnce
Remove-ScriptInstallDevTools-From-RunOnce;

Write-Host "Cleaning Script workspace:" -ForegroundColor "Green";
Remove-Item $ScriptFolder -Recurse -Force -ErrorAction SilentlyContinue;

Write-Host "The process has finished." -ForegroundColor "Yellow";

Write-Host "Restarting the PC in 10 seconds..." -ForegroundColor "Green";
Start-Sleep -Seconds 10;
Restart-Computer;