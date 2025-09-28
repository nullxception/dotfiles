local M = {}

---@class HeaderData
local HEADER_SETTINGS = {
    data = {},
    padding_top = 0,
    padding_bottom = 0,
}

---@param tbl HeaderData
function M.build_header(tbl)
    local result = {}
    if tbl.padding_top and tbl.padding_top >= 1 then
        for _ = 1, tbl.padding_top, 1 do
            table.insert(result, [[]])
        end
    end

    for _, v in pairs(tbl.data) do
        table.insert(result, v)
    end

    if tbl.padding_bottom and tbl.padding_bottom >= 1 then
        for _ = 1, tbl.padding_bottom, 1 do
            table.insert(result, [[]])
        end
    end
    return result
end

function M.libfzf_buildcmd()
    if vim.fn.executable("cmake") == 1 then
        return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
    elseif vim.fn.executable("make") == 1 then
        return "make"
    else
        return nil
    end
end

return M
