winget install Google.AndroidStudio

$studioPath = "C:\Program Files\Android\Android Studio"

Register-Env -Scope User JAVA_HOME "$studioPath\jbr"
Register-Env -Scope User ANDROID_HOME 'D:\Dev\Android\Sdk'
Register-Env -Scope User ANDROID_USER_HOME 'D:\Dev\Android\.android'

$CustomPath = @(
    "$studioPath\bin"
    "$env:JAVA_HOME\bin"
    "$env:ANDROID_HOME\cmdline-tools\latest\bin",
    "$env:ANDROID_HOME\emulator",
    "$env:ANDROID_HOME\platform-tools"
)

$CustomPath | Where-Object { Register-Path -At $_ -Scope User }
