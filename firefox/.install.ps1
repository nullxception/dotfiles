function Get-IniContent ($filePath) {
    $ini = @{}
    switch -regex -file $FilePath {
        "^\[(.+)\]" # Section
        {
            $section = $matches[1]
            $ini[$section] = @{}
            $CommentCount = 0
        }
        "^(;.*)$" # Comment
        {
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = "Comment" + $CommentCount
            $ini[$section][$name] = $value
        }
        "(.+?)\s*=(.*)" # Key
        {
            $name,$value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }
    return $ini
}


function Dot-Install {
    $FirefoxDir = "$env:APPDATA\Mozilla\Firefox"
    if (!(Test-Path $FirefoxDir\profiles.ini)) {
        "no firefox profile detected, open firefox first before restoring tweaks"
        exit
    }
    Get-IniContent -filePath $FirefoxDir\profiles.ini | ForEach-Object {$_[$_.Keys].Path} | ForEach-Object {
        if (Test-Path "$FirefoxDir\${_}\prefs.js") {
            ":: Install user.js to ${_}"
            Copy-Item -Force $PSScriptRoot\user.js "$FirefoxDir\${_}"
        }
    }
}
