<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		DownloadAzDevOpsAgent.ps1

		Purpose:	Download Azure pipeline agnet to the Docker image. 

		Version: 	1.0.0.0 - 11th September 2019 - BUMA Build Release Deployment Team
		==============================================================================================

	.SYNOPSIS
		Download the Azure pipeline agent to the \azp\agent location inside the docker image.

	.DESCRIPTION
		Download the Azure pipeline agent to the \azp\agent location inside the docker image.

    Deployment steps of the script are outlined below.
    1) Check the enviroment Variables are been set.
    2) Download Agent to the provided Location.

	.EXAMPLE
		Default:
        C:\PS>.\DownloadAzDevOpsAgent.ps1
#>

#Requires -Version 5

#region check the envirmoent variables are been set
if (-not (Test-Path Env:AZP_URL)) 
{
    Write-Error "error: missing AZP_URL environment variable"
    exit 1
}


if (-not (Test-Path Env:AZP_TOKEN)) 
{
    Write-Error "error: missing AZP_TOKEN environment variable"
    exit 1
}

Write-Host "Azure DevOps Account URL: $($env:AZP_URL)"
New-Item "\azp\agent" -ItemType directory | Out-Null

Set-Location agent
#endregion

#region download the Agent from the provided location
Write-Host "1. Determining matching Azure Pipelines agent..." -ForegroundColor Cyan

$creds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($("user:$($Env:AZP_TOKEN)")))
$encodedAuthValue = "Basic $creds"
$acceptHeaderValue = "application/json;api-version=3.0-preview"
$headers = @{Authorization = $encodedAuthValue; Accept = $acceptHeaderValue }

# win7-x64 or linux-x64 or osx-x64
$vstsUrl = "$($Env:AZP_URL)/_apis/distributedtask/packages/agent?platform=win-x64&`$top=1"
Write-Output "URI: $vstsUrl"
$response = Invoke-WebRequest -UseBasicParsing -Headers $headers -Uri $vstsUrl

# Do Rest-API call
$response = ConvertFrom-Json $response.Content
$url = $response.value[0].downloadUrl

Write-Host "2. Downloading and installing Azure Pipelines agent..." -ForegroundColor Cyan
Write-Output "Starting the download from URL: $url"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, "$(Get-Location)\agent.zip")

Expand-Archive -Path "agent.zip" -DestinationPath "\azp\agent" -Verbose
#endregion
