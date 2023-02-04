#! /bin/bash
# DISK

notify() {
    free_result=$( df -h | grep '/dev/nvme0n1p7' | awk '{print $4}' )
    used_result=$( df -h | grep '/dev/nvme0n1p7' | awk '{print $3}' )
    text="
可用:\t $(echo "$free_result")
用量:\t $(echo "$used_result")
"
    notify-send "Disk" "$text" -r 9527
}

call_btop() {
    pid1=`ps aux | grep 'st -t statusutil' | grep -v grep | awk '{print $2}'`
    pid2=`ps aux | grep 'st -t statusutil_mem' | grep -v grep | awk '{print $2}'`
    mx=`xdotool getmouselocation --shell | grep X= | sed 's/X=//'`
    my=`xdotool getmouselocation --shell | grep Y= | sed 's/Y=//'`
    kill $pid1 && kill $pid2 || st -t statusutil_mem -g 85x30+$((mx - 250))+$((my + 40)) -c FGN -e btop
}

click() {
    case "$1" in
        L) notify ;;
        # R) call_btop ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
esac
