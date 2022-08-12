# archive/refs/head/main.zip is a download of the main branch
$GitHubRepositoryUri = "https://github.com/${GitHubRepositoryAuthor}/${GitHubRepositoryName}/archive/refs/heads/main.zip";

$ScriptFolder = Join-Path -Path $HOME -ChildPath ".ScriptInstall";
$ZipRepositoryFile = Join-Path -Path $ScriptFolder -ChildPath "${GitHubRepositoryName}-main.zip";
$ScriptWorkFolder = Join-Path -Path $ScriptFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath "src";

$DownloadResult = $FALSE;

# Request custom values
$GitUserName = Read-Host -Prompt "Input your Git user name here";

$GitUserEmail = Read-Host -Prompt "Input your Git user email here";

$ValidDisks = Get-PSDrive -PSProvider "FileSystem" | Select-Object -ExpandProperty "Root";
do {
  Write-Host "Choose the location of your development workspace:" -ForegroundColor "Green";
  Write-Host $ValidDisks -ForegroundColor "Green";
  $WorkspaceDisk = Read-Host -Prompt "Please choose one of the available disks";
}
while (-not ($ValidDisks -Contains $WorkspaceDisk));

# Create Script folder
if (Test-Path $ScriptFolder) {
  Remove-Item -Path $ScriptFolder -Recurse -Force;
}
New-Item $ScriptFolder -ItemType directory;

# Download Script repository as Zip
Try {
  Invoke-WebRequest $GitHubRepositoryUri -O $ZipRepositoryFile;
  $DownloadResult = $TRUE;
}
catch [System.Net.WebException] {
  Write-Host "Error connecting to GitHub, check the internet connection or the repository url." -ForegroundColor "Red";
}

# If download succeeded, unzip the repository and run Setup.ps1
if ($DownloadResult) {
  Add-Type -AssemblyName System.IO.Compression.FileSystem;
  [System.IO.Compression.ZipFile]::ExtractToDirectory($ZipRepositoryFile, $ScriptFolder);
  Invoke-Expression (Join-Path -Path $ScriptWorkFolder -ChildPath "Setup.ps1");
}