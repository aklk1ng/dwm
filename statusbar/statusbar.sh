#! /bin/bash

touch ~/.config/dwm/statusbar/temp

# 设置某个模块的状态 update cpu mem ...
update() {
    [ ! "$1" ] && refresh && return                                                 # 当指定模块为空时 结束
    bash ~/.config/dwm/statusbar/packages/$1.sh                                   # 执行指定模块脚本
    shift 1; update $*                                                            # 递归调用
}

# 更新状态栏
refresh() {
    _icons=''; _disk=''; _date=''; _vol=''; _bat='';   # 重置所有模块的状态为空
    source ~/.config/dwm/statusbar/temp                                           # 从 temp 文件中读取模块的状态
    xsetroot -name "$_icons$_disk$_date$_vol$_bat"             # 更新状态栏
}

# 处理状态栏点击
click() {
    [ ! "$1" ] && return                                                 # 未传递参数时 结束
    bash ~/.config/dwm/statusbar/packages/$1.sh click $2                          # 执行指定模块脚本
    update $1                                                            # 更新指定模块
    refresh                                                              # 刷新状态栏
}


# 启动定时更新状态栏 不同的模块有不同的刷新周期 注意不要重复启动该func
cron() {
    let i=0
    while true; do
        to=()                                                            # 存放本次需要更新的模块
        [ $((i % 1)) -eq 0 ]  && to=(${to[@]} disk vol)        # 每 1秒  更新 disk vol
        [ $((i % 10)) -eq 0 ] && to=(${to[@]} bat icons)                      # 每 300秒 更新 bat
        [ $((i % 1)) -eq 0 ]   && to=(${to[@]} date)                     # 每 5秒   更新 date
        [ $i -lt 30 ] && to=(icons disk date vol bat)            # 前 30秒  更新所有模块
        update ${to[@]}                                                  # 将需要更新的模块传递给 update
        sleep 5; let i+=5
    done &
}

case $1 in
    cron) cron ;;
    updateall|check) update icons disk date vol bat ;;
    update) shift 1; update $* ;;
    *) click $1 $2 ;; # 接收clickstatusbar传递过来的信号 $1: 模块名  $2: 按键(L|M|R|U|D)
esac
