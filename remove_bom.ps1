$files = Get-ChildItem -Path .\microservicos -Recurse -File | Where-Object { $_.Extension -match "\.(java|xml|yml|yaml|properties|ps1)$" }
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
}
Write-Host "Forced UTF-8 No BOM on all files."
