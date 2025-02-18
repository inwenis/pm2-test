function Get-MemoryUsage() {
    while ($true) {
        $containers = docker ps --format '{{.ID}},{{.Image}}'
        $containerDict = @{}
        $containers | ForEach-Object {
            $containerId, $imageName = $_.Split(",")
            $containerDict[$containerId] = $imageName
        }
        $now = Get-Date -Format "O"
        $stats = docker stats --no-stream --format '{{.MemUsage}},{{.Container}}' # sample output: 63.11MiB / 512MiB,7fa23f1e43da
        $stats | ForEach-Object {
            $match = [Regex]::Match($_, '([\d\.]+)(\w+) / ([\d\.]+)(\w+),(.+)')
            $memUsage = [double]$match.Groups[1].Value
            $memTotal = [double]$match.Groups[3].Value
            $memUsageUnit = $match.Groups[2].Value
            $memTotalUnit = $match.Groups[4].Value
            $containerId = $match.Groups[5].Value
            Write-Output "$now,$containerId,$($containerDict[$containerId]),$memUsage,$memUsageUnit,$memTotal,$memTotalUnit" }
        Start-Sleep -Seconds 10
    }
}

if (-not (Test-Path "./out")) {
    New-Item -ItemType Directory -Path "./out" | Out-Null
}

$timestamp = Get-Date -Format "yyyyMMddHHmmss"

$commitShort = git rev-parse --short HEAD

docker run --memory=512m --detach test1-node:$commitShort
docker run --memory=512m --detach test1-pm2:$commitShort
docker run --memory=512m --detach test2-node:$commitShort
docker run --memory=512m --detach test2-pm2:$commitShort
docker run --memory=512m --detach test3-node:$commitShort
docker run --memory=512m --detach test3-pm2:$commitShort

Get-MemoryUsage | Tee-Object "./out/$timestamp.csv"
