<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		InstallPython.ps1

		Purpose:	Download and install python 3.7.0. 

		Version: 	1.0.0.0 - 11th September 2019
		==============================================================================================

	.SYNOPSIS
		Download and install python 3.7.0.

	.DESCRIPTION
		Download and install python 3.7.0.

        Deployment steps of the script are outlined below.
        1) Download and install python 3.7.0.

	.EXAMPLE
		Default:
        C:\PS>.\InstallPython.ps1
#>
#Requires -Version 5

#region Download and install Python 3.7.0

if(!(Test-Path -path "c:\temp")){
    New-Item -Path "c:\temp" -ItemType "Directory" -Force
}
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.7.4/python-3.7.4.exe" -OutFile "c:\temp\python-3.7.4.exe" -Verbose

Write-Output "StartingInstallation Process for python"
New-item -itemtype Directory -path C:\Python -Verbose -Force
Start-Process -Wait "c:\temp\python-3.7.4.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_test=0 DefaultAllUsersTargetDir=C:\Python"
Write-Output "Finish install Python"
#endregion

#region Set Enviroment variable.
$path = [Environment]::GetEnvironmentVariable('PATH', 'Machine')
$path += ';C:\Python;C:\Python\lib'
[Environment]::SetEnvironmentVariable('PATH', $path, 'Machine')
#endregion