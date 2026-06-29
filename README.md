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
| `.local/bin/battery-status` | waybar custom battery module (instant plug/unplug via udev) |
| `home/.bash_profile` | Auto-starts Hyprland on tty1 via `start-hyprland` |
| `wallpapers/` | Wallpaper sets → installed to `~/Pictures/wallpapers` |

## Install

```sh
git clone https://github.com/juicecultus/hyprland-rice
cd hyprland-rice
./install.sh                         # configs + scripts + wallpapers
INSTALL_BASH_PROFILE=1 ./install.sh  # also install the tty1 auto-launch
```

`install.sh` prints the package list and repoints the wallpaper path at your
`$HOME`. Fonts: install a Nerd Font (`ttf-cascadia-code-nerd`) so the glyphs in
waybar / swaync / the power menu render.

### Auto-start on login (no display manager)

`home/.bash_profile` `exec`s **`start-hyprland`** (Hyprland 0.55+'s watchdog
launcher — launching the bare `Hyprland` binary prints a "highly advised
against" warning) on VT1. Pair it with getty autologin:

```sh
sudo systemctl edit getty@tty1
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty --autologin <user> --noclear %I $TERM
```

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
- The battery indicator is a custom module (`battery-status`) so it keeps the
  exact Font Awesome glyphs. For *instant* plug/unplug reaction it relies on a
  `power_supply` udev rule that pokes waybar with `SIGRTMIN+8`; that rule ships
  in **[macbook-arch-system](https://github.com/juicecultus/macbook-arch-system)**
  (`99-waybar-battery.rules`). Without it the module still updates on its 30s
  poll fallback.
- System-level MacBook tweaks (touchpad palm rejection, power-profile
  auto-switch, ambient brightness) live in a separate repo:
  **[macbook-arch-system](https://github.com/juicecultus/macbook-arch-system)**.
