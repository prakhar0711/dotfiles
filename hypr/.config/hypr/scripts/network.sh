#!/usr/bin/env bash

# Function to send notifications via swaync
notify_user() {
    notify-send -a "NetworkManager" -i "$1" "$2" "$3"
}

# Track state to avoid double alerts during the handshake process
LAST_STATE=""

# Using stdbuf to force line-by-line output from nmcli monitor
stdbuf -oL nmcli monitor | while read -r line; do
    # Trigger whenever a device connection status changes
    if echo "$line" | grep -qE "connected|disconnected"; then
        
        # Get current connection data
        active_conn=$(nmcli -t -f DEVICE,TYPE,CONNECTION device status | grep -E "connected" | head -n1)

        if [[ -z "$active_conn" ]]; then
            CURRENT_STATE="disconnected"
            if [[ "$LAST_STATE" != "disconnected" ]]; then
                notify_user "network-wireless-disconnected-symbolic" "Network Disconnected" "You are offline"
                LAST_STATE="disconnected"
            fi
        else
            IFACE=$(echo "$active_conn" | cut -d: -f1)
            CONN_ID=$(echo "$active_conn" | cut -d: -f3)
            CURRENT_STATE="connected:$IFACE:$CONN_ID"

            if [[ "$LAST_STATE" != "$CURRENT_STATE" ]]; then
                if [[ "$IFACE" =~ ^w ]]; then
                    notify_user "network-wireless-connected-symbolic" "Network Connected" "Connected to ${CONN_ID}"
                else
                    notify_user "network-wired-connected-symbolic" "Network Connected" "Interface ${IFACE} is up"
                fi
                LAST_STATE="$CURRENT_STATE"
            fi
        fi
    fi
done
