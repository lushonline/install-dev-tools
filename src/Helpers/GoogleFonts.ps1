function Enable-GoogleFont {
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $Name
  )

  $ArchiveDest = Join-Path -Path "${env:Temp}" -ChildPath "google_font_installer_${Name}";
  $FontUrl = "https://fonts.google.com/download?family=$Name";
  $FontZipFile = Join-Path -Path "${ArchiveDest}" -ChildPath "${Name}.zip";

  if (-not (Test-Path -Path $ArchiveDest)) {
    New-Item $ArchiveDest -ItemType directory | Out-Null;
  }

  Write-Host "Start Installing Font Family: ${Name}" -ForegroundColor "Green";
  # Download Script repository as Zip
  Try {
    Invoke-WebRequest $FontUrl -O $FontZipFile;
    $DownloadResult = $TRUE;
  }
  catch [System.Net.WebException] {
    Write-Host "Error Downloading Font, check the internet connection or the repository url." -ForegroundColor "Red";
  }

  # If download succeeded, unzip the repository and run Setup.ps1
  if ($DownloadResult) {
    Add-Type -AssemblyName System.IO.Compression.FileSystem;
    [System.IO.Compression.ZipFile]::ExtractToDirectory($FontZipFile, $ArchiveDest);

    # grab all the font files in the fonts folder
    $Fonts = Get-ChildItem -Path $ArchiveDest -Include ('*.fon', '*.otf', '*.ttc', '*.ttf') -Recurse

    # loop through each font and install it
    foreach ($Font in $Fonts) {
      try {
        Copy-Item $Font "C:\Windows\Fonts"
        Write-Host "Installing Font: $($Font.Basename)" -ForegroundColor "Green";
        New-ItemProperty -Name $Font.BaseName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $Font.name -Force | Out-Null
      }
      catch {
        Write-Host "Failed to install ${Name}" -ForegroundColor "Red";
        Exit
      }
    }

    #Cleanup
    Remove-Item -Path "$ArchiveDest" -Recurse -Force | Out-Null

    Write-Host "Finished Installing Font Family: ${Name}" -ForegroundColor "Green";
  }

}