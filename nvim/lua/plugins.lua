vim.cmd [[packadd packer.nvim]]

require('packer').startup(
  function()
    use [[wbthomason/packer.nvim]]
    use [[rafi/awesome-vim-colorschemes]]
    use [[neovim/nvim-lspconfig]]
    use { 'ms-jpq/coq_nvim', branch = 'coq' }
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
    use { 'ms-jpq/chadtree', branch = 'chad', 
      run = function()
        vim.fn.system('python3 -m chadtree deps')
        vim.cmd('CHADdeps')
      end
    }
    use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
    use {'nvim-telescope/telescope-fzy-native.nvim'}
    -- use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
    -- use {'junegunn/fzf.vim'}
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  end
)

-- Gruvbox Colorscheme 
local current_time = os.date("*t")
if current_time.hour >= 19 or current_time.hour <= 5 then
  vim.o.background = 'dark' else vim.o.background = 'light'
end
vim.g.gruvbox_contrast_light = 'hard'
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd [[colo gruvbox]]
vim.cmd [[highlight MatchParen ctermbg=none]]

function ToggleBackground()
  if vim.o.background == 'light' then
    vim.o.background = 'dark'
  else
    vim.o.background = 'light'
  end
  vim.cmd [[highlight MatchParen ctermbg=none]]
end
vim.api.nvim_set_keymap('n', '<leader>b', ':lua ToggleBackground()<cr>', {noremap = true, silent = true})

-- Fuzzy Finder
-- vim.api.nvim_set_keymap('n', '<leader>f', ':Files<cr>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<C-p>', ':GFiles<cr>', {noremap = true})
local telescope = require'telescope'
telescope.setup{
  defaults = {
    filesorter = require'telescope.sorters'.get_fzy_sorter,
    -- prompt_prefix = ' >',
    -- color_devicons = true,

    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    gflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- mappings = {}
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}
telescope.load_extension('fzy_native')
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<cr>', {noremap = true})


-- CHADtree
vim.g.chadtree_settings = {
  view = {
    window_options = {
      cursorline = true,
      number = true,
      relativenumber = true,
      signcolumn = "no",
      winfixwidth = true,
      wrap = false
    }
  }
}
vim.api.nvim_set_keymap('n', '<leader>d', ':CHADopen --always-focus<cr>', {})

-- COQ
local coq = require'coq'
vim.g.coq_settings = {
  ["auto_start"] = "shut-up",
  ["keymap.recommended"] = false,
  ["keymap.manual_complete"] = true,
  ["keymap.manual_complete"] = "<M-space>",
  ["keymap.bigger_preview"] = "<c-k>",
  ["keymap.jump_to_mark"] = "<c-h>",
}
vim.cmd [[ " Keybindings
ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
]]

-- lspconfig
local nvim_lsp = require'lspconfig'

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({on_attach = on_attach}))
end

-- LaTeX
vim.cmd [[autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!]]
