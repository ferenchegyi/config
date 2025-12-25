return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local nvimtree = require("nvim-tree")
        local api = require("nvim-tree.api")

        -- 1. Focus logic: Jump to tree if in code, jump to code if in tree
        vim.keymap.set("n", "<leader>e", function()
            if vim.bo.filetype == "NvimTree" then
                vim.cmd("wincmd p") -- "p" is for previous window
            else
                api.tree.focus()
            end
        end, { desc = "Jump between Tree and Code" })

        -- 2. Open tree on startup
        vim.api.nvim_create_autocmd({ "VimEnter" }, {
            callback = function()
                api.tree.open()
                vim.cmd("wincmd p") -- Jump back to the main editor window so you start typing in code
            end,
        })

        -- Quit from NVIM if the only buffer that is open is the tree
        vim.api.nvim_create_autocmd("BufEnter", {
            nested = true,
            callback = function()
                if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
                    vim.cmd("quit")
                end
            end,
        })

        -- 3. Standard Setup
        nvimtree.setup({
            sort = { sorter = "case_sensitive" },
            view = {
                width = 30,
                side = "left",
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
            },
            update_focused_file = {
                enable = true,
                update_root = true,
            },
            filters = {
                dotfiles = true,
            },
            hijack_netrw = true,
        })
    end,
}
