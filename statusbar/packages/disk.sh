#! /bin/bash
# DISK

source ~/.profile

this=_disk
icon_color="^c#3B001B^^b#6873790x88^"
text_color="^c#3B001B^^b#6873790x99^"
signal=$(echo "^s$this^" | sed 's/_//')

update() {
    disk_icon="﫭"
    used_rate=$( df -h | grep '/dev/nvme0n1p7' | awk '{print $5}' )

    icon=" $disk_icon "
    text=" $used_rate "
    sed -i '/^export '$this'=.*$/d' ~/.config/dwm/statusbar/temp
    printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$icon_color" "$icon" "$text_color" "$text" >> ~/.config/dwm/statusbar/temp
}

notify() {
    free_result=$( df -h | grep '/dev/nvme0n1p7' | awk '{print $4}' )
    used_result=$( df -h | grep '/dev/nvme0n1p7' | awk '{print $3}' )
    text="
可用:\t $(echo "$free_result")
用量:\t $(echo "$used_result")
"
    notify-send "﫭Dis " "$text" -r 9527
}

call_btop() {
    pid1=`ps aux | grep 'st -t statusutil' | grep -v grep | awk '{print $2}'`
    pid2=`ps aux | grep 'st -t statusutil_mem' | grep -v grep | awk '{print $2}'`
    mx=`xdotool getmouselocation --shell | grep X= | sed 's/X=//'`
    my=`xdotool getmouselocation --shell | grep Y= | sed 's/Y=//'`
    kill $pid1 && kill $pid2 || st -t statusutil_mem -g 82x25+$((mx - 328))+$((my + 20)) -c FGN -e btop
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
    *) update ;;
esac
