#/bin/sh
#
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

## merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export _JAVA_AWT_WM_NONREPARENTING=1
#xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
    
feh --bg-scale ~/Downloads/black.jpg --no-fehbg
xsetroot -cursor_name left_ptr

setxkbmap -option caps:escape -option terminate:ctrl_alt_bksp
picom &
sxhkd -c $XDG_CONFIG_HOME/sxhkd/sxhkdrc2 &
exec bspwm

#setbar &
#sxhkd & 
#exec dwm
