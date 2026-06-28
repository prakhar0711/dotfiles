#!/usr/bin/env bash

## Do things to make battery life better
## Adapted for pp@arch

set -e

# Disable NMI watchdog
echo 0 > /proc/sys/kernel/nmi_watchdog

# Disable WoL and drop power to the ethernet device
ethernet_dev='enp7s0'
ethtool -s "$ethernet_dev" wol d
ip link set "$ethernet_dev" down

# VM writeback timeout (15 seconds)
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs

# Set PCI, SPI, and I2C Devices to auto power save
echo auto | tee /sys/bus/{pci,spi,i2c}/devices/*/power/control &>/dev/null || true
