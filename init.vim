" Start up
set nocompatible
set shell=/bin/sh
filetype off

" Setup neovim/vim compatibility stuff
if has('nvim')
    let s:vim_root = $XDG_CONFIG_HOME.'/nvim'

    " for neovim: in local.vim:
    " let g:python_host_prog='/path/to/python'
else
    let s:vim_root = '~/.vim'
endif

" Source local settings
execute "source ".s:vim_root."/local.vim"

" Add extra python stuff to PATH
let $PATH .= ':'.s:vim_root.'/env/bin'

" Load plugins
call plug#begin(s:vim_root.'/plugged')

" Global plugins
Plug 'tpope/vim-sensible'
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'Shougo/vimproc.vim'

" Lazily loaded plugins
"" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"" Snips
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" Makers & Formatters
Plug 'neomake/neomake'
Plug 'Chiel92/vim-autoformat'

"" Other tools
Plug 'idanarye/vim-vebugger'

"" Configuration
Plug 'editorconfig/editorconfig-vim',
    \ {
    \   'for': 'lazyplugin'
    \ }

"" YCM
Plug 'Valloric/YouCompleteMe', 
    \ {
    \   'do': './install.py --clang-completer --tern-completer --racer-completer',
    \   'for': 'lazyplugin'
    \ }

" Language-specific
Plug 'jrozner/vim-antlr',           { 'for': ['antlr'] }
Plug 'michaeltanner/vim-bluespec',  { 'for': ['bluespec'] }
Plug 'rdnetto/YCM-Generator',       { 'for': ['c', 'cpp', 'cmake', 'make'], 'branch': 'stable' }
Plug 'elixir-lang/vim-elixir',      { 'for': ['elixir'] }
Plug 'lambdatoast/elm.vim',         { 'for': ['elm'] }
Plug 'dcharbon/vim-flatbuffers',    { 'for': ['fbs'] }
Plug 'tfnico/vim-gradle',           { 'for': ['gradle'] }
Plug 'eagletmt/neco-ghc',           { 'for': ['haskell'] }
Plug 'pangloss/vim-javascript',     { 'for': ['javascript'] }
Plug 'plasticboy/vim-markdown',     { 'for': ['markdown'] }
Plug 'wting/rust.vim',              { 'for': ['rust', 'toml'] }
Plug 'derekwyatt/vim-scala',        { 'for': ['scala', 'sbt', 'sbt.scala'] }
Plug 'saltstack/salt-vim',          { 'for': ['sls'] }
Plug 'vim-scripts/LanguageTool',    { 'for': ['text', 'markdown'] }
Plug 'cespare/vim-toml',            { 'for': ['toml'] }
Plug 'Quramy/tsuquyomi',            { 'for': ['typescript'] }
Plug 'leafgarland/typescript-vim',  { 'for': ['typescript'] }
Plug 'syngan/vim-vimlint',          { 'for': ['vim'] }
Plug 'tweekmonster/startuptime.vim',{ 'for': ['vim'] }
Plug 'rstacruz/sparkup',            { 'for': ['xml', 'html'], 'rtp': 'vim/' }
Plug 'b1narykid/llvm.vim',          { 'for': ['llvm', 'tablegen'], 'do': 'bash fetch.sh' }
call plug#end()

" Load some plugins lazily
" this is a dirty hack
" au BufNewFile lazyplugin setfiletype lazyplugin
" function RunLazyLoadPlugins()
"     edit lazyplugin
"     buffer 1
"     bdel! lazyplugin
"     echom "Lazy plugins loaded"
" endfunction
" let timer = timer_start(2000, 'RunLazyLoadPlugins', {'repeat': 1})

" Detect filetypes
filetype plugin indent on

" Visual customization
syntax on
set background=dark
colorscheme solarized
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set cursorline
set hidden
set spell
set spellcapcheck=

set mouse=a

" Extra keybinds
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap ; :
inoremap jk <Esc>

" Terminal keybinds
tnoremap jk <C-\><C-n>
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l

" Because I always accidentally type :w\ and save things as "\"
ca w\ w
ca w' w

" Filetype configuration
au Filetype ant setl sw=2 sts=2 et
au Filetype xml setl sw=2 sts=2 et
au Filetype javascript setl sw=2 sts=2 et
au Filetype json setl sw=2 sts=2 et
au Filetype css setl sw=2 sts=2 et

" PLUGINS

""" neco-ghc
let g:haskellmode_completion_ghc = 0
au FileType haskell setlocal omnifunc=necoghc#omnifunc

""" Airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '
let g:airline_symbols.linenr = '¶'
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
let g:ycm_semantic_triggers = {'haskell' : ['.']}

let g:ycm_use_ultisnips_completer = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" Set in local.vim:
" let g:ycm_rust_src_path = <path to rust source installation>l
" let g:ycm_extra_conf_globlist = ['~/dev/*','!~/*'] - .ycm files to load
" without prompt

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

let g:ycm_semantic_triggers = 
    \ {
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

""" Vebugger
let g:vebugger_leader='<Leader>d'
"let g:vebugger_path_gdb='rust-gdb'

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
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']
"
""" Neomake
"au! BufWritePost * Neomake

let g:neomake_error_sign = {'text': '>>', 'texthl': 'Error'}
let g:neomake_warning_sign = {'text': '>>', 'texthl': 'Todo'}
let g:neomake_message_sign = {'text': '>>', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}
let g:neomake_typescript_enabled_makers = []
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_rust_enabled_makers = []
let g:neomake_lex_enabled_makers = []

""" Tsuquyomi
let g:tsuquyomi_completion_detail = 1
let g:tsuquyomi_disable_quickfix = 1
au! BufWritePost *.ts TsuGeterrProject

""" Markdown
let g:vim_markdown_folding_disabled=1

""" Autoformat
nnoremap <leader>f :AutoFormat<cr>

""" Rustpeg & LALRPOP highlighting
au BufRead,BufNewFile *.rustpeg set filetype=rust
au BufRead,BufNewFile *.lalrpop set filetype=rust

au BufRead,BufNewFile *.mit set filetype=javascript

""" Default workspaces
" Workspace Setup
" ----------------
function! DefaultWorkspace()
    " Rough num columns to decide between laptop and big monitor screens
    vs term://fish
    file Shell
endfunction
command! -register DefaultWorkspace call DefaultWorkspace()

""" Remote stuff
command! Nbde e scp://jhgilles@notesbydave.com//home/jhgilles/
