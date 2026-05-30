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

echo ">> Done. Required packages (stock repos, no AUR):"
cat <<'PKGS'
  hyprland hypridle hyprlock hyprpicker xdg-desktop-portal-hyprland
  waybar wofi swaync wpaperd alacritty cava satty grim slurp
  cliphist wl-clipboard brightnessctl playerctl pamixer
  thunar polkit hyprpolkitagent ttf-cascadia-code-nerd
  noto-fonts noto-fonts-emoji capitaine-cursors qt6ct
Install with:  sudo pacman -S <list above>
Then log into Hyprland.  Toggle theme with Super+Shift+T.
PKGS
