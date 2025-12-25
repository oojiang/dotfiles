-- Use `s` to move the cursor
return {
  'ggandor/leap.nvim',
  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
    vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-cross-window)')

    vim.keymap.set(
      {'n', 'x', 'o'}, 's', function ()
        local current_window = vim.fn.win_getid()
        require('leap').leap({ target_windows = { current_window } })
      end)
  end
}
