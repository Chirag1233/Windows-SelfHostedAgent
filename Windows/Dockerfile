FROM mcr.microsoft.com/windows/servercore:ltsc2019
ARG AZP_URL
ARG AZP_TOKEN

WORKDIR /azp

COPY DownloadAzDevOpsAgent.ps1 .
RUN powershell -File .\DownloadAzDevOpsAgent.ps1

COPY PackageManagmentTools.ps1 .
RUN powershell -File .\PackageManagmentTools.ps1

COPY InstallPython.ps1 .
RUN powershell -File .\InstallPython.ps1

COPY InstallAzureModules.ps1 .
RUN powershell -File .\InstallAzureModules.ps1

COPY InstallGit.ps1 .
RUN powershell -File .\InstallGit.ps1

COPY InstallKubernetesTools.ps1 .
RUN powershell -File .\InstallKubernetesTools.ps1

COPY ConfigureAzureDevOpsAgent.ps1 .
CMD powershell .\ConfigureAzureDevOpsAgent.ps1
