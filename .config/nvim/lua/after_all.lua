---@diagnostic disable: undefined-global
-- NOTE:  конфиги которые по каким-то причинам не работают внутри их require

-- asterisk
local b = vim.keymap.set
b({ "n", "v" }, "*", "<Plug>(asterisk-z*)")
b({ "n", "v" }, "#", "<Plug>(asterisk-z#)")
b({ "n", "v" }, "g*", "<Plug>(asterisk-gz*)")
b({ "n", "v" }, "g#", "<Plug>(asterisk-gz#)")

-- coc-highlight
vim.cmd([[
    autocmd CursorHold * silent call CocActionAsync('highlight')
]])
