param (
    [string]$Owner = "Admin",
    [string]$MachineID = "Zun-VM"
)

$url = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app/vms/$MachineID.json"
$startTime = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()

while($true) {
    try {
        $current = Invoke-RestMethod -Uri $url -Method Get
        if ($current.command -eq "kill") {
            shutdown /s /f /t 0
            break
        }
        $data = @{
            id = $MachineID; 
            ip = (tailscale ip -4); 
            owner = $Owner;
            lastSeen = [DateTimeOffset]::Now.ToUnixTimeMilliseconds();
            startTime = $startTime
        } | ConvertTo-Json
        Invoke-RestMethod -Uri $url -Method Patch -Body $data
    } catch {}
    Start-Sleep -Seconds 5
}

