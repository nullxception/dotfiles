<p align="center">
<img alt="nullxception" src="https://images.weserv.nl/?url=avatars.githubusercontent.com/u/58150791?v=5&h=128&w=128&fit=cover&mask=circle&maxage=7d"/>
<br/><br/>
<b>~/.nullxception-dotfiles</b>
<br/><br/>
<img alt="Stargazers" src="https://img.shields.io/github/stars/nullxception/dotfiles?style=for-the-badge&logo=apachespark&logoColor=ebebf0&color=ff89b5&labelColor=33333f"/>
<img alt="License" src="https://img.shields.io/github/license/nullxception/dotfiles?style=for-the-badge&logo=gitbook&logoColor=ebebf0&color=b0a8f7&labelColor=33333f"/>
<img alt="Repo size" src="https://img.shields.io/github/repo-size/nullxception/dotfiles?style=for-the-badge&logo=hackthebox&logoColor=ebebf0&color=73de8a&labelColor=33333f"/>
</p>

<br/>

This repo contains configurations that commonly used by me for my desktop and server.<br/>
The main reason was to helps me config my fresh machine faster, but also act as an archive in case someones want to know my setup.

# Installation

This dotfiles is grouped by module or package, you can just run [./dot.sh](dot.sh) followed by the package path.

```bash
./dot.sh <package>
```

for example, installing waybar and gtklock config

```bash
./dot.sh waybar gtklock
```

## About [./dot.sh](dot.sh)

[./dot.sh](dot.sh) is basically just a helper script to copy dotfiles's package.

Unlike GNU stow which populate a symlink, [./dot.sh](dot.sh) copy the actual files into defined target directory (at package's `.install`), so there's no need to keep the dotfiles repo for things to be functional.

Each package has `.install` file that will be sourced by [./dot.sh](dot.sh).
For complete example, take a look at [.install.example](.install.example).

# Gallery

| hyprland - [README.md](hypr/README.md)          |
| ----------------------------------------------- |
| ![hyprland setup](.github/assets/hyprland.webp) |

| firefox - [README.md](firefox/README.md) |
| ---------------------------------------- |
| ![firefox](.github/assets/firefox.webp)  |

| rofi session menu                                      |
| ------------------------------------------------------ |
| ![rofi session menu](.github/assets/rofi-session.webp) |

| gtklock                                 |
| --------------------------------------- |
| ![gtklock](.github/assets/gtklock.webp) |

# license

This dots is licensed under [BSD 3-Clause License](LICENSE).
