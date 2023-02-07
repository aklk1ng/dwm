#! /bin/bash

notify() {
    notify-send "CPU tops" "\n$(ps axch -o cmd:15,%cpu --sort=-%cpu | head)\\n" -r 9527
}

call_btop() {
    pid1=`ps aux | grep 'st -t statusutil' | grep -v grep | awk '{print $2}'`
    pid2=`ps aux | grep 'st -t statusutil_cpu' | grep -v grep | awk '{print $2}'`
    mx=`xdotool getmouselocation --shell | grep X= | sed 's/X=//'`
    my=`xdotool getmouselocation --shell | grep Y= | sed 's/Y=//'`
    kill $pid1 && kill $pid2 || st -t statusutil_cpu -g 80x24+$((mx - 150))+$((my + 20)) -c FGN -e btop
}

click() {
    case "$1" in
        L) notify ;;
        M) ;;
        R) call_btop;;
        U) ;;
        D) ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
esac
