#!/bin/bash

declare -A last_bt_capacity

low_battery_threshold=30
critical_battery_threshold=10

send_notification() {
    local device=$1
    local msg=$2
    notify-send -h string:x-canonical-private-synchronous:bt-battery "$device" "$msg"
}

check_devices() {
    while read -r _ mac name; do
        if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
            battery=$(bluetoothctl info "$mac" | grep "Battery Percentage:" | grep -oP '\(0x[0-9a-f]+\)|\([0-9]+\)' | tr -d '()')

            if [[ -n "$battery" ]]; then
                if [[ "$battery" =~ ^0x ]]; then
                    battery_dec=$((battery))
                else
                    battery_dec=$battery
                fi

                prev_capacity="${last_bt_capacity[$mac]}"

                if [[ "$prev_capacity" != "$battery_dec" ]]; then
                    echo "[$name] Battery: ${prev_capacity:-100}% -> ${battery_dec}%"
                    last_bt_capacity["$mac"]="$battery_dec"

                    if [[ "$battery_dec" -le $low_battery_threshold && ("${prev_capacity:-100}" -gt $low_battery_threshold) ]]; then
                        send_notification "$name" "Low battery: ${battery_dec}%"
                    elif [[ "$battery_dec" -le $critical_battery_threshold && ("${prev_capacity:-100}" -gt $critical_battery_threshold) ]]; then
                        send_notification "$name" "Critical battery: ${battery_dec}%"
                    fi
                fi
            fi
        fi
    done < <(bluetoothctl devices)
}

while true; do
    check_devices
    sleep 30
done
