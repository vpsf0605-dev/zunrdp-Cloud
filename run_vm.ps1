param (
    [string]$Owner = "Admin", 
    [string]$MachineID = "Zun-VM"
)

$startTime = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
$url = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app/vms/$MachineID.json"

while($true) {
    try {
        $current = Invoke-RestMethod -Uri $url -Method Get
        if ($current.command -eq "kill") {
            Invoke-RestMethod -Uri $url -Method Patch -Body (@{ command = "" } | ConvertTo-Json)
            shutdown /s /f /t 0
            break
        }

        # Thu thập thông số hệ thống
        $cpu = (Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
        $os = Get-WmiObject Win32_OperatingSystem
        $ramUsage = [Math]::Round(((($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100), 1)

        $data = @{
            id        = $MachineID
            ip        = (tailscale ip -4)
            owner     = $Owner
            startTime = $startTime
            lastSeen  = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
            cpu       = [Math]::Round($cpu, 1)
            ram       = $ramUsage
            status    = "Online"
        } | ConvertTo-Json

        Invoke-RestMethod -Uri $url -Method Patch -Body $data
    } catch { Write-Host "Syncing..." }
    Start-Sleep -Seconds 5
}

