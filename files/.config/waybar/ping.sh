#!/bin/bash

# Host to ping
HOST="8.8.8.8"

# Get ping in ms, or "N/A" if failed
PING=$(ping -c 1 $HOST 2>/dev/null | grep 'time=' | sed -E 's/.*time=([0-9.]+)/\1/')
if [ -z "$PING" ]; then
    PING="N/A"
fi

# Output JSON for Waybar
echo "[${PING}]"
