-- system() doesn't like fish shell, it seems.
-- https://stackoverflow.com/questions/12230290/vim-errors-on-vim-startup-when-run-in-fish-shell
vim.opt.shell = "/bin/bash"

vim.opt.backspace = { "indent", "eol", "start" } -- allow backspacing over everything
vim.opt.scrolloff = 3
vim.opt.undofile = true

vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"

-- q: gq formatting
-- r: continue comments on Enter
-- n: numbered list awareness
-- 1: one-letter-word formatting rule
-- j: cleaner J joins
-- l: don’t rewrap already-long lines while editing
vim.opt.formatoptions = "qrn1jl"

vim.opt.modelines = 8
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.showmatch = true

-- Show nonprinting characters.
-- set nolist to disable, e.g. if manually copy-pasting from a terminal.
vim.opt.listchars = {
    eol = "⤶",
    tab = "⇶·",
    trail = "⊔",
    extends = "⋯",
    precedes = "⋯",
}
vim.opt.list = true

-- Show partial text of a line that flows out of the window,
-- rather than one @ sign per window-line.
vim.opt.display = "lastline"

vim.opt.diffopt = { "filler", "horizontal" }

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true

-- ./tags uses a tags file in the file's directory.
-- tags alone uses a file in vim's cwd.
--
-- Suffixed ; searches up till stop dir (not used here) or /.
-- See |file-searching| for details.
vim.opt.tags = { "./tags", "tags", "./tags;", "tags;" }

vim.opt.background = "dark"

-- Highlight characters in lines exceeding 80 chars
vim.opt.colorcolumn = { "80", "81" }
