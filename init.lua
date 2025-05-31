--Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- enable nerdfont (install it in pc)
vim.g.have_nerd_font = true

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true


-- KEY BINDING NATIVE
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" }) -- yank to system clipboard
vim.keymap.set('n', '<leader>p', '"+p',  { desc = "Yank to system clipboard" })         -- paste from system clipboard

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')                                     -- clear highlighted text
vim.keymap.set("n", "<leader>w", ":w<CR>")                                              -- save the file
vim.keymap.set("i", "jj", "<ESC>")                                                      -- insert-mode -> normal mode

-- navigate between tabs
vim.keymap.set('n', '<S-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<S-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<S-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<S-k>', '<C-w>k', { desc = 'move focus to the upper window' })

-- splitting screen
vim.keymap.set("n", "<leader><leader>h", ":vsplit<CR>", { desc = "Vertical Split Left" })
vim.keymap.set("n", "<leader><leader>l", ":vsplit<CR>", { desc = "Vertical Split Right" })
vim.keymap.set("n", "<leader><leader>j", ":split<CR>", { desc = "Horizontal Split Down" })
vim.keymap.set("n", "<leader><leader>k", ":split<CR>", { desc = "Horizontal Split Up" })

-- resizing panes
vim.keymap.set("n", "<M-h>", "<C-w><", { desc = "Resize split left" })
vim.keymap.set("n", "<M-l>", "<C-w>>", { desc = "Resize split right" })
vim.keymap.set("n", "<M-k>", "<C-w>+", { desc = "Resize split up" })
vim.keymap.set("n", "<M-j>", "<C-w>-", { desc = "Resize split down" })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- error/warning visibility configuration
vim.diagnostic.config({
  virtual_text = true,     -- Show inline text beside the line
  signs = true,            -- Show signs in the gutter (you're already seeing this)
  underline = true,        -- Underline problematic code
  update_in_insert = false,
  severity_sort = true,
})

-- Bootstrap lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
