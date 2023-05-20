# nullxception's dotfiles

This repo contains set of some configurations that commonly used by me for my desktop or server.

It was supposed to helps me config my fresh machine faster, but also act as an archive in case someones want to know my setup. So, don't be shy, give a ⭐️ if some configs can helps you :)

# Installation

Since this dotfiles is grouped by module, you can just run the install script followed by the module path.

```bash
./install.sh <module>
```

> for example, installing waybar and gtklock config

```bash
./install.sh waybar gtklock
```

# Gallery

| hyprland setup                                  |
| ----------------------------------------------- |
| ![hyprland setup](.github/assets/hyprland.webp) |

| firefox with custom about:newtab        |
| --------------------------------------- |
| ![firefox](.github/assets/firefox.webp) |

| rofi session menu                                          |
| ---------------------------------------------------------- |
| ![rofi session menu](.github/assets/rofi-session.webp?v=2) |

| gtklock                                 |
| --------------------------------------- |
| ![gtklock](.github/assets/gtklock.webp) |

# Structures

As you can see, the configs is grouped by module.

Each of it has their own `.install` script that will be used by the [install.sh](install.sh).

For complete example, take a look at [.install.example](.install.example).

# FAQ

> Can I use this on my machine ?

Yes you can, especially for some module like [waybar](waybar) or [hypr](hypr).

But for things like [sys/hw](sys/hw) or [sys/systemd](sys/systemd), I suggest you to NOT INSTALL it blatantly since it is a system-wide configuration.

## License

This dots is licensed under [BSD 3-Clause License](LICENSE).
