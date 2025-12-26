return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local nvimtree = require("nvim-tree")
        local api = require("nvim-tree.api")

        -- Focus logic
        vim.keymap.set("n", "<leader>e", function()
            if vim.bo.filetype == "NvimTree" then
                vim.cmd("wincmd p")
            else
                api.tree.focus()
            end
        end, { desc = "Jump between Tree and Code" })

        -- Open tree on startup AND on new tabs (Workspaces)
        vim.api.nvim_create_autocmd({ "VimEnter", "TabNewEntered" }, {
            callback = function()
                api.tree.open()
                vim.cmd("wincmd p") 
            end,
        })

        -- Auto-quit if Tree is the last window
        vim.api.nvim_create_autocmd("BufEnter", {
            nested = true,
            callback = function()
                if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
                    vim.cmd("quit")
                end
            end,
        })

        nvimtree.setup({
            sort = { sorter = "case_sensitive" },
            view = {
                width = 30,
                side = "left",
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                indent_markers = {
                    enable = true,
                    icons = { corner = "└", edge = "│", item = "│", bottom = "─", none = " ", },
                },
                icons = {
                    glyphs = {
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
            },
            update_focused_file = {
                enable = true,
                update_root = true,
            },
            filters = { dotfiles = false },
            hijack_netrw = true,
        })

        vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#1c3f6e" }) -- Deep blue lines
        vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#00f5d4", bold = true }) -- Glowing green
    end,
}
