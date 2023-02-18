#! /bin/bash

notify() {
    volunmuted=$(pamixer --get-mute)
    vol_text=$(pamixer --get-volume)
    if [ "$vol_text" == 0 ] || [ "$volunmuted" = "true" ]; then vol_text="--"
    fi
    notify-send -r 9527 -h int:value:$vol_text -h string:hlcolor:#dddddd "Volume"
}

call_ncmpcpp() {
    pid1=`ps aux | grep 'st -t music' | grep -v grep | awk '{print $2}'`
    pid2=`ps aux | grep 'st -t music_ncmpcpp' | grep -v grep | awk '{print $2}'`
    mx=`xdotool getmouselocation --shell | grep X= | sed 's/X=//'`
    my=`xdotool getmouselocation --shell | grep Y= | sed 's/Y=//'`
    kill $pid1 && kill $pid2 || st -t music_ncmpcpp -g 40x9+$((mx - 100))+$((my)) -c FGN -A 0.7 -e ncmpcpp
}

click() {
    case "$1" in
        L) call_ncmpcpp                                     ;;
        M) pactl set-sink-mute @DEFAULT_SINK@ toggle        ;;
        R) mpc toggle;                                      ;;
        U) pactl set-sink-volume @DEFAULT_SINK@ +1%; notify ;;
        D) pactl set-sink-volume @DEFAULT_SINK@ -1%; notify ;;
    esac
}

case "$1" in
    click) click $2 ;;
esac
