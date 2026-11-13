$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
$name = 'Recanto-das-Asas-1.0.7-Windows.exe'
$out = [IO.File]::Create((Join-Path $PSScriptRoot $name))
try { Get-ChildItem "$name.part*" | Sort-Object Name | ForEach-Object { $part=[IO.File]::OpenRead($_.FullName);try {$part.CopyTo($out)} finally {$part.Dispose()} } } finally {$out.Dispose()}
$expected = ((Get-Content SHA256SUMS.txt | Where-Object { $_ -match [regex]::Escape($name) }) -split ' ')[0]
if ((Get-FileHash $name -Algorithm SHA256).Hash.ToLower() -ne $expected) {Remove-Item $name;throw 'Arquivo incompleto ou corrompido.'}
Write-Host 'Instalador conferido. Faça backup e execute o instalador sem desinstalar.'
