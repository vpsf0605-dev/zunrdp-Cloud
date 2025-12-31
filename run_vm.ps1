param (
    [string]$Owner = "Admin",
    [string]$MachineID = "Zun-VM"
)

# 1. Ghi lại mốc thời gian bắt đầu duy nhất 1 lần
$startTime = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
$url = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app/vms/$MachineID.json"

Write-Host "Agent started for $MachineID"

while($true) {
    try {
        # 2. Kiểm tra lệnh từ Firebase
        $currentData = Invoke-RestMethod -Uri $url -Method Get
        if ($currentData.command -eq "kill") {
            Write-Host "NHẬN LỆNH TẮT MÁY! Đang sập nguồn..."
            # Xóa lệnh kill trước khi tắt để tránh vòng lặp
            $resetCmd = @{ command = "" } | ConvertTo-Json
            Invoke-RestMethod -Uri $url -Method Patch -Body $resetCmd
            
            # Thực hiện tắt máy ngay lập tức
            shutdown /s /f /t 0
            break
        }

        # 3. Gửi tín hiệu Online & Uptime
        $ip = (tailscale ip -4)
        $lastSeen = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()

        $data = @{
            id        = $MachineID
            ip        = $ip
            owner     = $Owner
            startTime = $startTime
            lastSeen  = $lastSeen
            command   = ""
        } | ConvertTo-Json

        # Dùng PATCH để không đè lên lệnh command nếu Web vừa gửi
        Invoke-RestMethod -Uri $url -Method Patch -Body $data
    }
    catch {
        Write-Host "Lỗi kết nối Firebase, đang thử lại..."
    }
    Start-Sleep -Seconds 7
}

