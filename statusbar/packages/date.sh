#! /bin/bash
# DATE 获取日期和时间的脚本

notify() {
    # _cal=$(cal --color=always | sed 's/..7m/<b><span color="#ff79c6">/;s/..27m/<\/span><\/b>/' )
    _cal=$(cal --color=always)
    notify-send "  Calendar" "\n$_cal\n————————————————————" -r 9527
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
