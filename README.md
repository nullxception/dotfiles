<p align="center">
<img alt="nullxception" src="https://images.weserv.nl/?url=avatars.githubusercontent.com/u/58150791?v=5&h=128&w=128&fit=cover&mask=circle&maxage=7d"/>
<br/><br/>
<b>~/.dotfiles</b>
<br/><br/>
<a href="#"><img alt="Stargazers" src="https://img.shields.io/github/stars/nullxception/dotfiles?style=for-the-badge&logo=apachespark&logoColor=ff89b5&color=ff89b5&labelColor=33333f"/></a>
<a href="#-module-nvim"><img alt="$EDITOR" src="https://img.shields.io/badge/neovim-0.12--dev-73de8a?style=for-the-badge&logo=neovim&logoColor=73de8a&labelColor=33333f"/></a>
<a href="#-module-hypr"><img alt="$XDG_CURRENT_DESKTOP" src="https://img.shields.io/badge/hyprland-btw-62e6fa?style=for-the-badge&logo=hyprland&logoColor=62e6fa&labelColor=33333f"/></a>
<a href="LICENSE"><img alt="License" src="https://img.shields.io/github/license/nullxception/dotfiles?style=for-the-badge&logo=gitbook&logoColor=b0a8f7&color=b0a8f7&labelColor=33333f"/></a>
</p>
<br/>

This is the place where I keep the dotfiles that I use daily.<br/>
So yeah, it will definitely change from time to time :D

| hyprland                                                                                             | neovim                                                                                              |
| ---------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| ![desktop-previews](https://github.com/user-attachments/assets/95db4d04-9ac0-4293-81b9-21e57f5bf92d) | ![neovim-previews](https://github.com/user-attachments/assets/8bd5d275-e65a-4d93-aa05-7c612f019994) |

# 💻 Installation

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

That’s it! :)<br/>

Files inside the `nvim` and `zsh` dir will be copied to the location defined in respective `<module>/.install`:

- `nvim/*` to `~/.config/nvim/`
- `zsh/*` to `~/`

<details>
  <summary><h2>ⓘ About `dot.sh`</h2></summary>
  <hl/>

[`dot.sh`](dot.sh) is a minimal Bash script that automates installation by reading the `module_target` variable inside each module’s `.install` file and copying files to that target path.

Example:

```
module_target="$HOME/.config/nvim"
```

You can take a look and refer to:

- [`.install.example`](.install.example)
- [`nvim/.install`](nvim/.install)

### 🖥️ Windows Support

Windows support is available through [`dot.ps1`](dot.ps1) PowerShell script.<br/>
It mirrors similar behavior as [`dot.sh`](dot.sh), except it reads Windows-specific variable instead:

```
module_target="$HOME/.config/nvim"              # this will read by dot.sh
module_target_win32="$env:LOCALAPPDATA/nvim"    # and this is for dot.ps1
```

To use it, you can just do pretty much similar way:

```pwsh
./dot.ps1 nvim
```

This lets me sync cross-platform configs (like Neovim or WezTerm) seamlessly between Linux and Windows.

</details>

# 🧩 Module: nvim

My Neovim config leverages **mason.nvim**, **nvim-treesitter**, **telescope.nvim**, **conform.nvim**, **blink.cmp**, and some other plugins for a cohesive development experience, or just configuring things to justify my boredom :D

## 🔗 Requirements

- **Neovim >= 0.12** (for built-in `vim.pack` package manager)

Because this setup relies on `mason.nvim`, `nvim-treesitter`, and `telescope.nvim`, you may need a few external tools to ensure everything runs smoothly :

- **Mason requirements:** [See here](https://github.com/mason-org/mason.nvim?tab=readme-ov-file#requirements)
- **C compiler** for Treesitter: [See here](https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements)
- **ripgrep**, will be used by [Telescope](https://github.com/nvim-telescope/telescope.nvim)

> On **Windows**, I typically use [`scoop`](https://scoop.sh) or [`winget`](https://learn.microsoft.com/en-us/windows/package-manager/winget/) to install the required tools.

### 📝 Tips

For the [tree-sitter compiler](https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements) on _Windows_, I personally recommend using `gcc` on `mingw` for simplicity
(and also because I don't want to pull **7GB** of _Visual Studio C++ Build Tools_ 😅)

```pwsh
# using scoop
scoop install mingw

# or alternatively
# using BrechtSanders's standalone build of GCC and MinGW-w64 on winget
winget install BrechtSanders.WinLibs.POSIX.UCRT
```

## 💻 Installation

You can use the `dot.sh` or `dot.ps1` script to set it up automatically:

### Linux

```bash
./dot.sh nvim
```

### Win32 PowerShell

```pwsh
./dot.ps1 nvim
```

# 🧩 Module: hypr

It's a pretty simple hyprland setup that utilize waybar, rofi, and some other programs to help my regular desktop usage.

## ⚠ Disclaimer

My Hyprland setup is configured for my dual monitor setup, including but not limited to workspace binding.
So make sure you check and adjust the config accordingly.

## 🔗 Requirements

Below are the list of programs and scripts that currently used on this setup:

| Program/script                        | Description                                 | config                                           |
| ------------------------------------- | ------------------------------------------- | ------------------------------------------------ |
| hypridle                              | Idle daemon                                 | [hypridle.conf](hypr/hypridle.conf)              |
| hyprlock                              | Lock Screen                                 | [hyprlock.conf](hypr/hyprlock.conf)              |
| wezterm                               | Terminal emulator                           | [wezterm](wezterm)                               |
| cliphist + wl-clip-persist            | Clipboard manager                           | --                                               |
| waypaper (w/ hyprpaper or swww)       | Wallpaper manager                           | --                                               |
| waybar                                | Panel                                       | [waybar](waybar)                                 |
| mako                                  | Notification daemon                         | [mako](mako)                                     |
| [subs-volume](hypr/bin/subs-volume)   | Volume notifier                             | --                                               |
| grimblast                             | Screenshot script                           | --                                               |
| rofi                                  | App launcher                                | [rofi](rofi)                                     |
| [rofi-session](hypr/bin/rofi-session) | Session menu                                | [rofi/rofi-session.conf](rofi/rofi-session.conf) |
| rofi-polkit-agent                     | Polkit agent                                | --                                               |
| rofimoji                              | Rofi Emoji Picker                           | --                                               |
| wtype                                 | Used by rofimoji to simulate keyboard input | --                                               |

## 💻 Installation

You can copy the necessary files into your own config dirs, or deploy the configs with `dot.sh`:

```bash
# Deploy hyprland and other configs
./dot.sh waybar mako rofi hypr

```

# 📜 License

Unless otherwise noted, all code and configuration files are licensed under the [BSD 3-Clause License](LICENSE).

<p align="center"><sub>Made with ❤️, ☕, and too much neovim sessions.</sub></p>
