local M = {}

function M.is_buildable()
    return vim.fn.executable("zig") == 1 or vim.fn.executable("cmake") == 1 or vim.fn.executable("make") == 1
end

local function prepare_build(dir)
    local path = vim.fs.joinpath(dir, "build")
    if vim.fn.isdirectory(path) == 1 then
        vim.fs.rm(path, { force = true, recursive = true })
    end
    vim.fn.mkdir(path)
end

local function getlibdir()
    return vim.pack.get({ "telescope-fzf-native.nvim" })[1].path
end

local function getlibpath()
    local libname = "libfzf.so"
    if vim.uv.os_uname().sysname == "Windows_NT" then
        libname = "libfzf.dll"
    end
    local dir = getlibdir()
    return vim.fs.joinpath(dir, "build", libname)
end

function M.build(cb)
    if not M.is_buildable() then
        return
    end

    local dir = getlibdir()
    if vim.fn.executable("zig") == 1 then
        local cmd = { "zig", "cc", "-O3", "-Wall", "-fpic", "-std=gnu99", "-shared", "src/fzf.c" }
        if vim.uv.os_uname().sysname == "Windows_NT" then
            vim.list_extend(cmd, { "-o", "build/libfzf.dll", "-target", "x86_64-windows-gnu" })
        else
            vim.list_extend(cmd, { "-o", "build/libfzf.so" })
        end
        prepare_build(dir)
        vim.system(cmd, { cwd = dir, text = true }):wait()
    elseif vim.fn.executable("cmake") == 1 then
        vim.system({ "cmake", "-S.", "-Bbuild", "-DCMAKE_BUILD_TYPE=Release" }, { cwd = dir, text = true }):wait()
        vim.system({ "cmake", "--build", "build", "--config", "Release" }, { cwd = dir, text = true }):wait()
    elseif vim.fn.executable("make") == 1 then
        vim.system({ "make" }, { cwd = dir, text = true }):wait()
    end

    local lib = getlibpath()
    if vim.uv.fs_stat(lib) then
        vim.notify("successfully build libfzf")
        vim.schedule_wrap(cb)
    end
end

function M.load()
    if not M.is_buildable() then
        return
    end
    local telescope = require("telescope")

    local lib = getlibpath()
    if vim.uv.fs_stat(lib) then
        telescope.load_extension("fzf")
        return
    end

    M.build(function()
        telescope.load_extension("fzf")
    end)
end

return M
