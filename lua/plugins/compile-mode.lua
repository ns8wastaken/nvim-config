vim.g.compile_mode = {
    -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
    -- set this to fix tab completion in command mode:
    -- input_word_completion = true,

    -- to add ANSI escape code support, add:
    baleia_setup = true,

    -- to make `:Compile` replace special characters (e.g. `%`) in
    -- the command (and behave more like `:!`), add:
    -- bang_expansion = true,
}

local map = function(mode, bind, func, desc)
    vim.keymap.set(mode, bind, func, { noremap = true, silent = true, desc = desc })
end

map('n', "<Leader>cc", "<cmd>Compile<cr>", "Compile")
map('n', "<Leader>R", "<cmd>Recompile<cr>", "Recompile")
map('n', "<Leader>cn", "<cmd>NextError<cr>", "Next compile error")
map('n', "<Leader>cp", "<cmd>PrevError<cr>", "Prev compile error")
map('n', "<Leader>cq", "<cmd>QuickfixErrors<cr>", "Send errors to quickfix")