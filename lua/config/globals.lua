vim.g.state_path = function(filename)
    return vim.fn.stdpath("state") .. "/" .. filename
end

-- Custom ternary function because lua doesn't have ternary operators :(
vim.g.ternary = function(condition, val_true, val_false)
    if condition then
        return val_true
    else
        return val_false
    end
end

local colorscheme_file = vim.g.state_path("colorscheme.txt")

vim.g.save_colorscheme = function()
    local f = io.open(colorscheme_file, "w")

    if f then
        f:write(vim.g.colors_name or "desert")
        f:close()
    end
end

vim.g.load_colorscheme = function()
    local f = io.open(colorscheme_file, "r")

    if f then
        local name = f:read("*l")
        f:close()
        if name and #name > 0 then
            pcall(vim.cmd.colorscheme, name)
            return
        end
    end

    -- Fallback colorscheme
    vim.cmd.colorscheme("desert")
end

vim.g.require_dir = function(module_dir)
    local fs_dir = module_dir:gsub("%.", "/")
    -- Searches whatever directory was added to runtimepath (via -u / --cmd)
    local files = vim.api.nvim_get_runtime_file("lua/" .. fs_dir .. "/*.lua", true)

    for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ":t:r")
        require(module_dir .. "." .. name)
    end
end

-- Make floating window borders rounded
vim.o.winborder = "rounded"

-- Set OS
local sysname = vim.loop.os_uname().sysname
vim.g.is_windows = sysname == "Windows_NT"
vim.g.is_linux   = sysname == "Linux"
vim.g.is_mac     = sysname == "Darwin"

vim.o.shell = vim.g.ternary(vim.g.is_windows, "powershell -NoLogo", "fish")

-- Set the <Leader> char
vim.g.mapleader = ','
