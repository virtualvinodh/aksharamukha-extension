Copy-Item ..\aksharamukha\aksharamukha-front\src\mixins\ScriptMixin.js .

Copy-Item ..\aksharamukha\aksharamukha-front\src\statics\fonts.css .
Copy-Item ..\aksharamukha-fonts\aksharamukha-fonts.css .
Copy-Item ..\aksharamukha-notomirror\aksharamukha-notomirror.css .

$file = 'fonts.css'
$lines = [IO.File]::ReadAllLines("$PWD/$file")
Set-Content -Encoding UTF8 $file -Value $lines[1..($lines.Count-1)]

$file = 'aksharamukha-fonts.css'
$lines = [IO.File]::ReadAllLines("$PWD/$file")
Set-Content -Encoding UTF8 $file -Value $lines[1..($lines.Count-1)]

(Get-Content ScriptMixin.js).replace('export const ScriptMixin', 'const ScriptMixin') | Set-Content ScriptMixin.js

(Get-Content .\manifest.json).replace('@@@', $args[0]) | Set-Content .\manifest.json

$file = 'ScriptMixin.js'
$lines = [IO.File]::ReadAllLines("$PWD/$file")
Set-Content -Encoding UTF8 $file -Value $lines[0..2 + 17..($lines.Count-1)]

if (Test-Path ./chrome-extension.zip -PathType leaf) {
    Remove-Item ./chrome-extension.zip
}

Get-ChildItem -Path $YourDirToCompress | Where {$_.Extension -ne 'ps1'} | Compress-Archive -DestinationPath ./chrome-extension.zip -Update

(Get-Content .\manifest.json).replace( $args[0], '@@@') | Set-Content .\manifest.json

### How to Run
### Replaces @@@ by versionnumber in Manifest
### ./extensionbuild.ps1 versionnumber
