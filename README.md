<p align="center">
<img alt="Stargazers" src="https://images.weserv.nl/?url=avatars.githubusercontent.com/u/58150791?v=4&h=72&w=72&fit=cover&mask=circle&maxage=7d"/>
<br/><br/>
<b>~/.nullxception-dotfiles</b>
<br/><br/>
<img alt="Stargazers" src="https://img.shields.io/github/stars/nullxception/dotfiles?style=for-the-badge&logo=apachespark&logoColor=ebebf0&color=ff89b5&labelColor=33333f"/>
<img alt="License" src="https://img.shields.io/github/license/nullxception/dotfiles?style=for-the-badge&logo=gitbook&logoColor=ebebf0&color=95b6ff&labelColor=33333f"/>
<img src="https://img.shields.io/badge/deez-nuts-b0a8f7?style=for-the-badge&logo=archlinux&logoColor=ebebf0&labelColor=33333f"/>
<img alt="Repo size" src="https://img.shields.io/github/repo-size/nullxception/dotfiles?style=for-the-badge&logo=hackthebox&logoColor=ebebf0&color=73de8a&labelColor=33333f"/>
</p>

<br/>

This repo contains set of some configurations that commonly used by me for my desktop or server.<br/>
The main reason was to helps me config my fresh machine faster, but also act as an archive in case someones want to know my setup.

So, don't be shy, give it a ⭐️ if some configs can helps you somehow :)

# Installation

This dotfiles is grouped by module or package, you can just run [./dot.sh](dot.sh) followed by the package path.

```bash
./dot.sh <package>
```

for example, installing waybar and gtklock config

```bash
./dot.sh waybar gtklock
```

> **Disclaimer** ⚠️<br/>
> For things like [sys/hw](sys/hw) or [sys/systemd](sys/systemd), I suggest you to not install it directly since it's a system-wide configuration.

## About [./dot.sh](dot.sh)

[./dot.sh](dot.sh) is basically just a helper script to copy dotfiles's module.

Unlike GNU stow which populate a symlink, [./dot.sh](dot.sh) copy the actual files into defined target directory (at module's `.install`), so there's no need to keep the dotfiles repo for things to be functional.

Each module has `.install` file that will be sourced by [./dot.sh](dot.sh).
For complete example, take a look at [.install.example](.install.example).

# Gallery

| hyprland setup                                  |
| ----------------------------------------------- |
| ![hyprland setup](.github/assets/hyprland.webp) |

| firefox w/ ![custom css](firefox/) and [Cherry Midnight](https://addons.mozilla.org/en-US/firefox/addon/cherry-midnight) theme |
| ------------------------------------------------------------------------------------------------------------------------------ |
| ![firefox](.github/assets/firefox.webp)                                                                                        |

| rofi session menu                                          |
| ---------------------------------------------------------- |
| ![rofi session menu](.github/assets/rofi-session.webp?v=2) |

| gtklock                                 |
| --------------------------------------- |
| ![gtklock](.github/assets/gtklock.webp) |

# license

This dots is licensed under [BSD 3-Clause License](LICENSE).
