param (
    [string]$Owner = "Admin",
    [string]$MachineID = "Zun-VM"
)

$startTime = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
$url = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app/vms/$MachineID.json"

while($true) {
    try {
        # 1. Kiểm tra lệnh từ Admin
        $current = Invoke-RestMethod -Uri $url -Method Get
        if ($current.command -eq "kill") {
            Invoke-RestMethod -Uri $url -Method Patch -Body (@{ command = "" } | ConvertTo-Json)
            shutdown /s /f /t 0
            break
        }

        # 2. Lấy thông số CPU & RAM thực tế
        $cpu = (Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
        $ram = Get-WmiObject Win32_OperatingSystem
        $ramUsage = [Math]::Round(((($ram.TotalVisibleMemorySize - $ram.FreePhysicalMemory) / $ram.TotalVisibleMemorySize) * 100), 1)

        # 3. Gửi dữ liệu về Firebase
        $data = @{
            id        = $MachineID
            ip        = (tailscale ip -4)
            owner     = $Owner
            startTime = $startTime
            lastSeen  = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
            cpu       = [Math]::Round($cpu, 1)
            ram       = $ramUsage
            command   = ""
        } | ConvertTo-Json

        Invoke-RestMethod -Uri $url -Method Patch -Body $data
    }
    catch { Write-Host "System monitoring..." }
    Start-Sleep -Seconds 5
}

