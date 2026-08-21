require("config.options")
require("config.globals")
require("config.keymaps")
vim.g.require_dir("config.keymaps")

-- Register local custom_plugins to runtimepath
local custom_plugins = vim.api.nvim_get_runtime_file("lua/custom_plugins/*", true)
for _, plugin_dir in ipairs(custom_plugins) do
    if vim.fn.isdirectory(plugin_dir) == 1 then
        vim.opt.rtp:append(plugin_dir)
    end
end

vim.g.require_dir("plugins")

vim.g.load_colorscheme()
