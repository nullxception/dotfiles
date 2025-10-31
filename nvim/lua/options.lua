vim.g.mapleader = " "
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.updatetime = 50
vim.o.wrap = false

if vim.uv.os_uname().sysname == "Windows_NT" then
    if vim.fn.executable("pwsh") == 1 then
        vim.o.shell = "pwsh -NoLogo"
    elseif vim.fn.executable("powershell") == 1 then
        vim.o.shell = "powershell -NoLogo"
    end
end
