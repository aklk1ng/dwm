#! /bin/bash
# DATE 获取日期和时间的脚本

notify() {
    _cal=$(cal)
    notify-send "$_cal——————————————" -r 9527
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
