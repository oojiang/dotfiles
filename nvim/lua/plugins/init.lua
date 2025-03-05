-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- Appearance
  require('plugins.theme'),

  -- Leap -- use `s` to move the cursor
  require('plugins.leap'),

  -- Seemlessly switch between vim and tmux panes
  require('plugins.vim-tmux-navigator'),

  -- Git
  require('plugins.git'),

  -- File browser
  require('plugins.file-browser'),

  -- Telescope
  require('plugins.telescope'),

  -- Treesitter
  require('plugins.treesitter'),

  -- LSP
  require('plugins.lsp'),

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Highlight trailing whitespace
  'ntpeters/vim-better-whitespace',
})
