-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Toggle inline error messages
vim.diagnostic.config({ virtual_text = true }) -- Default to inline messages ON
vim.keymap.set('n', '<leader>di',
  function()
    local current_config = vim.diagnostic.config()
    local current_virtual_text = current_config.virtual_text

    -- Toggle the virtual text setting
    vim.diagnostic.config({
      virtual_text = not current_virtual_text
    })

    if current_virtual_text then
      print("Inline error messages are now OFF")
    else
      print("Inline error messages are now ON")
    end
  end, { noremap = true, silent = true })
