# Dotfiles

Personal dotfiles for a Hyprland-based Wayland desktop on Arch/Manjaro.

> **Note:** Configuration is still a work in progress, especially the Hyprland + Waybar setup.

## Installation

Requires [GNU Stow](https://www.gnu.org/software/stow/):

```bash
stow -S alacritty git hypr oh-my-posh scripts tmux waybar zsh -t $HOME
```

---

## Dependencies

### Core Wayland / Window Manager

```bash
sudo pacman -S hyprland hyprpaper hypridle hyprlock
```

### Status Bar

```bash
sudo pacman -S waybar
# Waybar weather widget (AUR)
yay -S waybar-module-pacman-updates waybar-weather
```

### Terminal & Shell

```bash
sudo pacman -S kitty alacritty zsh
```

### Shell Tools

```bash
sudo pacman -S fzf fd bat eza zoxide thefuck
# oh-my-posh (AUR)
yay -S oh-my-posh
```

> **Note:** `zinit` (Zsh plugin manager) is installed automatically by `.zshrc` via `git clone`.
> `nvm` is sourced from `/usr/share/nvm/init-nvm.sh` — install it with:
> ```bash
> sudo pacman -S nvm
> ```

### Tmux

```bash
sudo pacman -S tmux
```

> **Note:** [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager) must be installed manually:
> ```bash
> git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
> ```
> Then press `prefix + I` inside tmux to install all plugins.

### Notifications

```bash
sudo pacman -S dunst libnotify
# SwayNC notification center (AUR)
yay -S swaync
```

### Application Launcher & Power Menu

```bash
sudo pacman -S wofi
yay -S wlogout
```

### Screenshots & Clipboard

```bash
sudo pacman -S grim slurp swappy wl-clipboard
```

### File Manager

```bash
sudo pacman -S ranger nemo
```

### Audio

```bash
sudo pacman -S pipewire pipewire-pulse wireplumber pavucontrol playerctl alsa-utils
```

> `alsa-utils` provides `amixer` used for mic mute keybinds.

### Bluetooth

```bash
sudo pacman -S bluez bluez-utils blueman
```

Enable the Bluetooth service:
```bash
sudo systemctl enable --now bluetooth
```

### Network

```bash
sudo pacman -S networkmanager network-manager-applet
```

### Power Management

```bash
sudo pacman -S tlp brightnessctl
sudo systemctl enable --now tlp
```

> The waybar TLP script uses `pkexec` for privilege elevation — `polkit` must be running.

### System Utilities

```bash
sudo pacman -S udev jq python python-gobject
```

> - `udev` (part of `systemd`) is used by `battery_monitor.sh`
> - `jq` is used by the waybar TLP control script
> - `python-gobject` is required by the waybar `mediaplayer.py` script (Spotify/MPRIS integration)

### Fonts

```bash
sudo pacman -S ttf-jetbrains-mono-nerd ttf-firacode-nerd noto-fonts noto-fonts-emoji
```

> JetBrains Mono Nerd Font is used in terminals (kitty, alacritty) and hyprlock.
> FiraCode Nerd Font is used in kitty as the primary font.

### GTK / Qt Theming

```bash
sudo pacman -S adw-gtk3 qt6ct
# Set GTK dark theme and scheme in hyprland.conf via gsettings (part of glib2)
sudo pacman -S glib2
```

### Browser (optional, referenced in window rules)

```bash
# Zen Browser (AUR)
yay -S zen-browser-bin
```

---

## References

- [Zen OMP theme](https://github.com/dreamsofautonomy/zen-omp)
- [Catppuccin](https://github.com/catppuccin)
- [Hyprland Wiki](https://wiki.hyprland.org)
