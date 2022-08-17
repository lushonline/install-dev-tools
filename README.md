# install-dev-tools

Repeatable, reboot resilient script to setup a development environment in Microsoft Windows 10+ using Chocolatey and PowerShell.

## Usage

Open any Windows PowerShell host console **(Except Windows Terminal)** with administrator rights and run:

```Powershell
$GitHubRepositoryAuthor = "martinholden-skillsoft"; `
$GitHubRepositoryName = "install-dev-tools"; `
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; `
Invoke-Expression (Invoke-RestMethod -Uri "https://raw.githubusercontent.com/${GitHubRepositoryAuthor}/${GitHubRepositoryName}/main/Download.ps1");
```

## What does?

This script does:

- Install Chocolatey.
- Install Google Fonts
  - Montserrat
  - Spectral
- Configure Chocolatey to remember installation arguments for future updates.
- Install Git.
- Install GitCredentialManager.
- Install GitHub Desktop.
- Install Windows Terminal.
- Install Visual Studio Code.
- Install Notepad++.
- Enable Windows Subsystem for Linux.
- Install Debian in WSL.
- Install Docker Desktop.
