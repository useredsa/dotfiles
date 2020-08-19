#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Fix for icons not showing in dolphin
[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

# Start Xserver after initial login
if systemctl -q is-active graphical.target && [[ !$DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx
fi
