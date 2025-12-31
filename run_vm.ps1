param ([string]$Owner, [string]$MachineID)
$url = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app/vms/$MachineID.json"

while($true) {
    try {
        $cpu = (Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
        $os = Get-WmiObject Win32_OperatingSystem
        $ram = [Math]::Round(((($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100), 1)
        $ip = (& "C:\Program Files\Tailscale\tailscale.exe" ip -4)

        $data = @{
            id = $MachineID; ip = "$ip"; owner = "$Owner";
            cpu = [Math]::Round($cpu, 1); ram = $ram;
            lastSeen = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
        } | ConvertTo-Json
        
        Invoke-RestMethod -Uri $url -Method Put -Body $data
    } catch { Write-Host "Loi: $_" }
    Start-Sleep -Seconds 5
}

