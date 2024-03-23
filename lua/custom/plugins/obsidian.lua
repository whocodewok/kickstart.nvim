return {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      -- "BufReadPre /mnt/c/Logs/vimlog/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      -- "hrsh7th/nvim-cmp",
      -- "nvim-telescope/telescope.nvim",
  
      -- see below for full list of optional dependencies 👇
    },
    config = function()
      require("obsidian").setup {
        
          workspaces = {
              {
                name = "nvimlog",
                path = "/mnt/c/Logs/nvimlog",
              },
            },
            notes_subdir = "pages",
            daily_notes = {
              -- Optional, if you keep daily notes in a separate directory.
              folder = "journals",
              -- Optional, if you want to change the date format for the ID of daily notes.
              date_format = "%Y-%m-%d",
              -- Optional, if you want to change the date format of the default alias of daily notes.
              alias_format = "%B %-d, %Y",
              -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
              template = nil
            },
            completion = {
              nvim_cmp = true,
              min_chars = 2,
            },
            -- Optional, customize how note file names are generated given the ID, target directory, and title.
            note_path_func = function(spec)
              -- This is equivalent to the default behavior.
              local path = spec.dir / tostring(spec.title)
              return path:with_suffix(".md")
            end,
            -- Optional, customize how wiki links are formatted. You can set this to one of:
            --  * "use_alias_only", e.g. '[[Foo Bar]]'
            --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
            --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
            --  * "use_path_only", e.g. '[[foo-bar.md]]'
            wiki_link_func = "use_alias_only",
      
      }
    end,

    -- config = function()
    --   require("obsidian").setup()
    --   vim.keymap.set("n", "gf", function()
    --     if require("obsidian").util.cursor_on_markdown_link() then
    --       return "<cmd>ObsidianFollowLink<CR>"
    --     else
    --       return "gf"
    --     end
    --   end, { noremap = false, expr = true })
    -- end,
}