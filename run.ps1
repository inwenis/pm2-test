if (-not (Test-Path "./out")) {
    New-Item -ItemType Directory -Path "./out" | Out-Null
}

$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$outDir = "./out/$timestamp"
New-Item -ItemType Directory -Path $outDir | Out-Null

$cont1 = docker run --memory=512m --detach test1-node:latest
$cont2 = docker run --memory=512m --detach test1-pm2:latest

$functions = {
    function Get-MemoryUsage($containerId) {
        while ($true) {
            $now = Get-Date -Format "O"
            $stats = docker stats --no-stream --format '{{.MemUsage}}' $containerId # sample output: 48.51MiB / 1GiB
            $match = [Regex]::Match($stats, '([\d\.]+)(\w+) / ([\d\.]+)(\w+)')
            $memUsage = [double]$match.Groups[1].Value
            $memTotal = [double]$match.Groups[3].Value
            $memUsageUnit = $match.Groups[2].Value
            $memTotalUnit = $match.Groups[4].Value
            Write-Output "$now,$memUsage,$memUsageUnit,$memTotal,$memTotalUnit"
            Start-Sleep -Seconds 10
        }
    }
}

$job1 = Start-Job -InitializationScript $functions -ScriptBlock { Get-MemoryUsage $using:cont1 | Tee-Object "$($using:outDir)/cont1.csv" }
$job2 = Start-Job -InitializationScript $functions -ScriptBlock { Get-MemoryUsage $using:cont2 | Tee-Object "$($using:outDir)/cont2.csv" }

Wait-Job $job1, $job2
