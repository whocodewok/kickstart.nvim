return { -- Autoformat
    'stevearc/conform.nvim',
    event = {'BufWritePre'},
    cmd = {'ConformInfo'},
    keys = {{
        '<leader>f',
        function()
            require('conform').format {
                async = true,
                lsp_format = 'fallback'
            }
        end,
        mode = '',
        desc = '[F]ormat buffer'
    }},
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = {
                c = true,
                cpp = true
            }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = 'never'
            else
                lsp_format_opt = 'fallback'
            end
            return {
                timeout_ms = 500,
                lsp_format = lsp_format_opt
            }
        end,
        formatters_by_ft = {
            lua = {'stylua'}
            -- Conform can also run multiple formatters sequentially
            -- python = { "isort", "black" },
            --
            -- You can use 'stop_after_first' to run the first available formatter from the list
            -- javascript = { "prettierd", "prettier", stop_after_first = true },
        }
    }
}
-- 'stevearc/conform.nvim',
-- event = {"BufReadPre", "BufNewFile"},
-- config = function()
--     local conform = require("conform")

--     conform.setup({
--         formatters_by_ft = {
--             lua = {"stylua"},
--             markdown = {"prettier"}
--         },
--         format_on_save = {
--             lsp_fallback = true,
--             async = false,
--             timeout_ms = 500
--         }
--     })
--     -- Customize the "injected" formatter
--     -- conform.formatters.injected  = {
--     --     -- Set the options field
--     --     options = {
--     --         -- Set individual option values
--     --         ignore_errors = true,
--     --         lang_to_formatters = {
--     --             java = {"google-java-format"}
--     --         }
--     --     }
--     -- }
--     -- vim.keymap.set({"n", "v"}, "<leader>f", function()
--     --     conform.format({
--     --         lsp_fallback = true,
--     --         async = false,
--     --         timeout_ms = 500
--     --     })
--     -- end, {
--     --     desc = "[F]ormat file or range (in visual mode)"
--     -- })
-- end,
-- opts = {
--     notify_on_error = false,
--     lang_to_ext = {
--       bash = "sh",
--       c_sharp = "cs",
--       elixir = "exs",
--       javascript = "js",
--       julia = "jl",
--       latex = "tex",
--       markdown = "md",
--       python = "py",
--       ruby = "rb",
--       rust = "rs",
--       teal = "tl",
--       typescript = "ts",
--     },
--     -- format_on_save = function(bufnr)
--     --   -- Disable "format_on_save lsp_fallback" for languages that don't
--     --   -- have a well standardized coding style. You can add additional
--     --   -- languages here or re-enable it for the disabled ones.
--     --   local disable_filetypes = { c = true, cpp = true }
--     --   return {
--     --     timeout_ms = 500,
--     --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
--     --   }
--     -- end,
--     -- formatters_by_ft = {
--     --   lua = { 'stylua' },
--     --   -- Conform can also run multiple formatters sequentially
--     --   -- python = { "isort", "black" },
--     --   --
--     --   -- You can use a sub-list to tell conform to run *until* a formatter
--     --   -- is found.
--     --   -- javascript = { { "prettierd", "prettier" } },
--     -- },
-- }

