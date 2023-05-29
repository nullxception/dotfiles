local success, _ = pcall(require, "flutter-tools")
if not success then
    return
end
require("flutter-tools").setup({
    widget_guides = {
        enabled = true,
    },
    dev_log = {
        open_cmd = "tabedit",
    },
})
