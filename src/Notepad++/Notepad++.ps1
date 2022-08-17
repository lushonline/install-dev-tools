function Set-NotepadPlusPlus-Plugins {
  $NotepadPlusPlusConfigurationPath = Join-Path -Path $env:appdata -ChildPath "Notepad++";
  $ScriptNotepadPlusPlusConfigurationPath = Join-Path -Path $ScriptWorkFolder -ChildPath "Notepad++";

  if (-not (Test-Path -Path $NotepadPlusPlusConfigurationPath)) {
    Write-Host "Notepad++ is not installed or configured." -ForegroundColor "Green";
  }
  else {
    Write-Host "Adding Plugins to Notepad++:" -ForegroundColor "Green";
    if (-not (Test-Path -Path "${NotepadPlusPlusConfigurationPath}\plugins")) {
      New-Item "${NotepadPlusPlusConfigurationPath}\plugins" -ItemType directory;
    }

    Get-ChildItem -Path "${ScriptNotepadPlusPlusConfigurationPath}\plugins\*" -Recurse | Copy-Item -Destination "${NotepadPlusPlusConfigurationPath}\plugins" -Force;

    Write-Host "Notepad++ plugins successfully added." -ForegroundColor "Green";
  }
}

function Set-NotepadPlusPlus-Configuration {
  $NotepadPlusPlusConfigurationPath = Join-Path -Path $env:appdata -ChildPath "Notepad++";
  $ScriptNotepadPlusPlusConfigurationPath = Join-Path -Path $ScriptWorkFolder -ChildPath "Notepad++";

  if (-not (Test-Path -Path $NotepadPlusPlusConfigurationPath)) {
    Write-Host "Notepad++ is not installed or configured." -ForegroundColor "Green";
  }
  else {
    Write-Host "Configuring Notepad++:" -ForegroundColor "Green";

    Get-ChildItem -Path "${ScriptNotepadPlusPlusConfigurationPath}\settings\*" -Recurse | Copy-Item -Destination $NotepadPlusPlusConfigurationPath -Force;

    Write-Host "Notepad++ was successfully configured." -ForegroundColor "Green";
  }
}

choco install -y "notepadplusplus";
Set-NotepadPlusPlus-Configuration;
Set-NotepadPlusPlus-Plugins;
