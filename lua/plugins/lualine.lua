require("lualine").setup(require("lualine_themes.better_bubble"))
require("lualine").setup({
    refresh = {
        -- statusline = 250,
        -- tabline = 250,
        -- winbar = 250,
        refresh_time = 16 -- ~60 fps
    },

    -- options = { theme = 'gruvbox-material' }
})
