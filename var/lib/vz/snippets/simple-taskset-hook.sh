#!/bin/bash

vmid=$1
phase=$2

cpuset="0-9"

if [[ "$phase" == "post-start" ]]; then
    main_pid="$(< /run/qemu-server/$vmid.pid)"
    taskset --cpu-list --all-tasks --pid "$cpuset" "$main_pid"
fi
