export PATH=${HOME}/.cargo/bin:${HOME}/bin:${PATH}
xrdb ~/.Xresources
setxkbmap -layout us,hu -variant altgr-intl,qwerty
setxkbmap -option 'grp:alt_shift_toggle'
exec i3
