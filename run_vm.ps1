param (
    [string]$Owner = "Admin",
    [string]$MachineID = "Windows-VM"
)

# 1. Ghi lai moc thoi gian bat dau duy nhat 1 lan
$startTime = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()

$url = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app/vms/$MachineID.json"

while($true) {
    try {
        # Lay IP tu Tailscale
        $ip = (tailscale ip -4)
        $lastSeen = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()

        # Dong goi du lieu de Web hien thi Uptime va Owner
        $data = @{
            id        = $MachineID
            ip        = $ip
            owner     = $Owner
            startTime = $startTime
            lastSeen  = $lastSeen
            os        = "Windows Server"
        } | ConvertTo-Json

        # Gui len Firebase
        Invoke-RestMethod -Uri $url -Method Put -Body $data
    }
    catch {
        Write-Host "Loi gui tin hieu: $_"
    }
    
    # Moi 10 giay gui tin hieu 1 lan de tiet kiem bang thong
    Start-Sleep -Seconds 10
}

