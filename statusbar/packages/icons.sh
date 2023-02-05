#! /bin/bash
# ICONS 部分特殊的标记图标 这里是我自己用的，你用不上的话去掉就行

notify() {
    texts=""
    [ "$(bluetoothctl info C4:8D:8C:DA:E2:A7 | grep 'Connected: yes')" ] && texts="$texts\n 已连接"
    [ "$texts" != "" ] && notify-send " Info" "$texts" -r 9527
}

call_menu() {
    case $(echo -e ' 关机\n 重启\n 休眠\n 锁定' | rofi -dmenu -window-title power -theme ~/scripts/config/rofi.rasi) in
        " 关机") poweroff ;;
        " 重启") reboot ;;
        # Now i haven't enough swap space for hibernation
        # " 休眠") sudo systemctl hibernate ;;
        " 锁定") ~/scripts/bluelock.sh ;;
    esac
}

click() {
    case "$1" in
        # L) notify;;
        R) call_menu ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
esac
