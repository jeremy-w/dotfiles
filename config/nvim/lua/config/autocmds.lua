local group = vim.api.nvim_create_augroup("user_config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group=group,
  pattern = { "gitcommit", "jjdescription" },
  callback = function()
    vim.opt_local.formatoptions = "qrn1jl"
    -- vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "73,74,81,82"
  end,
})

-- Code styles
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { "*.md", "*markdown", "*.htm", "*.html", "*.js", "*.coffee" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
