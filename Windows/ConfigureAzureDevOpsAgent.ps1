<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		ConfigureAzureDevOpsAgent.ps1

		Purpose:	Configure Azure pipeline agent to talk to the Azure agent pool. 

		Version: 	1.0.0.0 - 11th September 2019 - BUMA Build Release Deployment Team
		==============================================================================================

	.SYNOPSIS
		Configure Azure pipeline agent to talk to the Azure agent pool.

	.DESCRIPTION
		Configure Azure pipeline agent to talk to the Azure agent pool.

    Deployment steps of the script are outlined below.
    1) Check the enviroment Variables are been set.
    2) Download Agent to the provided Location.

	.EXAMPLE
		Default:
        C:\PS>.\ConfigureAzureDevOpsAgent.ps1
#>

#Requires -Version 5
#region Check enviroment Variables.
Import-Module Microsoft.PowerShell.Management -Force -Verbose

if (-not (Test-Path Env:AZP_URL)) {
    Write-Error "error: missing AZP_URL environment variable"
    exit 1
}
  

if (-not (Test-Path Env:AZP_TOKEN)) {
    Write-Error "error: missing AZP_TOKEN environment variable"
    exit 1
}
  
#endregion

#region Configure the azure pipeline agent.
try {
    Write-Host "3. Configuring Azure Pipelines agent..." -ForegroundColor Cyan

    C:\azp\agent\config.cmd --unattended `
        --agent "$(if (Test-Path Env:AZP_AGENT_NAME) { ${Env:AZP_AGENT_NAME} } else { ${Env:computername} })" `
        --url "$(${Env:AZP_URL})" `
        --auth PAT `
        --token "$(${Env:AZP_TOKEN})" `
        --pool "$(if (Test-Path Env:AZP_POOL) { ${Env:AZP_POOL} } else { 'Default' })" `
        --work "$(if (Test-Path Env:AZP_WORK) { ${Env:AZP_WORK} } else { '_work' })" `
        --replace

    Write-Host "4. Running Azure Pipelines agent..." -ForegroundColor Cyan

    C:\azp\agent\run.cmd
}
finally {
    Write-Host "Cleanup. Removing Azure Pipelines agent..." -ForegroundColor Cyan

    C:\azp\agent\config.cmd remove --unattended `
        --auth PAT `
        --token "$(Get-Content ${Env:AZP_TOKEN_FILE})"
}
#endregion