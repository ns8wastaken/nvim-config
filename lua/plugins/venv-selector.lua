require("venv-selector").setup({
    search = {
        find_code_venvs = {
            command = "fd 'python$' ~/code/ --no-ignore --color never"
        }
    }
})

vim.keymap.set("n", "<Leader>v", "<cmd>VenvSelect<cr>", { noremap = true, silent = true })