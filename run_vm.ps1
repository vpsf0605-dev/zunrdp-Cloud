$baseUrl = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app"
$tsExe = "$env:ProgramFiles\Tailscale\Tailscale.exe"
$owner = $env:VM_OWNER
$vmID = "$owner-WIN-" + (Get-Random -Minimum 1000 -Maximum 9999)

& $tsExe up --authkey=$env:TS_KEY --hostname=$vmID --accept-routes --reset

while($true) {
    try {
        $ip = (& $tsExe ip -4).Trim()
        $payload = @{
            id        = $vmID
            owner     = $owner
            os        = "Windows"
            ip        = $ip
            user      = "ADMINZUN"
            pass      = "ZunRDP@123456"
            lastSeen  = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
        } | ConvertTo-Json -Compress
        Invoke-RestMethod -Uri "$baseUrl/vms/$vmID.json" -Method Put -Body $payload -ContentType "application/json"
        $cmd = Invoke-RestMethod -Uri "$baseUrl/commands/$vmID.json" -Method Get
        if ($cmd -and $cmd -ne "null") {
            Invoke-RestMethod -Uri "$baseUrl/commands/$vmID.json" -Method Delete
            if ($cmd -eq "kill") { exit 1 }
            if ($cmd -eq "restart") { Restart-Computer -Force }
        }
    } catch {}
    Start-Sleep -Seconds 10
}

