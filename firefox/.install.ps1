$FFDir = "$env:APPDATA\Mozilla\Firefox"

function Get-IniContent ($filePath) {
    $ini = @{}
    switch -regex -file $FilePath {
        "^\[(.+)\]" {
            # Section
            $section = $matches[1]
            $ini[$section] = @{}
            $CommentCount = 0
        }
        "^(;.*)$" {
            # Comment
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = "Comment" + $CommentCount
            $ini[$section][$name] = $value
        }
        "(.+?)\s*=(.*)" {
            # Key
            $name, $value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }
    return $ini
}


function Install-Files($DotDir, $Target) {
    $Dest = "$FFDir\${Target}"

    New-Item -Type Directory $Dest -Force | Out-Null
    ":: Install user.js to ${Target}"
    Copy-Item -Force $DotDir\user.js $Dest
    if (Test-Path -Path "$Dest\chrome") {
        Get-ChildItem -Path $Dest\chrome *.css -Recurse | ForEach-Object { Remove-Item -Path $_.FullName }
    }
    ":: Install css tweaks to ${Target}"
    Copy-Item -Force -Recurse $DotDir\chrome $Dest
}

function dot_install {
    if (!(Test-Path $FFDir\profiles.ini)) {
        "no firefox profile detected, open firefox first before restoring tweaks"
        exit
    }
    Get-IniContent -filePath $FFDir\profiles.ini | ForEach-Object { $_[$_.Keys].Path } | ForEach-Object {
        if (Test-Path "$FFDir\${_}\prefs.js") {
            Install-Files $PSScriptRoot $_
        }
    }
}
