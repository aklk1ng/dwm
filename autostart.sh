#! /bin/bash

source ~/.profile
settings() {
  feh --randomize --bg-fill ~/wallpaper/*.png &
  xrandr --dpi 192
  nm-applet &
  fcitx5 &
  xset -b
  xset r rate 300 80
  xfce4-power-manager &
  syndaemon -i 1 -t -K -R -d
  # ~/scripts/set-screen.sh &
}

daemons() {
  [ $1 ] && sleep $1
  pactl info &
  picom --experimental-backends --config ~/scripts/config/picom.conf &
  mpd ~/.config/mpd/mpd.conf &
  lemonade server &
  flameshot &
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
    sleep 1000
    # [ "$WALLPAPER_MODE" = "PIC" ] && ~/scripts/set-wallpaper.sh &
  done
}

cron() {
  [ $1 ] && sleep $1
  let i=5
  while true; do
    [ $((i % 300)) -eq 0 ] && feh --randomize --bg-fill ~/wallpaper/*.png
    sleep 10;
    let i+=5
  done
}

settings &
daemons 2 &
every1s 1 &
# every1000s 30 &
cron 5 &
