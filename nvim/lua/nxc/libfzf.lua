local M = {}

function M.is_buildable()
    return vim.fn.executable("zig") == 1 or vim.fn.executable("cmake") == 1 or vim.fn.executable("make") == 1
end

---@module "lazy"
---@param plugin LazyPlugin
function M.prepare_build(plugin)
    local dir = vim.fs.joinpath(plugin.dir, "build")
    if vim.fn.isdirectory(dir) == 1 then
        vim.fs.rm(dir, { force = true, recursive = true })
    end
    vim.fn.mkdir(dir)
end

function M.build()
    if vim.fn.executable("zig") == 1 then
        local ext = ".so"
        if vim.fn.has("win32") then
            ext = ".dll -target x86_64-windows-gnu"
        end
        return {
            M.prepare_build,
            "zig cc -O3 -Wall -fpic -std=gnu99 -shared src/fzf.c -o build/libfzf" .. ext,
        }
    elseif vim.fn.executable("cmake") == 1 then
        return {
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release",
            "cmake --build build --config Release",
        }
    elseif vim.fn.executable("make") == 1 then
        return "make"
    else
        return nil
    end
end

---@module "lazy"
---@param plugin LazyPlugin
function M.load(plugin)
    local libname = "libfzf.so"
    if vim.fn.has("win32") then
        libname = "libfzf.dll"
    end
    local libpath = vim.fs.joinpath(plugin.dir, "build", libname)
    if vim.uv.fs_stat(libpath) then
        require("telescope").load_extension("fzf")
    end
end

return M
