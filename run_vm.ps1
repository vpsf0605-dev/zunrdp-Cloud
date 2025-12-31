param (
    [string]$Owner = "Admin", # Tên tài khoản thành viên
    [string]$MachineID = "Zun-VM"
)

$startTime = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
$url = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app/vms/$MachineID.json"

while($true) {
    try {
        # Kiểm tra lệnh tắt máy từ Web
        $current = Invoke-RestMethod -Uri $url -Method Get
        if ($current.command -eq "kill") {
            Invoke-RestMethod -Uri $url -Method Patch -Body (@{ command = "" } | ConvertTo-Json)
            shutdown /s /f /t 0
            break
        }

        # Lấy CPU & RAM
        $cpu = (Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
        $ram = Get-WmiObject Win32_OperatingSystem
        $ramUsage = [Math]::Round(((($ram.TotalVisibleMemorySize - $ram.FreePhysicalMemory) / $ram.TotalVisibleMemorySize) * 100), 1)

        $data = @{
            id        = $MachineID
            ip        = (tailscale ip -4)
            owner     = $Owner # Gắn máy ảo với tài khoản người dùng
            startTime = $startTime
            lastSeen  = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
            cpu       = [Math]::Round($cpu, 1)
            ram       = $ramUsage
            command   = ""
        } | ConvertTo-Json

        Invoke-RestMethod -Uri $url -Method Patch -Body $data
    } catch { }
    Start-Sleep -Seconds 5
}

