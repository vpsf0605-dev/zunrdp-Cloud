param (
    [string]$Owner = "Admin",
    [string]$MachineID = "Zun-VM"
)

# 1. Start time setup
$startTime = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
$url = "https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app/vms/$MachineID.json"

Write-Host "Agent started for $MachineID"

while($true) {
    try {
        # 2. Check for kill command
        $currentData = Invoke-RestMethod -Uri $url -Method Get
        if ($currentData.command -eq "kill") {
            Write-Host "Kill command received! Shutting down..."
            # Reset command field
            $resetCmd = @{ command = "" } | ConvertTo-Json
            Invoke-RestMethod -Uri $url -Method Patch -Body $resetCmd
            
            # Shutdown Windows
            shutdown /s /f /t 0
            break
        }

        # 3. Update status to Firebase
        $ip = (tailscale ip -4)
        $lastSeen = [DateTimeOffset]::Now.ToUnixTimeMilliseconds()

        $data = @{
            id        = $MachineID
            ip        = "$ip"
            owner     = $Owner
            startTime = $startTime
            lastSeen  = $lastSeen
        } | ConvertTo-Json

        # Use Patch to update info without overwriting 'command'
        Invoke-RestMethod -Uri $url -Method Patch -Body $data
    }
    catch {
        Write-Host "Connecting to Firebase..."
    }
    Start-Sleep -Seconds 7
}

