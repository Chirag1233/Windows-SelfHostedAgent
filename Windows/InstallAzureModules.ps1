<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		InstallAzureModules.ps1

		Purpose:	Installs the Azure Powershell AZ modules and Azure CLI cmdlets. 

		Version: 	1.0.0.0 - 11th September 2019 - BUMA Build Release Deployment Team
		==============================================================================================

	.SYNOPSIS
		Download and install Azure powershell Az modules and Azure CLI cmdlets.

	.DESCRIPTION
		Download and install Azure powershell Az modules and Azure CLI cmdlets.

        Deployment steps of the script are outlined below.
        1) Install Azure Powershell Az Modules.
        2) Install Azure CLI Cmdlets.

	.EXAMPLE
		Default:
        C:\PS>.\InstallAzureModules.ps1
#>
#Requires -Version 5

#region Install Azure Powershell AZ modules. 

<##install AzureRM Module
Get-Module PowerShellGet -list | Select-Object Name,Version,Path
Install-Module AzureRM -AllowClobber
Import-Module AzureRM#>

Install-Module -Name Az -AllowClobber -Scope AllUsers -Force -Verbose
#endregion

#Region Install Azure CLI cmdlets
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet' -Verbose
#endregion