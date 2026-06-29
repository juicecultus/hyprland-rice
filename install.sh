#!/usr/bin/env bash
# Replicate the Hyprland rice on a fresh Arch install.
# Copies configs into ~/.config, scripts into ~/.local/bin, wallpapers
# into ~/Pictures/wallpapers, and patches absolute paths to your $HOME.
set -euo pipefail
cd "$(dirname "$0")"

echo ">> Installing dotfiles into \$HOME=$HOME"
mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/Pictures/wallpapers"

cp -rv .config/.      "$HOME/.config/"
cp -rv .local/bin/.   "$HOME/.local/bin/"
cp -rv wallpapers/.   "$HOME/Pictures/wallpapers/"
chmod +x "$HOME/.local/bin/"*

# wpaperd config hardcodes an absolute wallpaper path — repoint at this user.
sed -i -E "s|^path = .*/wallpapers/|path = \"$HOME/Pictures/wallpapers/|" \
    "$HOME/.config/wpaperd/config.toml" 2>/dev/null || true
# ensure it ends with the active theme + closing quote if the sed above trimmed it
grep -q '^path = ' "$HOME/.config/wpaperd/config.toml" || true

# Login launcher: auto-start Hyprland on VT1 via start-hyprland (no display
# manager). Skipped unless you opt in, so it can't clobber an existing setup.
if [ "${INSTALL_BASH_PROFILE:-0}" = "1" ]; then
    cp -v home/.bash_profile "$HOME/.bash_profile"
    echo ">> Installed ~/.bash_profile (launches start-hyprland on tty1)."
else
    echo ">> Skipped ~/.bash_profile. To auto-start Hyprland on tty1, either"
    echo "   re-run with INSTALL_BASH_PROFILE=1 ./install.sh, or copy the"
    echo "   exec line from home/.bash_profile yourself. Also enable autologin:"
    echo "   sudo systemctl edit getty@tty1  (ExecStart --autologin <user>)."
fi

echo ">> Done. Required packages (stock repos, no AUR):"
cat <<'PKGS'
  hyprland hypridle hyprlock hyprpicker xdg-desktop-portal-hyprland
  waybar wofi swaync wpaperd alacritty cava satty grim slurp
  cliphist wl-clipboard brightnessctl playerctl pamixer
  libcanberra sound-theme-freedesktop
  thunar polkit hyprpolkitagent ttf-cascadia-code-nerd
  noto-fonts noto-fonts-emoji capitaine-cursors qt6ct
Install with:  sudo pacman -S <list above>
Then log into Hyprland.  Toggle theme with Super+Shift+T.
PKGS
