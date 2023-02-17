#! /bin/bash

source ~/.profile
nm-applet &
xrandr --dpi 192
mpd ~/.config/mpd/mpd.conf &
feh --bg-scale ~/wallpaper/wallhaven-7pjl6y.jpg &
fcitx5 &
xfce4-power-manager &
settings() {
    [ $1 ] && sleep $1
    xset s 600
    xset r rate 300 65
    syndaemon -i 1 -t -K -R -d
    # ~/scripts/set-screen.sh &
}

daemons() {
    [ $1 ] && sleep $1
    pactl info &
    flameshot &
    lemonade server &
    picom --experimental-backends --config ~/scripts/config/picom.conf &
    # ~/scripts/app-starter.sh easyeffects &
}

every1s() {
    [ $1 ] && sleep $1
    while true
    do
        $DWM/statusbar/statusbar.sh &
        $DWM/dwm-status.sh &
        ~/scripts/proxy.sh &
        sleep 1
    done
}

every1000s() {
    [ $1 ] && sleep $1
    while true
    do
        source ~/.profile
        xset -b
        # use keyd instead of xmodmap
        # xmodmap ~/scripts/config/xmodmap.conf
        sleep 1000
        # [ "$WALLPAPER_MODE" = "PIC" ] && ~/scripts/set-wallpaper.sh &
    done
}
settings 1 &
daemons 2 &
every1s 1 &
every1000s 30 &
