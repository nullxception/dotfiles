local M = {}

function M.is_buildable()
    return vim.fn.executable("zig") == 1 or vim.fn.executable("cmake") == 1 or vim.fn.executable("make") == 1
end

---@param plugindir string path of telescope-fzf-native
local function prepare_build(plugindir)
    local path = vim.fs.joinpath(plugindir, "build")
    if vim.fn.isdirectory(path) == 1 then
        vim.fs.rm(path, { force = true, recursive = true })
    end
    vim.fn.mkdir(path)
end

---@param plugindir string path of telescope-fzf-native
---@return string
local function libpath(plugindir)
    local ext = "so"
    if vim.uv.os_uname().sysname == "Windows_NT" then
        ext = "dll"
    end
    return vim.fs.joinpath(plugindir, "build", "libfzf." .. ext)
end

---@param plugindir string path of the telescope-fzf-native
---@param on_completed function
function M.build(plugindir, on_completed)
    if not M.is_buildable() then
        return
    end

    local output = libpath(plugindir)
    if vim.fn.executable("zig") == 1 then
        local src = vim.fs.joinpath("src", "fzf.c")
        local cmd = { "zig", "cc", "-O3", "-Wall", "-fpic", "-std=gnu99", "-shared", src, "-o", output }
        if vim.uv.os_uname().sysname == "Windows_NT" then
            vim.list_extend(cmd, { "-target", "x86_64-windows-gnu" })
        end
        prepare_build(plugindir)
        vim.system(cmd, { cwd = plugindir, text = true }):wait()
    elseif vim.fn.executable("cmake") == 1 then
        vim.system({ "cmake", "-S.", "-Bbuild", "-DCMAKE_BUILD_TYPE=Release" }, { cwd = plugindir, text = true }):wait()
        vim.system({ "cmake", "--build", "build", "--config", "Release" }, { cwd = plugindir, text = true }):wait()
    elseif vim.fn.executable("make") == 1 then
        vim.system({ "make" }, { cwd = plugindir, text = true }):wait()
    end

    if vim.uv.fs_stat(output) then
        vim.notify("successfully build libfzf")
        vim.schedule_wrap(on_completed)
    end
end

function M.load(plugindir)
    if not M.is_buildable() then
        return
    end

    local telescope = require("telescope")
    local lib = libpath(plugindir)
    if vim.uv.fs_stat(lib) then
        telescope.load_extension("fzf")
        return
    end

    M.build(plugindir, function()
        telescope.load_extension("fzf")
    end)
end

return M
