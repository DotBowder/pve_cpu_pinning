#!/bin/bash

vmid="$1"
phase="$2"

# Default Value
cpuset="0-8"

if [[ "$phase" == "post-start" ]]; then
    main_pid="$(< /run/qemu-server/$vmid.pid)"

    # If configured, overwrite cpuset
    if [ -f "/etc/pve/qemu-server/$vmid.cpuset" ]; then
	cpuset="$(< /etc/pve/qemu-server/$vmid.cpuset)"

    elif [ -f "/etc/pve/qemu-server/default.cpuset" ]; then
	cpuset="$(< /etc/pve/qemu-server/default.cpuset)"

    fi

    taskset --cpu-list --all-tasks --pid "$cpuset" "$main_pid"
fi
