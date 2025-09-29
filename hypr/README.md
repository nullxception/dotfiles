![hyprland](https://github.com/user-attachments/assets/3dc01457-e9dd-438e-8347-7f20f4919857)
![hyprlock](https://github.com/user-attachments/assets/ea2c1020-66fa-4f6d-bc5f-2b5c02000870)

# Hyprland setup

Here's the list of software and script that used on this setup

| Software/script                  | Description                                 | config                                                 |
| -------------------------------- | ------------------------------------------- | ------------------------------------------------------ |
| hypridle                         | Idle daemon                                 | [hypridle.conf](hypridle.conf)                         |
| hyprlock                         | Lock Screen                                 | [hyprlock.conf](hyprlock.conf)                         |
| wezterm                          | Default terminal emulator                   | [../wezterm](../wezterm)                               |
| wl-clipboard-history             | Clipboard history tracker                   | --                                                     |
| swww                             | Wallpaper daemon                            | --                                                     |
| waybar                           | Panel                                       | [../waybar](../waybar)                                 |
| mako                             | Notification daemon                         | [../mako](../mako)                                     |
| [subs-volume](bin/subs-volume)   | Volume notifier                             | --                                                     |
| grimblast                        | Screenshot script                           | --                                                     |
| rofi                             | App launcher                                | [../rofi](../rofi)                                     |
| [rofi-session](bin/rofi-session) | Session menu                                | [../rofi/rofi-session.conf](../rofi/rofi-session.conf) |
| rofi-polkit-agent                | Polkit agent                                | --                                                     |
| rofimoji                         | Rofi Emoji Picker                           | --                                                     |
| wtype                            | Used by rofimoji to simulate keyboard input | --                                                     |

# Installation

You can copy the necessary files into your own config dirs, or deploy the configs with dot.sh :

```bash
#
# from root of the dotfiles directory
#

# Deploy hyprland and other configs
./dot.sh hypr waybar mako rofi

```
