return {}

-- vim.api.nvim_create_autocmd("FileType", {
--     desc = "launch logseqlsp",
--     pattern = "md",
--     callback = function()
--       vim.lsp.start({
--         name = "logseq_ls",
--         cmd = { "logseqlsp" },
--         root_dir = vim.fs.dirname(vim.fs.find({ ".logseq_ls.json" }, { upward = true })[1]),
--       })
--     end
--   })

