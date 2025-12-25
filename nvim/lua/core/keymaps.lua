local opts = { noremap = true, silent = true }

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Moving code up and down when selected
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down and auto-indent" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up and auto-indent" })

-- Moving up and down and cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up and center cursor" })

-- Search navigation with cursor centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Indentation (remains in visual mode after indenting)
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and re-select" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and re-select" })

-- Clipboard management (The "Void Register" patterns)
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over selection without losing current paste buffer" })
vim.keymap.set("v", "p", '"_dp', { desc = "Paste without overwriting register" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete into void register (don't copy)" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete character into void register" })

-- Navigation & Utilities
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlights", silent = true })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode (unintended triggers)" })

-- LSP & Refactoring
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format current buffer" })
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Tab management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>")

-- Split management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically"})
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally"})
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split equal size"})
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current Split"})

-- Move between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~") -- Gets the filepath relative to the home directory
    vim.fn.setreg("+", filePath) -- Copy to the clipboard register
    print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })
