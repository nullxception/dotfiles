local opt = {
    settings = {
        json = {
            format = { enable = true },
            validate = { enable = true },
        },
    },
}

local success, schemastore = pcall(require, "schemastore")
if not success then
    return opt
end

return vim.tbl_deep_extend("force", opt, { settings = { json = { schemas = schemastore.json.schemas() } } })
