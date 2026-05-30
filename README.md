# hyprland-rice

Omarchy-style Hyprland rice (Tokyo Night / Catppuccin), built on Arch Linux for
a MacBook10,1 (12-inch 2017, retina panel @ 2x scale). Stock repos only — no AUR.

![theme](.config/themes/tokyonight/wallpaper.png)

## What's here

| Path | Purpose |
|------|---------|
| `.config/hypr/` | Hyprland, hyprlock, hypridle, color palette |
| `.config/waybar/` | Top bar (pill modules, swaync bell, battery, network) |
| `.config/wofi/` | App launcher + dedicated power-menu styling |
| `.config/swaync/` | Notification daemon + slide-out control center |
| `.config/wpaperd/` | Animated wallpaper cycler (per-theme sets, fades) |
| `.config/alacritty/` | Terminal theme |
| `.config/cava/` | Audio visualizer colors |
| `.config/themes/` | Tokyo Night ⇄ Catppuccin swap sets |
| `.local/bin/theme-toggle` | One-key full-rice theme switch (Super+Shift+T) |
| `.local/bin/powermenu` | Graphical power menu (wofi) |
| `.local/bin/term-exec` | Launcher shim to run TUI apps in alacritty |
| `wallpapers/` | Wallpaper sets → installed to `~/Pictures/wallpapers` |

## Install

```sh
git clone https://github.com/juicecultus/hyprland-rice
cd hyprland-rice
./install.sh          # copies into ~/.config, ~/.local/bin, ~/Pictures
```

`install.sh` prints the package list and repoints the wallpaper path at your
`$HOME`. Fonts: install a Nerd Font (`ttf-cascadia-code-nerd`) so the glyphs in
waybar / swaync / the power menu render.

## Keybinds (Super = ⌘)

| Key | Action |
|-----|--------|
| `Return` | terminal · `Space` launcher · `B` browser · `E` files |
| `Q` close · `F` fullscreen · `V` float · `L` lock |
| `N` notifications · `Shift+N` do-not-disturb |
| `Shift+S` region screenshot · `Shift+A` annotate (satty) · `Shift+C` color picker |
| `Shift+T` toggle Tokyo Night ⇄ Catppuccin |

## Notes

- Display is scaled `2x` (`monitor = eDP-1, preferred, auto, 2`).
- System-level MacBook tweaks (touchpad palm rejection, power-profile
  auto-switch, ambient brightness) live in a separate repo:
  **[macbook-arch-system](https://github.com/juicecultus/macbook-arch-system)**.
