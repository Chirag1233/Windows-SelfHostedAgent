
<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		PackageManagmentTools.ps1

		Purpose:	Download and install nuget and Chocolatey. 

		Version: 	1.0.0.0 - 11th September 2019 - BUMA Build Release Deployment Team
		==============================================================================================

	.SYNOPSIS
		Download and install nuget and Chocolatey. 

	.DESCRIPTION
		Download and install nuget and Chocolatey. 

        Deployment steps of the script are outlined below.
        1) Download and install nuget provider
        2) Download and install Chocolatey. 

	.EXAMPLE
		Default:
        C:\PS>.\PackageManagmentTools.ps1
#>
#Requires -Version 5

#region Download and Install Nuget Provider
Write-output "Install the Nuget Provider"
Install-PackageProvider -Name "Nuget" -Force -Verbose
Write-output "Finish Installing the Nuget Provier"
#endregion 

#region download and install Chocolatey
Write-Output "Installing Chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Output "Finish Installing Chocolatey"
#endregion