<p align="center">
<img alt="nullxception" src="https://images.weserv.nl/?url=avatars.githubusercontent.com/u/58150791?v=5&h=128&w=128&fit=cover&mask=circle&maxage=7d"/>
<br/><br/>
<b>~/.dotfiles</b>
<br/><br/>
<img alt="Stargazers" src="https://img.shields.io/github/stars/nullxception/dotfiles?style=for-the-badge&logo=apachespark&logoColor=ff89b5&color=ff89b5&labelColor=33333f"/>
<img alt="$EDITOR" src="https://img.shields.io/badge/neovim-btw-73de8a?style=for-the-badge&logo=neovim&logoColor=73de8a&labelColor=33333f"/>
<img alt="$XDG_CURRENT_DESKTOP" src="https://img.shields.io/badge/hyprland-btw-62e6fa?style=for-the-badge&logo=hyprland&logoColor=62e6fa&labelColor=33333f"/>
<img alt="License" src="https://img.shields.io/github/license/nullxception/dotfiles?style=for-the-badge&logo=gitbook&logoColor=b0a8f7&color=b0a8f7&labelColor=33333f"/>
</p>
<br/>

> This is the place where I keep the dotfiles that I use daily.<br/>
> So yeah, it will definitely change from time to time :D

| hyprland - [README.md](hypr/README.md)                                                       | neovim - [README.md](nvim/README.md)                                                     |
| -------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| ![hyprland](https://github.com/user-attachments/assets/3dc01457-e9dd-438e-8347-7f20f4919857) | ![nvim](https://github.com/user-attachments/assets/8bd5d275-e65a-4d93-aa05-7c612f019994) |

| hyprlock                                                                                     | rofi session menu                                                                                |
| -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| ![hyprlock](https://github.com/user-attachments/assets/ea2c1020-66fa-4f6d-bc5f-2b5c02000870) | ![rofi-session](https://github.com/user-attachments/assets/95587895-7dbd-4913-9b78-06563b1bdeb3) |

## 🧩 Installation

Each module in this repo is self-contained.<br/>
You can install one or multiple modules using the provided [`dot.sh`](dot.sh) script:

```bash
./dot.sh <module>
```

For example, let's say that I'm going to install my **zsh** and **neovim** config:

```bash
git clone https://github.com/nullxception/dotfiles
cd dotfiles
./dot.sh zsh nvim
```

That’s it! 🎉<br/>

Files inside the `nvim` and `zsh` dir will be copied to the location defined in respective `<module>/.install`:

- `nvim/*` to `~/.config/nvim/`
- `zsh/*` to `~/`

## ⚙️ About `dot.sh`

[`dot.sh`](dot.sh) is a minimal Bash script that automates installation by reading the `module_target` variable inside each module’s `.install` file and copying files to that target path.

Example:

```
module_target="$HOME/.config/nvim"
```

You can take a look and refer to:

- [`.install.example`](.install.example)
- [`nvim/.install`](nvim/.install)

## 🪟 Windows Support

Windows support is available through [`dot.ps1`](dot.ps1) PowerShell script.<br/>
It mirrors similar behavior as [`dot.sh`](dot.sh), except it reads Windows-specific variable instead:

```
module_target="$HOME/.config/nvim"              # this will read by dot.sh
module_target_win32="$env:LOCALAPPDATA/nvim"    # and this is for dot.ps1
```

To use it, you can just do pretty much similar way:

```powershell
./dot.ps1 nvim
```

This lets me sync cross-platform configs (like Neovim or WezTerm) seamlessly between Linux and Windows. ✨

## 📜 License

Unless otherwise noted, all code and configuration files are licensed under the [BSD 3-Clause License](LICENSE).

<p align="center"><sub>Made with ❤️, ☕, and way too many terminal sessions.</sub></p>
