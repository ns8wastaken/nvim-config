-- Treesitter. Parsers are bundled from Nix (nvim-treesitter.withAllGrammars),
-- nothing is installed at runtime.
require("nvim-treesitter").setup({
    ensure_installed = {},
    auto_install = false,
    highlight = { enable = true },
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})