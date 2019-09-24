<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		InstallKubernetesTools.ps1

		Purpose:	Download and install kubectl and helm. 

		Version: 	1.0.0.0 - 11th September 2019 - BUMA Build Release Deployment Team
		==============================================================================================

	.SYNOPSIS
		Download and install kubectl and helm.

	.DESCRIPTION
		Download and install kubectl and helm.

        Deployment steps of the script are outlined below.
        1) Download and install kubernetes-cli.
        2) Download and install kubernetes-helm
        3) Set Enviroment variable for kubectl and helm

	.EXAMPLE
		Default:
        C:\PS>.\InstallKubernetesTools.ps1
#>
#Requires -Version 5

#region Download and install kubernetes-CLI
choco install kubernetes-cli --verbose -y
#endregion

#region Downlaod and installing kubernetes-helm
choco install kubernetes-helm --verbose -y
#endregion

#region Set Enviroment Variable for kubectl and helm
$path = [Environment]::GetEnvironmentVariable('PATH', 'Machine')
$path += ';C:\ProgramData\chocolatey\lib\kubernetes-cli\tools\kubernetes\client\bin;C:\ProgramData\chocolatey\lib\kubernetes-helm\tools\windows-amd64'
[Environment]::SetEnvironmentVariable('PATH', $path, 'Machine')
Import-Module Microsoft.PowerShell.Management -Force -Verbose
#endregion