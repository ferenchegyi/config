return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup(
            {
                options = {
                    mode = "buffers",
                    -- This ensures the bar stays even if only one file is open
                    always_show_bufferline = true,

                    separator_style = "slant", 
                    show_buffer_close_icons = true,
                    show_close_icon = false,

                    -- TABS/WORKSPACES: Clean up the right side
                    show_tab_indicators = true, -- Keep this true to see your "1" and "2"
                    persist_buffer_sort = true,
                    enforce_regular_tabs = false,

                    -- Diagnostics (Optional: adds to the "holographic" feel)
                    diagnostics = "nvim_lsp",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "EXPLORER",
                            text_align = "center",
                            separator = true,
                        }
                    },
                    custom_areas = {
                        right = function()
                            local result = {}
                            local tab_num = vim.fn.tabpagenr()
                            local total_tabs = vim.fn.tabpagenr('$')
                            table.insert(result, { text = " 󱂬 Workspace " .. tab_num .. "/" .. total_tabs .. " ", fg = "#00f5d4" })
                            return result
                        end,
                },
                },
                highlights = {
                    -- Active Buffer (Glowing Cyan)
                    buffer_selected = {
                        fg = '#ade8f4',
                        bold = true,
                    },
                    indicator_selected = {
                        fg = '#00f5d4', -- Emerald glow
                    },
                    -- The "1" and "2" Workspace numbers on the right
                    tab_selected = {
                        fg = '#00f5d4',
                        bg = '#1c3f6e',
                    },
                }
            }
        )
    end,
}
