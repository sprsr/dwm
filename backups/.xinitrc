#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

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

# start some xinit dependencies 

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#Keyboard Layout
#setxkbmap ch &

#Display Resolution
xrandr --output DP-1 --mode 2560x1440 --output HDMI-1 --mode 1920x1080 --right-of DP-1 --rotate left &
#xrandr --setmonitor vDisplay auto DP-1,HDMI-1
#Compositor 
picom -f &

#Hide Mouse in the background
unclutter &

#Pipwire Audio
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &

# Execute DWM
exec dwm

