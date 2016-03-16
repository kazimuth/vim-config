" Start up
set nocompatible
set shell=/bin/sh
filetype off

" Setup neovim/vim compatibility stuff
if has('nvim')
    let s:vim_root = $XDG_CONFIG_HOME.'/nvim'

    let g:python_host_prog=s:vim_root.'/env/bin/python'
else
    let s:vim_root = '~/.vim'
endif

" Add extra python stuff to PATH
let $PATH .= ':'.s:vim_root.'/env/bin'

" Load plugins
call plug#begin(s:vim_root.'/plugged')

" Global plugins
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter' 
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe' ", { 'do': './install.py --clang-completer
"                                        \ --tern-completer --racer-completer' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Language-specific
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'tfnico/vim-gradle', { 'for': 'gradle' }
Plug 'wting/rust.vim', { 'for': [ 'rust', 'toml' ] }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'lambdatoast/elm.vim', { 'for': 'elm' }
Plug 'rstacruz/sparkup', { 'for': ['xml', 'html'], 'rtp': 'vim/' }
Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }
Plug 'jrozner/vim-antlr', { 'for' : 'antlr' }
Plug 'syngan/vim-vimlint', { 'for' : 'vim' }

" Syntax and formatting
" Note: syntastic conflicts with YCM on c-derived languages.
Plug 'scrooloose/syntastic', { 'for' : [ 'python', 'javascript', 'rust', 'json',
                                       \ 'html', 'xml', 'go', 'sh', 'asm', 'go',
                                       \ 'elixir', 'cabal', 'haskell', 'vim'] }

Plug 'Chiel92/vim-autoformat', { 'for' : [ 'python', 'javascript', 'rust', 'go',
                                         \ 'css', 'dart', 'c', 'cpp', 'objc' ] }

call plug#end()

" Detect filetypes
filetype plugin indent on

" Visual customization
syntax on
set background=dark
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
" set cursorline
set hidden

" Extra keybinds
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap ; :
inoremap jk <Esc>

" Because I always accidentally type :w\ and save things as "\"
ca w\ w

" Filetype configuration
au Filetype ant setl sw=2 sts=2 et
au Filetype xml setl sw=2 sts=2 et

" PLUGINS

""" Airline
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

""" YouCompleteMe
let g:ycm_enable_diagnostic_signs = 1 " in gutter
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 0 "default 0

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info

let g:ycm_use_ultisnips_completer = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" Set in local.vim:
" let g:ycm_rust_src_path = <path to rust source installation>

function! GoToDecMaybeYcm()
    if &filetype =~ 'vc\|cpp\|objc\|objcpp\|python\|cs\|rust\|javascript\|typescript'
        YcmCompleter GoTo
    else
        normal! gd
    endif
    echo ""
endfunction

nnoremap gd :call GoToDecMaybeYcm()<cr>

nnoremap <leader>d :YcmCompleter GetDoc<cr>

let g:ycm_semantic_triggers =  {
    \   'c' : ['->', '.', 're!\w'],
    \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
    \             're!\[.*\]\s', 're!\w'],
    \   'ocaml' : ['.', '#', 're!\w'],
    \   'cpp,objcpp' : ['->', '.', '::', 're!\w'],
    \   'perl' : ['->', 're!\w'],
    \   'php' : ['->', '::', 're!\w'],
    \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.', 're!\w'],
    \   'ruby' : ['.', '::', 're!\w'],
    \   'lua' : ['.', ':', 're!\w'],
    \   'erlang' : [':', 're!\w'],
    \ }

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

""" SuperTab
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabCrMapping = 0

""" Ultisnips
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<c-e>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsUsePythonVersion = 2

""" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""" Markdown
let g:vim_markdown_folding_disabled=1

""" Autoformat
nnoremap <leader>f :Autoformat<cr>

"au BufWrite *.py,*.js,*.rs,*.go,*.css,*.c,*.cpp,*.objc :Autoformat

" Source local setttings
execute "source ".s:vim_root."/local.vim"
