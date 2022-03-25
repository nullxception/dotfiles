$Principal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
$AdmRole = [Security.Principal.WindowsBuiltInRole] "Administrator"
if (!$Principal.IsInRole($AdmRole)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$Trigger = New-ScheduledTaskTrigger -AtLogOn
$Settings = New-ScheduledTaskSettingsSet -Hidden `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -DontStopOnIdleEnd
$Action = New-ScheduledTaskAction -Execute "pythonw.exe" `
    -Argument "${PSScriptRoot}\autostart.pyw" `
    -WorkingDirectory "${PSScriptRoot}"

Unregister-ScheduledTask -TaskName Autostart -ErrorAction SilentlyContinue
Register-ScheduledTask -TaskName Autostart `
    -Description "Starting a various programs quietly on logon" `
    -User "$env:USERNAME" `
    -RunLevel Highest `
    -Trigger $Trigger -Action $Action -Settings $Settings
