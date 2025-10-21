This is my **Neovim configuration** tailored for me and my machines (native win32, arch, and debian server).

It uses **Lua** for configuration, leveraging **lazy.nvim**, **mason.nvim**, and a curated set of plugins for a cohesive development experience, or just configuring stuff on the server :D

## ⚙️ Requirements

Because this setup relies on `mason.nvim`, `nvim-treesitter`, and `telescope.nvim`,
you may need a few external tools to ensure everything runs smoothly.

- **Mason requirements:** [See here](https://github.com/mason-org/mason.nvim?tab=readme-ov-file#requirements)
- **C compiler** for Treesitter: [See here](https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements)
- **ripgrep**, required by [Telescope](https://github.com/nvim-telescope/telescope.nvim)

> 🐧 On **Linux**, these are trivial to install since we can just `apt install` them like usual.<br>
> 🪟 And on **Windows**, I typically use [`scoop`](https://scoop.sh) or [`winget`](https://learn.microsoft.com/en-us/windows/package-manager/winget/) to install the required tools.

#### 💾 Protip

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

You can use the `dot.sh` or `dot.ps1` script to set it up automatically

#### Linux

```bash
./dot.sh nvim
```

#### Win32 PowerShell

```pwsh
./dot.ps1 nvim
```
