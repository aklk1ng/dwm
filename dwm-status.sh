#! /bin/bash
# dwm状态栏刷新脚本

source ~/.profile

s2d_reset="^d^"
s2d_fg="^c"
s2d_bg="^b"
color00="#E47309^"
color01="#223344^"
color02="#80A1A1^"
color03="#3B331F^"
color04="#577C8A^"
color05="#442266^"
color06="#245566^"
color07="#7F7256^"
color08="#317561^"
color09="#CCCCCC^"
color10="#C36A20^"

others_color="$s2d_fg$color01$s2d_bg$color04"
disk_color="$s2d_fg$color09$s2d_bg$color01"
high_tem="$s2d_fg$color10$s2d_bg$color07"
mem_color="$s2d_fg$color05$s2d_bg$color07"
time_color="$s2d_fg$color01$s2d_bg$color08"
light_color="$s2d_fg$color05$s2d_bg$color10"
vol_color="$s2d_fg$color05$s2d_bg$color04"
bat_color="$s2d_fg$color03$s2d_bg$color02"

bat_signal="^sbat^"
date_signal="^sdate^"
disk_signal="^sdisk^"
mem_signal="^smem^"
icons_signal="^sicons^"
vol_signal="^svol^"
light_signal="^slight^"


print_others() {
  icons1=""
  icons2=""
  icons3="ﳲ"
  icons4=""
  icons5="ﴸ"

  text=" $icons1"
  color=$others_color
  printf "%s%s%s" "$icons_signal" "$color" "$text "
}

print_disk() {
  disk_icon="󰋊"
  used_rate=$( df -h | grep '/dev/nvme0n1p7' | awk '{print $5}' )
  text=" $disk_icon $used_rate"
  color="$disk_color"
  printf "%s%s%s " "$disk_signal" "$color" "$text"
}

print_mem() {
  cpu_tem=$[$(cat /sys/class/thermal/thermal_zone0/temp)/1000]
  if [ "$cpu_tem" -ge "60" ]; then
      cpu_color=$high_tem
  else
      cpu_color=$mem_color
  fi
  cpu_text="$cpu_tem°"

  mem_icon="󰍛"
  mem_total=$(cat /proc/meminfo | grep "MemTotal:"| awk '{print $2}')
  mem_free=$(cat /proc/meminfo | grep "MemFree:"| awk '{print $2}')
  mem_buffers=$(cat /proc/meminfo | grep "Buffers:"| awk '{print $2}')
  mem_cached=$(cat /proc/meminfo | grep -w "Cached:"| awk '{print $2}')
  men_usage_rate=$(((mem_total - mem_free - mem_buffers - mem_cached) * 100 / mem_total))
  mem_text=$(echo $men_usage_rate | awk '{printf "%02d%", $1}')

  mem_text=" $mem_icon $mem_text "
  printf "%s%s%s%s%s " "$mem_signal" "$mem_color" "$mem_text" "$cpu_color" "$cpu_text"
}

print_time() {
  icon=""
  time_text="$(date '+%m/%d %H:%M:%S')"
  text=" $icon  $time_text "
  color=$time_color
  printf "%s%s%s" "$date_signal" "$color" "$text"
}

print_light() {
  [ ! "$(command -v xbacklight)" ] && echo command not found: xbacklight && exit
  icon=""
  color=$light_color
  light_text=$(xbacklight | awk '{printf "%02d", $1}')
  text=" $icon $light_text% "
  printf "%s%s%s" "$light_signal" "$color" "$text"
}

print_vol() {
  [ ! "$(command -v pamixer)" ] && echo command not found: pamixer && exit
  volunmuted=$(pamixer --get-mute)
  vol_text=$(pamixer --get-volume)
  if [ "$vol_text" == 0 ] || [ "$volunmuted" = "true" ]
  then
    vol_text="--"
    vol_icon="󰖁"
  elif [ "$vol_text" -lt 10 ]; then vol_icon=""; vol_text=0$vol_text;
  else vol_icon=""; fi

  vol_text=$vol_text%

  text=" $vol_icon $vol_text "
  color=$vol_color
  printf "%s%s%s" "$vol_signal" "$color" "$text"
}

print_bat() {
  [ ! "$(command -v acpi)" ] && echo command not found: acpi && exit

  bat_text=$(acpi -b | sed 2d | awk '{print $4}' | grep -Eo "[0-9]+")
  [ ! "$bat_text" ] && bat_text=$(acpi -b | sed 2d | awk '{print $5}' | grep -Eo "[0-9]+")
  [ ! "$(acpi -b | grep 'Battery 0' | grep Discharging)" ] && charge_icon=""
  bat_icon="󰁹"

  bat_text=$bat_text%
  bat_icon=$bat_icon$charge_icon

  text=" $bat_icon $bat_text "
  color=$bat_color
  printf "%s%s%s" "$bat_signal" "$color" "$text"
}

xsetroot -name "$(print_others)$(print_disk)$(print_mem)$(print_time)$(print_light)$(print_vol)$(print_bat)"
