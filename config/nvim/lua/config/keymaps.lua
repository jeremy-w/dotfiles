-- see https://github.com/pbrisbin/vim-config/blob/master/vimrc
-- switch leader key; do so early, as many things read and remember during startup.
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- From More Instantly Better VIM 2013 by Damian Conway
-- http://youtu.be/aHm36-na4-4?t=9m55s
vim.keymap.set("n", ";", ":", { remap = false })
-- vim.keymap.set("n", ":", ";", { remap = false }) -- if you still want access to the ; command

-- leader shortcuts
-- select just-pasted region
vim.keymap.set("n", "<leader>v", "V`]", { remap = false })

-- Easily clear search highlighting when finished.
vim.keymap.set("n", "<leader><space>", "<cmd>nohlsearch<cr>", { remap = false })

vim.keymap.set("n", "<leader>R", "<cmd>RainbowParenthesesToggle<cr>", {
  remap = false,
  silent = true,
})

vim.keymap.set("n", "<leader>n", "<cmd>NERDTreeToggle<cr>", {
  remap = false,
  silent = true,
})

-- Disable arrow keys for navigation.
for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
  vim.keymap.set({ "n", "v", "o" }, key, "<nop>", { remap = false })
end

-- Enable commandline navigation without hardware Home/End keys
vim.keymap.set("c", "<C-A>", "<Home>", { remap = false })
vim.keymap.set("c", "<C-E>", "<End>", { remap = false })
vim.keymap.set("c", "<C-F>", "<Right>", { remap = false })
vim.keymap.set("c", "<C-B>", "<Left>", { remap = false })
vim.keymap.set("c", "<M-B>", "<S-Left>", { remap = false })
vim.keymap.set("c", "<Esc>b", "<S-Left>", { remap = false })
vim.keymap.set("c", "<M-F>", "<S-Right>", { remap = false })
vim.keymap.set("c", "<Esc>f", "<S-Right>", { remap = false })
