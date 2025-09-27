![hyprland preview](../.github/assets/hyprland.webp)

# Hyprland setup

Here's the list of software and script that used on this setup

| Software/script                                      | Description               | config                                                 |
| ---------------------------------------------------- | ------------------------- | ------------------------------------------------------ |
| wezterm                                              | Default terminal emulator | [../wezterm](../wezterm)                               |
| wl-clipboard-history                                 | Clipboard history tracker | --                                                     |
| swww                                                 | Wallpaper daemon          | --                                                     |
| waybar                                               | Panel                     | [../waybar](../waybar)                                 |
| mako                                                 | Notification daemon       | [../mako](../mako)                                     |
| rofi                                                 | App launcher              | [../rofi](../rofi)                                     |
| [../bin/rofi-session](../bin/rofi-session)           | Session menu              | [../rofi/rofi-session.conf](../rofi/rofi-session.conf) |
| rofi-polkit-agent                                    | Polkit agent              | --                                                     |
| [../bin/subs-volume](../bin/subs-volume)             | Volume notifier           | --                                                     |
| [../bin/watch-waybar-conf](../bin/watch-waybar-conf) | waybar auto reloader      | --                                                     |
| swayidle                                             | Idle daemon               | --                                                     |
| gtklock                                              | Lock Screen               | [../gtklock](../gtklock)                               |
| grimblast                                            | Screenshot script         | --                                                     |

# Installation

You can copy the necessary files into your own config dirs, or deploy the configs with dot.sh :

```bash
#
# from root of the dotfiles directory
#

# Deploy hyprland and other configs
./dot.sh hypr waybar mako rofi gtklock

# Install needed scripts to your bin
install -m 755 bin/rofi-session ~/.local/bin
install -m 755 bin/subs-volume ~/.local/bin
install -m 755 bin/watch-waybar-conf ~/.local/bin
```
