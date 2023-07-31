""" Basic vim settings

"" General {{{
    set nocompatible
    set history=1000
    "set textwidth=120 " wrap lines after 120 characters

    set clipboard+=unnamed " share system keyboard

    set path+=** "Search down into subfolders

    set timeoutlen=1000
    set ttimeoutlen=5

    "" Searching
    set ignorecase  " case insensitive searching
    set smartcase " case-sensitive if expression contains a capital letter
    set hlsearch  " highlight search results
    set incsearch " incremental search, like modern browsers
    set nolazyredraw  " don't redraw while executing macros

    " error bells
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500

    " backups/undo
    set autoread
    set noswapfile
    set nobackup
    "set undodir=~/.vim/undodir
    "set undofile

"" }}}

"" Appearance {{{
    "" Line Numbers
    set nu rnu " relative line numbers
    autocmd FileType * set nu rnu " open all files with rnu by default

    let s:relative = 1
    function! ToggleRelative()
        if s:relative == 0
            let s:relative = 1
            set nu rnu
        else
            let s:relative = 0
            set nu nornu
        endif
    endfunction

    "" Misc
    set colorcolumn=121
    set cursorline
    set nowrap  " turn off line wrapping
    "set wrapmargin=0 " wrap lines when coming within n characters from the side
    set nolinebreak " no soft wrapping
    set showbreak=↪
    set autoindent " automatically set indent of new line
    set ttyfast " faster redrawing
    set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff " diff mode settings
    set laststatus=2 " always show the status line
    set statusline====\ %F\ %y%m%r%h%w\ %=\ [%l,%v]\ [%L,%p%%]\ %n\ === " https://www.reddit.com/r/neovim/comments/mhnza6/which_statusline_plugin_do_you_use/gt026jx/?utm_source=reddit&utm_medium=web2x&context=3
    set fillchars+=stl:=
    set fillchars+=stlnc:=
    set so=3 " set 3 lines to the cursors - when moving vertical
    set wildmenu " enhanced command line completion
    set hidden " current buffer can be put into background
    set showcmd " show incomplete commands
    set wildmode=list:longest " complete files like a shell
    set shell=$SHELL
    set cmdheight=2 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
    set mat=2 " how many tenths of a second to blink
    set updatetime=300
    set signcolumn=yes
    set shortmess+=c

    "" Cursor (from https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes)
    let &t_SI.="\e[6 q" "SI = INSERT mode
    let &t_SR.="\e[4 q" "SR = REPLACE mode
    let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)
    
    "  1 -> blinking block
    "  2 -> solid block 
    "  3 -> blinking underscore
    "  4 -> solid underscore
    "  5 -> blinking vertical bar
    "  6 -> solid vertical bar

    "" Tab control
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set tabstop=2 " number of visual spaces per TAB
    set softtabstop=2 " number of spaces in tab when editing
    set shiftwidth=2  " number of spaces that < and > insert and delete.
    set shiftround  " round indent to a multiple of 'shiftwidth'
    set expandtab " tabs are spaces

    function! IncreaseTabSpacing()
        let &tabstop=&tabstop * 2
        let &softtabstop=&tabstop
        let &shiftwidth=&tabstop
        echo 'Tab Spacing is: ' &tabstop
    endfunction

    function! DecreaseTabSpacing()
        if &tabstop > 1
            let &tabstop=&tabstop / 2
            let &softtabstop=&tabstop
            let &shiftwidth=&tabstop
        endif
        echo 'Tab Spacing is: ' &tabstop
    endfunction

    "" folding
    set foldmethod=manual " no automatic folding
    set foldlevelstart=99
    set foldnestmax=20 " deepest fold is 20 levels
    set nofoldenable " don't fold by default
    set foldlevel=1
    " zf + motion to fold.
    " zd to delete a fold, zD to recursively delete.
    " za to toggle folds, zc to close, zo to open. zA, zC, zO for recursive counterparts.
    " zr to open one level of folds. zR to open all folds.
    " zm to close one level of folds. zM to close all folds.

    "set termguicolors
    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors

    if &term =~ '256color'
        " disable background color erase
        set t_ut=""
    endif
""}}}

"" Custom Mappings {{{
    map \vv :edit ~/dotfiles/vim/vanilla.vim<cr>
    map \vp :edit ~/dotfiles/vim/plugins.vim<cr>
    "map \r :source ~/dotfiles/vim/vimrc<cr>

    "" leader key
    let mapleader = "\<Space>" 

    "" scroll
    nnoremap <c-j> <c-e>
    nnoremap <c-k> <c-y>
    map <c-h> 9zh
    map <c-l> 9zl

    "" splits
    map <silent> <leader>h :wincmd h<cr>
    map <silent> <leader>j :wincmd j<cr>
    map <silent> <leader>k :wincmd k<cr>
    map <silent> <leader>l :wincmd l<cr>
    map <silent> <leader>H :vsplit<cr>
    map <silent> <leader>J :split<cr>:wincmd j<cr>
    map <silent> <leader>K :split<cr>
    map <silent> <leader>L :vsplit<cr>:wincmd l<cr>

    "" tabs
    map <silent> <leader>t :tabnew<cr>
    map <silent> <leader>i :tabn<cr>
    map <silent> <leader>u :tabp<cr>

    "" buffers
    nmap <leader><space> :buffer 

    "" search
    nnoremap * *N
    nnoremap # #n

    "" clear highlighted search
    nmap <leader>n :noh<cr>

    "" toggle line wrapping
    " TODO: This function doesn't work properly with multiple buffers/frames
    function! Line_wrap_on()
      set wrap
      set linebreak
      noremap <silent> \w :call Line_wrap_off()<cr>
      echo 'Line wrap on!'
    endfunction
    function! Line_wrap_off()
      set nowrap
      set nolinebreak
      noremap <silent> \w :call Line_wrap_on()<cr>
      echo 'Line wrap off!'
    endfunction
    noremap <silent> \w :call Line_wrap_on()<cr>

    " keep visual selection when indenting/outdenting
    vmap < <gv
    vmap > >gv

    "" switch between current and last buffer
    nmap <leader><tab> <c-^>

    "" enable . command in visual mode
    vnoremap . :normal .<cr>

    "" Toggle visual wrap movement behavior
    nnoremap \v :call Wrap_mode_on()<cr>
    function! Wrap_mode_on()
        noremap <silent> j gj
        noremap <silent> k gk
        noremap <silent> ^ g^
        noremap <silent> $ g$
        noremap <silent> 0 g0
        noremap \v :call Wrap_mode_off()<cr>
    endfunction
    function! Wrap_mode_off()
        noremap <silent> j j
        noremap <silent> k k
        noremap <silent> ^ ^
        noremap <silent> $ $
        noremap <silent> 0 0
        noremap \v :call Wrap_mode_on()<cr>
    endfunction

    "" Toggle light and dark mode
    function! ToggleBackground()
        let &background = ( &background == "dark"? "light" : "dark" )
    endfunction
    noremap <silent> <leader>b :call ToggleBackground()<cr>
    
    "" Toggle relative line numbers
    noremap <silent> <leader>r :call ToggleRelative()<cr>

    "" Adjust Indentation Size
    noremap <leader>> :call IncreaseTabSpacing()<cr>
    noremap <leader>< :call DecreaseTabSpacing()<cr>

    "" Make Y behave like D, C, and the rest of the capital letters
    nnoremap Y y$

    "" Keeping it centered
    nnoremap n nzzzv
    nnoremap N Nzzzv

    "" Undo break points
    inoremap , ,<c-g>u
    inoremap . .<c-g>u
    inoremap ! !<c-g>u
    inoremap ? ?<c-g>u

    "" Jumplist
    nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
    nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
"" }}}

"" Colors {{{
    if !filereadable('$HOME/.vim/plugins.vim')
      "if filereadable('/Users/ogelsir/.vim/colors/gruvbox.vim')
      "  colorscheme gruvbox
      "else
      "  colorscheme default
      "endif
    endif
    syntax enable
    filetype plugin indent on
    "" make the highlighting of tabs and other non-text less annoying
    highlight SpecialKey ctermfg=19 guifg=#333333
    highlight NonText ctermfg=19 guifg=#333333
"" }}}

"" Advanced {{{
    "" See Max Cantor's 'HOW TO DO 90% OF WHAT PLUGINS DO (WITH JUST VIM)'

    "" fuzzy file search
    nmap <leader>sf :find 

    "" ctags
    command! MakeTags !ctags -R .
    nmap <leader>c :MakeTags<cr>
    " Use ^] to jump to tag under cursor
    " Use g^] for ambiguous tags
    " Use ^t to jump back up the tag stack

    "" autocomplete
    " ^x^n for JUST this file
    " ^x^f for filenames (works with our path trick!)
    " ^x^] for tags only
    " ^n for anything specified by the 'complete' option
    " ^e to cancel

    "" file browsing
    let g:netrw_banner=0        " disable annoying banner
    "let g:netrw_browse_split=4  " open in prior window
    "let g:netrw_altv=1          " open splits to the right
    let g:netrw_liststyle=3     " tree view
    "let g:netrw_list_hide=netrw_gitignore#Hide()
    "let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
    " line numbers in netrw
    let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
    " :edit a folder to open a file browser
    " <CR>/v/t to open in an h-split/v-split/tab
    " check |netrw-browse-maps| for more mappings
    nmap <leader>d :edit .<cr>
"" }}}
