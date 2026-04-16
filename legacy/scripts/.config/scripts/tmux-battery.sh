#!/usr/bin/env bash

SYS_DIR="/sys/class/power_supply"
CHARGING_ICON="⚡"
BATTERY_ICON="󰁹"

get_batteries() {
    find "$SYS_DIR" -maxdepth 1 -name "BAT*" 2>/dev/null
}

has_battery() {
    batteries=$(get_batteries)

    if [[ -z "$batteries" ]]; then
        return 1
    else
        return 0
    fi
}

get_battery_count() {
    get_batteries | wc -l
}

is_charging() {
    batteries=$(get_batteries)

    for bat in $batteries; do
        if [[ -f "$bat/status" ]]; then
            status=$(cat "$bat/status")
            if [[ "$status" == "Charging" ]]; then
                return 0
            fi
        fi
    done
    return 1
}

get_average_level() {
    batteries=$(get_batteries)

    local total_level=0
    local count=0

    for bat in $batteries; do
        if [[ -f "$bat/capacity" ]]; then
            capacity=$(cat "$bat/capacity")
            total_level=$((total_level + capacity))
            count=$((count + 1))
        fi
    done

    if [[ $count -eq 0 ]]; then
        echo "0"
    else
        echo $((total_level / count))
    fi
}

main() {
    if ! has_battery; then
        exit 0
    fi

    count=$(get_battery_count)
    level=$(get_average_level)

    if is_charging; then
        echo "${CHARGING_ICON}${level}%"
    else
        echo "${BATTERY_ICON} ${level}%"
    fi
}

main
