#create directory for log file
New-Item -ItemType "directory" -Path C:\DeploymentLogs
sleep 5

#create Log File and error log file
New-Item C:\DeploymentLogs\log.txt
New-Item C:\DeploymentLogs\errorlog.txt
sleep 5

#create initial log
Add-Content C:\DeploymentLogs\log.txt "Starting Script. exit code is: $LASTEXITCODE"
sleep 5

#Install Nuget Modules
try{
  Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
  Add-Content C:\DeploymentLogs\log.txt "Installing Nuget Modules. exit code is: $LASTEXITCODE"
  sleep 10
}
catch{
    Add-Content C:\DeploymentLogs\log.txt "Error occurred downloading NuGet Modules with exit code: $LASTEXITCODE."
}


#install PSGet modules
try{
    Add-Content C:\DeploymentLogs\log.txt "Installing powershellGet Modules. exit code is: $LASTEXITCODE"
    Install-Module -Name PowerShellGet -Force -AllowClobber
    sleep 10

}
catch{
    Add-Content C:\DeploymentLogs\log.txt "Error occurred downloading PSGet with exit code: $LASTEXITCODE"
}

#Install Chocolatey
#Install Chocolatey
try{
    Add-Content C:\DeploymentLogs\log.txt "Installing chocolatey. exit code is: $LASTEXITCODE"
    sleep 5
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/acapodil/Azure-Virtual-Desktop/main/Scripts/install.ps1'))
}
catch{
     Add-Content C:\DeploymentLogs\log.txt "Error downloading chocolatey package manager.Check the error log. Retrying... exit code is: $LASTEXITCODE"
     sleep 5
     Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/apcapodilupo/WVD_2020/main/Scripts/install.ps1'))

}

try{ 
    Add-Content C:\DeploymentLogs\log.txt "Installing foxit reader. exit code is: $LASTEXITCODE"
    choco install foxitreader -yes --ignore-checksums
    sleep 5
}
catch{
    Add-Content C:\DeploymentLogs\log.txt "Error downloading foxit reader agent. exit code is: $LASTEXITCODE"

}

try{ 
    Add-Content C:\DeploymentLogs\log.txt "Installing notepad++ . exit code is: $LASTEXITCODE"
    choco install notepadplusplus -yes --ignore-checksums
    sleep 5
}
catch{
    Add-Content C:\DeploymentLogs\log.txt "Error downloading notepad++. exit code is: $LASTEXITCODE"

}
