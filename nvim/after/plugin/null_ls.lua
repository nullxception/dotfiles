local success, _ = pcall(require, "null-ls")
if not success then
    return
end

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.eslint,
    }
})
