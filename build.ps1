$commitShort = git rev-parse --short HEAD
$files = Get-ChildItem tests -Recurse -File
$files | Where-Object Name -eq "Dockerfile" | ForEach-Object {
    $dir = $_.DirectoryName
    Push-Location $dir
    $content = Get-Content $_
    $command = $content[0].Replace("# ", "").Replace("{{short}}", $commitShort)
    Write-Host "Running $command in $dir"
    Invoke-Expression $command
    Pop-Location
}
