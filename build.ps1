Set-StrictMode -Version Latest

$commitShort = git rev-parse --short HEAD
$files = Get-ChildItem tests -Recurse -File | Where-Object Name -eq "Dockerfile"
foreach ($file in $files) {
    Write-Host "Will build: $($file.FullName)"
}
foreach ($file in $files) {
    $dir = $file.DirectoryName
    Push-Location $dir
    $content = Get-Content $file
    $command = $content[0].Replace("# ", "").Replace("{{short}}", $commitShort)
    Write-Host "Running $command in $dir"
    Invoke-Expression $command
    Pop-Location
}
