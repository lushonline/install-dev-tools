function Update-Debian-Packages-Repository {
  Write-Host "Updating Debian package repository:" -ForegroundColor "Green";
  wsl sudo apt --yes update;
}

function Update-Debian-Packages {
  Write-Host "Upgrading Debian packages:" -ForegroundColor "Green";
  wsl sudo apt --yes upgrade;
}

function Install-Debian-Package {
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $TRUE)]
    [string]
    $PackageName
  )

  Write-Host "Installing ${PackageName} in Debian:" -ForegroundColor "Green";
  wsl sudo apt install --yes --no-install-recommends $PackageName;
}

function Set-Git-Configuration-In-Debian {
  Write-Host "Configuring Git in Debian:" -ForegroundColor "Green";
  wsl git config --global init.defaultBranch "main";
  wsl git config --global user.name $Config.GitUserName;
  wsl git config --global user.email $Config.GitUserEmail;
  wsl git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe";
  wsl git config --list;
  Write-Host "Git was successfully configured in Debian." -ForegroundColor "Green";
}

function Install-VSCode-Extensions-In-WSL {
  Write-Host "Installing Visual Studio Code extensions in WSL:" -ForegroundColor "Green";
}

wsl --install -d "Debian";

Update-Debian-Packages-Repository;
Update-Debian-Packages;

Install-Debian-Package -PackageName "curl git make g++ gcc";

Set-Git-Configuration-In-Debian;

Install-VSCode-Extensions-In-WSL;
