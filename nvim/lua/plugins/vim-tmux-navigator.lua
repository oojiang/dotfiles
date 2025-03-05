-- Seemlessly switch between vim and tmux panes
return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  config = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.keymap.set('n', '<M-H>', '<cmd>TmuxNavigateLeft<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<M-J>', '<cmd>TmuxNavigateDown<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<M-K>', '<cmd>TmuxNavigateUp<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<M-L>', '<cmd>TmuxNavigateRight<CR>', { silent = true, noremap = true })

    -- g:tmux_navigator_no_mappings doesn't work, so I need to reset these keybinds from vanilla.vim.
    -- Scroll window up/down
    vim.keymap.set('n', '<C-j>', '<C-e>', { noremap = true })
    vim.keymap.set('n', '<C-k>', '<C-y>', { noremap = true })

    -- Scroll window left/right
    vim.keymap.set('', '<C-h>', '9zh', { noremap = false })  -- note: using '' for mode means normal + visual
    vim.keymap.set('', '<C-l>', '9zl', { noremap = false })
  end
}
