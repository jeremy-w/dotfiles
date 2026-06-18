vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "jjdescription" },
  callback = function()
    vim.opt_local.formatoptions = "qrn1jl"
    -- vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "73,74,81,82"
  end,
})
