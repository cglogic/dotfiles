set nocompatible
filetype off

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'

Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'matze/vim-move'
Plug 'rhysd/vim-clang-format'

Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
"Plug 'edkolev/tmuxline.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'Valloric/YouCompleteMe'
"Plug 'jeaye/color_coded'
"Plug 'bbchung/clighter8'
"Plug 'rdnetto/YCM-Generator'

Plug 'neomake/neomake'
"Plug 'wincent/terminus'

call plug#end()
filetype plugin indent on

"set ttyfast
"set lazyredraw

set shell=/bin/sh

"nmap <C-o> :tabnew<cr>
"nmap <C-tab> :tabnext<cr>

set mouse-=a
set noundofile
set hidden
set nowildmenu
set dy=lastline

set fileencodings=utf-8
set termencoding=utf-8
set fileformat=unix

set background=dark

"let g:jellybeans_overrides = {
"	\    'background': { 'ctermbg': '0', '256ctermbg': '0' },
"\}

"let base16colorspace=256
"colorscheme base16-default-dark
"Tomorrow-Night jellybeans

if (&t_Co == 256 || &t_Co == 88)
    colorscheme Tomorrow-Night
else
    colorscheme base16-default-dark
endif

set autoindent
set copyindent
"set smartindent

set tabstop=8
"set shiftwidth=8
"set softtabstop=2
"set smarttab
"set expandtab

set backspace=indent,eol,start

syntax on

if &term=="xterm"
"    set t_Co=8
    set t_Sb=ESC[4%dm
    set t_Sf=ESC[3%dm
endif

set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

"set showcmd
set number

set laststatus=2 " Make it appear without splitting
let g:airline_powerline_fonts = 1
let g:airline_theme = 'jellybeans'
let g:airline_skip_empty_sections = 1
let g:airline_exclude_preview = 1

let g:airline#extensions#tabline#enabled = 1 " Enable buffer tabs
let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#left_sep = ' ' " Different separators
"let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#whitespace#enabled = 1 " Detect whitespace
let g:airline#extensions#whitespace#show_message = 0 " Warn about whitespace
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ] " Toggle whitespace warnings
let g:airline#extensions#whitespace#symbol = '!'
"let g:airline#extensions#tabline#left_sep = ' ' " Different separators
"let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#syntastic#enabled = 0

let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#branch#empty_message = ''
"let g:airline#extensions#branch#format = 2

let g:airline#extensions#ycm#enabled = 1
"let g:airline#extensions#ycm#error_symbol = 'E:'
"let g:airline#extensions#ycm#warning_symbol = 'W:'

let g:airline#extensions#neomake#enabled = 1
let g:neomake_highlight_columns = 0
let g:neomake_highlight_lines = 0
let g:neomake_open_list = 0
let g:neomake_place_signs = 0

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'
"let g:airline_symbols.maxlinenr = ''

" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = 'Ξ'
let g:airline_symbols.notexists = ' ●'

"let g:gitgutter_realtime = 0
"let g:gitgutter_eager = 0
"let g:gitgutter_grep_command = 'ag --nocolor'

"let g:signify_vcs_list = [ 'git', 'svn' ]
"let g:signify_update_on_bufenter = 1
"let g:signify_update_on_focusgained = 1

let g:ycm_filetype_whitelist = {
    \ 'c' : 1,
    \ 'cpp' : 1,
    \ 'py' : 1,
    \}

autocmd FileType c      let g:ycm_global_ycm_extra_conf = '~/.ycm/ycm_c_conf.py'
autocmd FileType cpp    let g:ycm_global_ycm_extra_conf = '~/.ycm/ycm_cpp_conf.py'
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

let g:ycm_extra_conf_globlist = ['~/projects/*', '!~/*']

set pumheight=10
set completeopt-=preview

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 0 "default 0
let g:ycm_open_loclist_on_ycm_diags = 0 "default 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_auto_trigger = 0

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info

let g:ycm_error_symbol = '>'
let g:ycm_warning_symbol = '>'

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 0
let g:cpp_concepts_highlight = 0

"let g:color_coded_enabled = 0

let g:move_key_modifier = 'C'

let g:clang_format#code_style = 'llvm'
let g:clang_format#command = 'clang-format50'

"let g:clighter_autostart = 1
"let g:clighter_libclang_file = '/home/gor/lib/libclang.so.4'
"let g:clighter8_global_compile_args = ['-std=c++14', '-x', 'c++', '-I/usr/include', '-I/usr/local/include', '-I/usr/include/c++/v1', '-I/usr/local/include/qt5', '-I.', '-Isrc']

let g:fzf_prefer_tmux = 1

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~30%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"
"let mapleader = '\'

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
"nnoremap <tab>   <c-w>w
"nnoremap <S-tab> <c-w>W

nnoremap ;f :Files<cr>
nnoremap ;g :GFiles<cr>
nnoremap ;b :Buffers<cr>
nnoremap ;a :Ag<cr>
nnoremap ;l :Lines<cr>
nnoremap ;t :Tags<cr>
nnoremap ;w :Windows<cr>
nnoremap ;m :Marks<cr>
nnoremap ;h :History<cr>
nnoremap ;c :Commits<cr>
nnoremap ;n :Neomake!<cr>
nnoremap ;d :bd<cr>
nnoremap ;q :copen<cr>
