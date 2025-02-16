function Get-MemoryUsage {
    while ($true) {
        $now = Get-Date -Format "O"
        $stats = docker stats --no-stream --format '{{.MemUsage}}' # sample output: 48.51MiB / 1GiB
        $match = [Regex]::Match($stats, '([\d\.]+)(\w+) / ([\d\.]+)(\w+)')
        $memUsage = [double]$match.Groups[1].Value
        $memTotal = [double]$match.Groups[3].Value
        $memUsageUnit = $match.Groups[2].Value
        $memTotalUnit = $match.Groups[4].Value
        Write-Output "$now,$memUsage,$memUsageUnit,$memTotal,$memTotalUnit"
        Start-Sleep -Seconds 10
    }
}

if (-not (Test-Path "./out")) {
    New-Item -ItemType Directory -Path "./out" | Out-Null
}

docker run --memory=512m --detach pm2test:latest
Get-MemoryUsage | Tee-Object "./out/memory.csv"
