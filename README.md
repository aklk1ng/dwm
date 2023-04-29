## Install
```plaintext
 sudo make clean install
```

## .profile
```plaintext
export DWM=~/.config/dwm
```

## .xinitrc
```plaintext
dunst -conf ~/scripts/config/dunst.conf & # a notification manager
exec dwm
```
