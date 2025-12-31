Param ([string]$Owner, [string]$MachineID)
$url = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app/vms/$MachineID.json"

Write-Host "ZUNRDP System Started - Monitoring for $MachineID" -ForegroundColor Cyan

while($true) {
    try {
        # 1. Kiểm tra lệnh Stop từ Admin/User trên Firebase trước khi gửi data
        $check = Invoke-RestMethod -Uri $url -Method Get
        if ($check.command -eq "stop" -or $check.status -eq "killing") {
            Write-Host "Nhan lenh STOP tu Panel. Dang tat may..." -ForegroundColor Red
            
            # Xóa dữ liệu trên Firebase trước khi tắt hẳn
            Invoke-RestMethod -Uri $url -Method Delete
            
            # Lệnh tắt máy ảo ngay lập tức
            Stop-Computer -Force
            exit
        }

        # 2. Thu thập thông số phần cứng
        $cpu = (Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
        $os = Get-WmiObject Win32_OperatingSystem
        $ram = [Math]::Round(((($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100), 1)
        
        # 3. Lấy IP của Tailscale
        $ip = (& "C:\Program Files\Tailscale\tailscale.exe" ip -4)
        if (!$ip) { $ip = "N/A" }

        # 4. Đóng gói dữ liệu gửi lên (Giữ lại lệnh cũ để tránh bị ghi đè mất command)
        $data = @{
            id = $MachineID; 
            ip = "$ip"; 
            owner = "$Owner";
            cpu = [Math]::Round($cpu, 1); 
            ram = $ram;
            lastSeen = [DateTimeOffset]::Now.ToUnixTimeMilliseconds();
            status = "online"
        } | ConvertTo-Json
        
        Invoke-RestMethod -Uri $url -Method Put -Body $data
    } catch { 
        Write-Host "Loi ket noi: $_" -ForegroundColor Yellow 
    }
    
    Start-Sleep -Seconds 5
}

