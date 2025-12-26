return {
    {
        "bluz71/vim-nightfly-colors",
        name = "nightfly",
        lazy = false,
        priority = 1000,
        config = function()
            -- 1. Nightfly Core Options
            vim.g.nightflyTransparent = false
            vim.g.nightflyUndercurls = true
            vim.g.nightflyWinSeparator = 2 -- Use thick separators for better definition

            -- 2. Apply the colorscheme
            vim.cmd([[colorscheme nightfly]])

            -- 3. High-Contrast "Avatar" Overrides
            -- These specifically fix the "low contrast" issues you saw in your screenshots
            local hl = vim.api.nvim_set_hl
            
            -- Fix Bufferline: Make the selected tab "glow" emerald/cyan
            hl(0, "BufferLineIndicatorSelected", { fg = "#00f5d4" }) 
            hl(0, "BufferLineBufferSelected", { fg = "#e0f7fa", bold = true })
            
            -- Fix Lazygit & Floating Windows: Give them a sharp bioluminescent border
            hl(0, "NormalFloat", { bg = "#0a111f" }) -- Ensure float bg matches your Alacritty
            hl(0, "FloatBorder", { fg = "#00b4d8" }) 
            
            -- Fix Telescope: Saturated Cyan highlights
            hl(0, "TelescopeBorder", { fg = "#00b4d8" })
            hl(0, "TelescopePromptPrefix", { fg = "#00f5d4" })
            hl(0, "TelescopeSelection", { bg = "#1c3f6e", fg = "#ffffff" })

            -- Fix General UI: Make the line number and cursorline more visible
            hl(0, "CursorLine", { bg = "#162030" })
            hl(0, "CursorLineNr", { fg = "#00f5d4", bold = true })
            
            -- Terminal Colors: This is what Lazygit uses for its UI
            -- We force the terminal "blue" and "cyan" to be the saturated Avatar versions
            vim.g.terminal_color_4 = "#0077b6" -- Normal Blue
            vim.g.terminal_color_6 = "#00b4d8" -- Normal Cyan
            vim.g.terminal_color_12 = "#48cae4" -- Bright Cyan (Borders in Lazygit)
            vim.g.terminal_color_14 = "#00f5d4" -- Bright Emerald (Selections)
        end
    },
}
