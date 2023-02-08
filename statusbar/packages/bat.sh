#! /bin/bash
# 电池电量

notify() {
    bat_text=$(acpi -b | sed 2d | awk '{print $4}' | grep -Eo "[0-9]+")
    [ ! "$bat_text" ] && bat_text=$(acpi -b | sed 2d | awk '{print $5}' | grep -Eo "[0-9]+")
    [ ! "$(acpi -b | grep 'Battery 0' | grep Discharging)" ] && charge_icon=""
    if   [ "$bat_text" -ge 95 ]; then bat_icon=""; charge_icon="";
    elif [ "$bat_text" -ge 90 ]; then bat_icon="";
    elif [ "$bat_text" -ge 80 ]; then bat_icon="";
    elif [ "$bat_text" -ge 70 ]; then bat_icon="";
    elif [ "$bat_text" -ge 60 ]; then bat_icon="";
    elif [ "$bat_text" -ge 50 ]; then bat_icon="";
    elif [ "$bat_text" -ge 40 ]; then bat_icon="";
    elif [ "$bat_text" -ge 30 ]; then bat_icon="";
    elif [ "$bat_text" -ge 20 ]; then bat_icon="";
    elif [ "$bat_text" -ge 10 ]; then bat_icon="";
    else bat_icon=""; fi

    _status="状态: $(acpi | sed 's/^Battery 0: //g' | awk -F ',' '{print $1}')"
    _remaining="剩余: $(acpi | sed 's/^Battery 0: //g' | awk -F ',' '{print $2}' | sed 's/^[ ]//g')"
    _time="充满时间: $(acpi | sed 's/^Battery 0: //g' | awk -F ',' '{print $3}' | sed 's/^[ ]//g' | awk '{print $1}')"

    if [[ ! "$(acpi -b | grep 'Battery 0' | grep Discharging)" ]]; then
        [ "$_time" = "充满时间: " ] && _time=""
        notify-send "$bat_icon Battery" "\n$_status\n$_remaining\n$_time" -r 9527
    else
        notify-send "$bat_icon Battery" "\n$_status\n$_remaining\n" -r 9527
    fi
}

click() {
    case "$1" in
        L) notify ;;
        R) killall xfce4-power-manager-settings || xfce4-power-manager-settings & ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
esac
