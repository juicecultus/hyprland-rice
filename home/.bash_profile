#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Auto-start Hyprland on the first VT (Omarchy-style, no display manager)
if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = "1" ]; then
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_TYPE=wayland
    exec start-hyprland
fi
