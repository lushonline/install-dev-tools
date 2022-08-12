function Register-ScriptInstallDevTools-As-RunOnce() {
  $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce";
  $ScriptName = "ScriptInstallDevTools";
  $ScriptMainScriptPath = Join-Path -Path $ScriptWorkFolder -ChildPath "setup.ps1";

  if (-not (Test-PathRegistryKey $RegPath $ScriptName)) {
    New-ItemProperty -Path $RegPath -Name $ScriptName -PropertyType String -Value "powershell ${ScriptMainScriptPath}";
  }
}

function Remove-ScriptInstallDevTools-From-RunOnce() {
  $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce";
  $ScriptName = "ScriptInstallDevTools";

  if (Test-PathRegistryKey $RegPath $ScriptName) {
    Remove-ItemProperty -Path $RegPath -Name $ScriptName;
  }
}