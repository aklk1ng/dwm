#! /bin/bash

mpc_player() {
    case $(echo -e 'mpc prev\nmpc next' | rofi -dmenu -window-title mpc -theme ~/scripts/config/rofi.rasi) in
        "mpc prev") mpc prev ;;
        "mpc next") mpc next ;;
    esac
}


case "$1" in
    mpc_player) mpc_player ;;
esac
