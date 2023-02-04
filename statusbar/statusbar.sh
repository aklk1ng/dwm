#! /bin/bash

# 处理状态栏点击
click() {
    [ ! "$1" ] && return                                                 # 未传递参数时 结束
    bash ~/.config/dwm/statusbar/packages/$1.sh click $2                          # 执行指定模块脚本
}

case $1 in
    *) click $1 $2 ;; # 接收clickstatusbar传递过来的信号 $1: 模块名  $2: 按键(L|M|R|U|D)
esac
