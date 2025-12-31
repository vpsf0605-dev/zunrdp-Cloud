$baseUrl = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app"
$tsExe = "$env:ProgramFiles\Tailscale\Tailscale.exe"

# Lấy thông tin từ GitHub Action truyền vào
$owner = $env:VM_OWNER
$randomID = Get-Random -Minimum 1000 -Maximum 9999
$vmID = "$owner-$randomID" # ID đồng bộ: TênUser-1234

# Đồng bộ Hostname Tailscale với ID
& $tsExe up --authkey=$env:TS_KEY --hostname=$vmID --accept-routes --reset

while($true) {
    try {
        $ip = (& $tsExe ip -4).Trim()
        $payload = @{
            id        = $vmID
            owner     = $owner   # Trường dùng để lọc trên Web
            os        = "Windows"
            ip        = $ip
            lastSeen  = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
        } | ConvertTo-Json -Compress

        Invoke-RestMethod -Uri "$baseUrl/vms/$vmID.json" -Method Put -Body $payload -ContentType "application/json"
        
        # Kiểm tra lệnh Reset/Kill
        $cmd = Invoke-RestMethod -Uri "$baseUrl/commands/$vmID.json" -Method Get
        if ($cmd -and $cmd -ne "null") {
            Invoke-RestMethod -Uri "$baseUrl/commands/$vmID.json" -Method Delete
            if ($cmd -eq "kill") { exit 1 }
            if ($cmd -eq "restart") { Restart-Computer -Force }
        }
    } catch {}
    Start-Sleep -Seconds 10
}

