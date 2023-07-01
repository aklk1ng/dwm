#! /bin/bash
# DISK

notify() {
    free_result=$( df -h | grep '/dev/nvme0n1p8' | awk '{print $4}' )
    used_result=$( df -h | grep '/dev/nvme0n1p8' | awk '{print $3}' )
    text="
可用:\t $(echo "$free_result")
用量:\t $(echo "$used_result")
"
    notify-send "Disk" "$text" -r 9527
}

click() {
    case "$1" in
        L) notify ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
esac
