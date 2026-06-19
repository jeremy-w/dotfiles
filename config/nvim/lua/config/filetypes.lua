-- Filetypes
vim.filetype.add({
  extension = {
    -- LLVM assembly files
    ll = "llvm",

    -- LLVM tablegen files
    td = "tablegen",

    -- .md should be Markdown, not Modula-2
    md = "markdown",
  },

  filename = {
    -- git-revise -i is roughly the same as git rebase -i, minus drop.
    ["git-revise-todo"] = "gitrebase",
  },
})
