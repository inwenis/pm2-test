function Get-MemoryUsage() {
    while ($true) {
        $now = Get-Date -Format "O"
        $stats = docker stats --no-stream --format '{{.MemUsage}},{{.Container}}' # sample output: 63.11MiB / 512MiB,7fa23f1e43da
        $stats | ForEach-Object {
            $match = [Regex]::Match($_, '([\d\.]+)(\w+) / ([\d\.]+)(\w+),(.+)')
            $memUsage = [double]$match.Groups[1].Value
            $memTotal = [double]$match.Groups[3].Value
            $memUsageUnit = $match.Groups[2].Value
            $memTotalUnit = $match.Groups[4].Value
            $containerId = $match.Groups[5].Value
            Write-Output "$now,$containerId,$memUsage,$memUsageUnit,$memTotal,$memTotalUnit" }
        Start-Sleep -Seconds 10
    }
}

if (-not (Test-Path "./out")) {
    New-Item -ItemType Directory -Path "./out" | Out-Null
}

$timestamp = Get-Date -Format "yyyyMMddHHmmss"

$cont1 = docker run --memory=512m --detach test1-node:latest
$cont2 = docker run --memory=512m --detach test1-pm2:latest

Get-MemoryUsage | Tee-Object "./out/$timestamp.csv"
