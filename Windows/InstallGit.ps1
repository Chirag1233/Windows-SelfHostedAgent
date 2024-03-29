<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		InstallGit.ps1

		Purpose:	Install Git and unix tools. 

		Version: 	1.0.0.0 - 11th September 2019
		==============================================================================================

	.SYNOPSIS
		Download and install GIT and unix tools.

	.DESCRIPTION
		Download and install GIT and unix tools.

        Deployment steps of the script are outlined below.
        1) Download and install GIT and unix tools.
        2) Set Enviroment Variable

	.EXAMPLE
		Default:
        C:\PS>.\InstallGit.ps1
#>
#Requires -Version 5


#region Download and install GIT and unix tools
choco install git install --params '"/GitAndUnixToolsOnPath"' --verbose -y
#endregion

#region Set Enviroment Variable.
$path = [Environment]::GetEnvironmentVariable('PATH', 'Machine')
$path += ';C:\Program Files\git\bin'
[Environment]::SetEnvironmentVariable('PATH', $path, 'Machine')
#endregion


# if (!($IsLinux -or $IsOSX)) {

#     $gitExePath = "C:\Program Files\Git\bin\git.exe"

#     foreach ($asset in (Invoke-RestMethod https://api.github.com/repos/git-for-windows/git/releases/latest).assets) {
#         if ($asset.name -match 'Git-\d*\.\d*\.\d*-64-bit\.exe') {
#             $dlurl = $asset.browser_download_url
#             $newver = $asset.name
#         }
#     }

#     try {
#         $ProgressPreference = 'SilentlyContinue'

#         if (!(Test-Path $gitExePath)) {
#             Write-Host "`nDownloading latest stable git..." -ForegroundColor Yellow
#             Remove-Item -Force $env:TEMP\git-stable.exe -ErrorAction SilentlyContinue -Verbose
#             Invoke-WebRequest -Uri $dlurl -OutFile $env:TEMP\git-stable.exe -Verbose

#             Write-Host "`nInstalling git..." -ForegroundColor Yellow
#             Start-Process -Wait $env:TEMP\git-stable.exe -ArgumentList /silent
#         }
#         else {
#             $updateneeded = $false
#             Write-Host "`ngit is already installed. Check if possible update..." -ForegroundColor Yellow
#             (git version) -match "(\d*\.\d*\.\d*)" | Out-Null
#             $installedversion = $matches[0].split('.')
#             $newver -match "(\d*\.\d*\.\d*)" | Out-Null
#             $newversion = $matches[0].split('.')

#             if (($newversion[0] -gt $installedversion[0]) -or ($newversion[0] -eq $installedversion[0] -and $newversion[1] -gt $installedversion[1]) -or ($newversion[0] -eq $installedversion[0] -and $newversion[1] -eq $installedversion[1] -and $newversion[2] -gt $installedversion[2])) {
#                 $updateneeded = $true
#             }

#             if ($updateneeded) {

#                 Write-Host "`nUpdate available. Downloading latest stable git..." -ForegroundColor Yellow
#                 Remove-Item -Force $env:TEMP\git-stable.exe -ErrorAction SilentlyContinue
#                 Invoke-WebRequest -Uri $dlurl -OutFile $env:TEMP\git-stable.exe -Verbose

#                 Write-Host "`nInstalling update..." -ForegroundColor Yellow
#                 $sshagentrunning = get-process ssh-agent -ErrorAction SilentlyContinue
#                 if ($sshagentrunning) {
#                     Write-Host "`nKilling ssh-agent..." -ForegroundColor Yellow
#                     Stop-Process $sshagentrunning.Id
#                 }

#                 Start-Process -Wait $env:TEMP\git-stable.exe -ArgumentList /silent -Verbose
#             } else {
#                 Write-Host "`nNo update available. Already running latest version..." -ForegroundColor Yellow
#             }

#         }
#             Write-Host "`nInstallation complete!`n`n" -ForegroundColor Green
#     }
#     finally {
#         Write-output "Error: unable to install or update the GIT."
#     }
# }
# else {
#     Write-Error "This script is currently only supported on the Windows operating system."
# }

#endregion