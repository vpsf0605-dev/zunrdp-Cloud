$baseUrl = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app"
$tsExe = "$env:ProgramFiles\Tailscale\Tailscale.exe"

# Nhận tên người sở hữu từ GitHub Action
$owner = $env:VM_OWNER 
$randomID = Get-Random -Minimum 1000 -Maximum 9999
$vmID = "$owner-$randomID" # Ví dụ: Tuan-1234

# [span_3](start_span)Đồng bộ ID máy ảo với Hostname Tailscale[span_3](end_span)
& $tsExe up --authkey=$env:TS_KEY --hostname=$vmID --accept-routes --reset

while($true) {
    try {
        $ip = (& $tsExe ip -4).Trim()
        $payload = @{
            id        = $vmID
            [span_4](start_span)owner     = $owner   # Gửi tên chủ sở hữu lên để Web lọc[span_4](end_span)
            os        = "Windows"
            ip        = $ip
            lastSeen  = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
        } | ConvertTo-Json -Compress

        Invoke-RestMethod -Uri "$baseUrl/vms/$vmID.json" -Method Put -Body $payload -ContentType "application/json"
        
        # [span_5](start_span)Kiểm tra lệnh từ Web[span_5](end_span)
        $cmd = Invoke-RestMethod -Uri "$baseUrl/commands/$vmID.json" -Method Get
        if ($cmd -and $cmd -ne "null") {
            Invoke-RestMethod -Uri "$baseUrl/commands/$vmID.json" -Method Delete
            if ($cmd -eq "kill") { exit 1 }
            if ($cmd -eq "restart") { Restart-Computer -Force }
        }
    } catch {}
    Start-Sleep -Seconds 10
}

