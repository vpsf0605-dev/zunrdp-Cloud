#!/bin/bash
BASE_URL="https://zunrdp-default-rtdb.asia-southeast1.firebasedatabase.app"
OWNER=$VM_OWNER
VM_ID="$OWNER-UB-$(openssl rand -hex 2 | tr '[:lower:]' '[:upper:]')"
sudo tailscale up --authkey=$TS_KEY --hostname=$VM_ID --accept-routes --reset
while true; do
    IP=$(/usr/bin/tailscale ip -4 | head -n 1)
    JSON_DATA=$(cat <<EOF
{
  "id": "$VM_ID",
  "owner": "$OWNER",
  "os": "Ubuntu",
  "ip": "$IP",
  "user": "adminzun",
  "pass": "ZunRDP@123456",
  "lastSeen": $(date +%s%3N)
}
EOF
)
    curl -s -X PUT -H "Content-Type: application/json" -d "$JSON_DATA" "$BASE_URL/vms/$VM_ID.json" > /dev/null
    CMD=$(curl -s "$BASE_URL/commands/$VM_ID.json" | tr -d '"')
    if [ "$CMD" != "null" ] && [ -n "$CMD" ]; then
        curl -s -X DELETE "$BASE_URL/commands/$VM_ID.json" > /dev/null
        [ "$CMD" == "kill" ] && exit 1
        [ "$CMD" == "restart" ] && sudo reboot
    fi
    sleep 10
done

