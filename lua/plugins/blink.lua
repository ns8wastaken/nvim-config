require("blink.cmp").setup({
    fuzzy = {
        sorts = {
            "exact",
            "score",
            "sort_text"
        }
    },

    snippets = { preset = "luasnip" },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" }
    }
})