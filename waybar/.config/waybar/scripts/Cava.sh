#!/bin/bash
#!/bin/bash

LOCKFILE="/tmp/waybar-cava.lock"

# Check if cava is already running and skip starting a new one
if [ -f "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE")" 2>/dev/null; then
    exit 0
fi

# Store current PID in lockfile
echo $$ > "$LOCKFILE"

# Ensure cava is killed when this script exits (on SIGINT/SIGTERM)
cleanup() {
    rm -f "$LOCKFILE"
    pkill -P $$ cava
}
trap cleanup EXIT

# Start cava
exec cava -p ~/.config/cava/config | \
while read -r line; do
    echo "$line" | tr -d ';' | \
    sed 's/0/▁/g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g; s/8/█/g; s/9/█/g'
done

