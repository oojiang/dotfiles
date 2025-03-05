-- LSP related plugins and configurations

-- Keymaps for diagnostics
require('plugins.lsp.diagnostics')

-- LSP plugins
return {
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  -- used for completion, annotations and signatures of Neovim apis
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- LSP Configuration
  require('plugins.lsp.lspconfig'),

  -- Autocompletion
  require('plugins.lsp.completion'),
}
