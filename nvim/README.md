![nvim](https://github.com/user-attachments/assets/8bd5d275-e65a-4d93-aa05-7c612f019994)

This is my **Neovim configuration** tailored for me and my machines (native win32, arch, and debian server).

Leveraging **mason.nvim**, **nvim-treesitter**, **telescope.nvim**, **conform.nvim**, **blink.cmp**, and some other plugins for a cohesive development experience, or just configuring things to justify my boredom :D

## ⚙️ Requirements

- **Neovim >= 0.12**

Because this setup relies on `mason.nvim`, `nvim-treesitter`, and `telescope.nvim`, you may need a few external tools to ensure everything runs smoothly :

- **Mason requirements:** [See here](https://github.com/mason-org/mason.nvim?tab=readme-ov-file#requirements)
- **C compiler** for Treesitter: [See here](https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements)
- **ripgrep**, will be used by [Telescope](https://github.com/nvim-telescope/telescope.nvim)

> On **Windows**, I typically use [`scoop`](https://scoop.sh) or [`winget`](https://learn.microsoft.com/en-us/windows/package-manager/winget/) to install the required tools.

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
