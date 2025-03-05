-- Plugins for modifying vim's appearance

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Configure statusline
vim.o.fillchars = ""
vim.o.cmdheight = 1
vim.o.shortmess = "filnxtToOFcsS"

return {
  -- Colorscheme
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require("gruvbox").setup()
      vim.cmd.colorscheme('gruvbox')
    end
  },

  -- Custom statusline
  {
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        theme = 'gruvbox',
      },
      sections = {},
      tabline = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'searchcount'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
    },
  },

  -- Floating statusline
  {
    'b0o/incline.nvim',
    config = function()
      local colors = require('gruvbox').palette
      vim.o.laststatus = 3
      vim.cmd('highlight WinSeparator guibg=None guifg=' .. colors.bright_yellow)
      -- vim.o.winbar = "%=%m %f"
      require('incline').setup {
          render = function(props)
              local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
              local colors = require('gruvbox').palette

          return {
            {
              fname,
              guibg = colors.dark0_hard,
              guifg = colors.bright_yellow,
            }
          }
          end,
        window = {
          margin = {
            vertical = 0,
          },
          -- padding = 1,
          placement = {
            horizontal = "right",
            vertical = "top",
          },
        },
      }
    end
  },

  -- Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {},
        -- char = '┊',
        -- show_trailing_blankline_indent = false,
  },

  -- Tint inactive windows
  {
    'levouh/tint.nvim',
    config = function()
      require('tint').setup()
    end
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim', opts = {
      layout = {
        height = { min = 4, max = 10 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 1, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
    }
  }
}
