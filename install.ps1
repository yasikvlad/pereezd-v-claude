# Ставит скилл «Переезд в Claude» в Claude Code (Windows).
# irm https://raw.githubusercontent.com/yasikvlad/pereezd-v-claude/main/install.ps1 | iex
$ErrorActionPreference = "Stop"

$repo = "yasikvlad/pereezd-v-claude"
$dest = Join-Path $HOME ".claude\skills\pereezd-v-claude"
$tmp = Join-Path $env:TEMP ("pereezd-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $tmp | Out-Null

Write-Host "Тащу скилл с GitHub..."
$zip = Join-Path $tmp "repo.zip"
Invoke-WebRequest "https://github.com/$repo/archive/refs/heads/main.zip" -OutFile $zip
Expand-Archive $zip -DestinationPath $tmp

New-Item -ItemType Directory -Force -Path (Split-Path $dest) | Out-Null
if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
Copy-Item (Join-Path $tmp "pereezd-v-claude-main\pereezd-v-claude") $dest -Recurse
Remove-Item $tmp -Recurse -Force

Write-Host ""
Write-Host "Скилл стоит: $dest"
Write-Host "Дальше: открой Claude Code и напиши «Перенеси мою память из ChatGPT». Остальное сделают агенты."
