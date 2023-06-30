#! /bin/bash

notify() {
    light_text=$(xbacklight | awk '{printf "%02d", $1}')

    notify-send -r 9527 -h int:value:$light_text -h string:hlcolor:#dddddd "Light"
}

click() {
    case "$1" in
        # L) notify ;;
        U) xbacklight -inc 1; notify ;;
        D) xbacklight -dec 1; notify ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
esac
