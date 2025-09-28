local M = {}
local term_buf = nil
local term_win = nil

function M.toggle()
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_hide(term_win)
        term_win = nil
        return
    end

    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        vim.cmd("botright 10split")
        term_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(term_win, term_buf)
        vim.cmd("startinsert")
        return
    end

    vim.cmd("botright 10split | term")
    term_win = vim.api.nvim_get_current_win()
    term_buf = vim.api.nvim_get_current_buf()
    vim.cmd("startinsert")
end

return M
