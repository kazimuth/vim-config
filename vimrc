" Start up
set nocompatible
set shell=/bin/sh
filetype off

" Setup neovim/vim compatibility stuff
if has('nvim')
    let s:vim_root = $XDG_CONFIG_HOME.'/nvim'

    if empty(glob(s:vim_root.'/python'))
        if !executable('virtualenv')
            echom 'Please install virtualenv'
        endif

        execute '!virtualenv '.s:vim_root.'/python'
        execute '!'.s:vim_root.'/python/bin/pip2 install -r '.s:vim_root.'/requirements.txt'
    endif

    let g:python_host_prog=s:vim_root.'/python/bin/python'
else
    let s:vim_root = '~/.vim'
endif

" Load vim-plug
if empty(glob(s:vim_root.'/autoload/plug.vim'))
    execute '!mkdir -p '.s:vim_root.'/autoload'
    execute '!curl -fLo '.s:vim_root.'/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    source s:vim_root.'/autoload/plug.vim'
endif

" Load plugins
call plug#begin(s:vim_root.'/plugged')
Plug 'tpope/vim-sensible'
Plug 'plasticboy/vim-markdown'
Plug 'bling/vim-airline'
Plug 'wting/rust.vim'
Plug 'flazz/vim-colorschemes'
Plug 'benekastah/neomake'
Plug 'Valloric/YouCompleteMe'
Plug 'cespare/vim-toml'
Plug 'racer-rust/vim-racer'
Plug 'lambdatoast/elm.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'davidhalter/jedi-vim'
Plug 'wookiehangover/jshint.vim'
Plug 'pangloss/vim-javascript'
Plug 'marijnh/tern_for_vim'
Plug 'jrozner/vim-antlr'
Plug 'Chiel92/vim-autoformat'
call plug#end()

" Detect filetypes
filetype plugin indent on

" Visual customization
syntax on
set background=dark
colorscheme solarized
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set cursorline

" Don't fold markdown
let g:vim_markdown_folding_disabled=1

" Extra keybinds
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap ; :
inoremap jk <Esc>

" Because I always accidentally type :w\ and save things as "\"
ca w\ w

" Racer / rust autocompletion stuff
set hidden
let g:ycm_semantic_triggers = { 'rust' : ['::', '.'] }

" Pull in local configuration (e.g. racer location)
execute 'source '.s:vim_root.'/local.vim'
