#!/bin/bash

# Kill existing Polybar instances
pkill -x polybar

# Wait until processes are closed
while pgrep -x polybar >/dev/null; do sleep 0.5; done

# Launch your bar
polybar top &

