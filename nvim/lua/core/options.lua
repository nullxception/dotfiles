vim.o.cursorline = true
vim.o.emoji = true
vim.o.compatible = false
vim.o.backspace = "indent,eol,start"
vim.o.encoding = "utf8"
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.foldmethod = "marker"
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.laststatus = 2
vim.o.list = true
vim.o.listchars = "tab:»·,trail:·,nbsp:·"
vim.o.mouse = "a"
vim.o.showmode = false
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.termguicolors = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.visualbell = true
vim.g.mapleader = " "
vim.wo.fillchars = "eob: "
vim.opt.updatetime = 50
vim.opt.scrolloff = 8
vim.o.signcolumn = "yes"

vim.cmd([[
    filetype plugin indent on
    syntax on
]])

if vim.fn.has("win32") == 1 then
    if vim.fn.executable("pwsh") == 1 then
        vim.o.shell = "pwsh -NoLogo"
    elseif vim.fn.executable("powershell") == 1 then
        vim.o.shell = "powershell -NoLogo"
    end
end
