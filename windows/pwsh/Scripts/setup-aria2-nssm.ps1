$DotfilesPath = Resolve-Path "$(Split-Path -parent $PSCommandPath)\..\.."
$DownloadPath = "${env:USERPROFILE}\Downloads"
$ConfigDir = "${env:USERPROFILE}\.config\aria2"

# Setup aria2 as service with nssm
gsudo nssm install aria2 $(Get-Command aria2c.exe).Source
gsudo nssm set aria2 AppParameters "--conf-path=$ConfigDir\aria2.conf --quiet --enable-rpc --rpc-listen-all"
gsudo nssm set aria2 AppDirectory $DownloadPath
gsudo nssm set aria2 AppExit Default Restart
gsudo nssm set aria2 AppPriority BELOW_NORMAL_PRIORITY_CLASS
gsudo nssm set aria2 DisplayName aria2
gsudo nssm set aria2 ObjectName LocalSystem
gsudo nssm set aria2 Start SERVICE_AUTO_START
gsudo nssm set aria2 Type SERVICE_WIN32_OWN_PROCESS

# Copy config and start the service
New-Item $ConfigDir -ItemType Directory -ErrorAction SilentlyContinue
Copy-Item $DotfilesPath\home\.config\aria2\aria2.conf $ConfigDir -Force
gsudo nssm start aria2
