return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  -- "BufReadPre /mnt/c/Logs/vimlog/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  config = function()
    -- Get the current time
    local currentTime = os.time()
    -- Format the current time into "YYYYMMDD_HHMMSS" format
    local notePrefix = os.date('%Y-%m-%d_%H-%M', currentTime)
    local imagePrefix = os.date('%Y-%m-%d', currentTime)

    -- for syntax highlighting
    vim.opt.conceallevel = 1

    vim.g.vim_markdown_strikethrough = 1

    local workspace_path
    if vim.fn.has 'win32' == 1 then
      workspace_path = 'C:\\Logs\\nvimlog'
    else
      workspace_path = '/mnt/c/Logs/nvimlog'
    end
    require('obsidian').setup {
      workspaces = {
        {
          name = 'nvimlog',
          path = workspace_path,
        },
      },
      notes_subdir = 'pages',
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = 'journals',
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = '%Y-%m-%d',
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = '%B %-d, %Y',
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = 'journal-template',
      },
      -- Optional, for templates (see below).
      templates = {
        subdir = 'templates',
        date_format = '%Y-%m-%d',
        time_format = '%H-%M',
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      -- Optional, customize how note file names are generated given the ID, target directory, and title.
      note_path_func = function(spec)
        -- This is equivalent to the default behavior.
        local path = spec.dir / tostring(spec.title)
        return path:with_suffix '.md'
      end,
      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return notePrefix .. '_' .. suffix
      end,
      -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
      ---@return string
      image_name_func = function()
        -- Prefix image names with timestamp.
        return string.format('%s_', imagePrefix)
      end,
      -- Specify how to handle attachments.
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = 'assets/imgs',
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          -- Remove the prefix formatted as '%Y-%m-%d_' from the file name
          local fileName = string.gsub(path.name, "^%d%d%d%d%-%d%d%-%d%d%_", "")
          -- Remove the file type suffix such as '.png'
          fileName = string.gsub(fileName, "%.([^%.]*)$", "")
          return string.format('![%s](%s)', fileName, path)
        end,
      },
      -- Optional, customize how wiki links are formatted. You can set this to one of:
      --  * "use_alias_only", e.g. '[[Foo Bar]]'
      --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
      --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
      --  * "use_path_only", e.g. '[[foo-bar.md]]'
      wiki_link_func = 'use_alias_only',
      vim.keymap.set('n', '<leader>op', ':ObsidianPasteImg<CR>', { desc = '[O]bsidian [P]aste image' }),
      vim.keymap.set('n', '<leader>oj', ':ObsidianToday<CR>', { desc = '[O]bsidian create new [J]ournal' }),
    }
  end,
}
