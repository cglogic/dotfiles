let g:ycm_server_python_interpreter = '/usr/local/bin/python2.7'

call plug#begin('~/.local/share/nvim/plugged')

" Add or remove your plugins here:
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Valloric/YouCompleteMe'
"Plug 'Shougo/deoplete.nvim'
"Plug 'zchee/deoplete-clang'
"Plug 'Shougo/neoinclude.vim'
"Plug 'Shougo/deol.nvim'
"Plug 'w0rp/ale'

Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'matze/vim-move'
Plug 'rhysd/vim-clang-format'

"Plug 'Shougo/denite.nvim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'neomake/neomake'

call plug#end()

filetype plugin indent on
syntax enable

set nobackup             " keep a backup file (restore to previous version)
set noundofile           " keep an undo file (undo changes after closing)
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands

set shell=/bin/sh

" Don't use Ex mode, use Q for formatting
noremap Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on
"syntax on

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'textwidth' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
"filetype plugin indent on

colorscheme jellybeans
set number
set laststatus=2 " Make it appear without splitting
set nowildmenu

let g:airline_powerline_fonts = 1
let g:airline_theme = 'jellybeans'
let g:airline_skip_empty_sections = 1
let g:airline_exclude_preview = 1

let g:airline#extensions#tabline#enabled = 1 " Enable buffer tabs
let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#left_sep = ' ' " Different separators
"let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#whitespace#enabled = 1 " Detect whitespace
let g:airline#extensions#whitespace#show_message = 1 " Warn about whitespace
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ] " Toggle whitespace warnings
let g:airline#extensions#whitespace#symbol = '!'
"let g:airline#extensions#tabline#left_sep = ' ' " Different separators
"let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

let g:airline#extensions#ycm#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = 'Ξ'
let g:airline_symbols.notexists = ' ●'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"let g:airline_symbols.maxlinenr = 'Ξ'

" deoplete
set pumheight=10
set completeopt-=preview

"let g:deoplete#sources#clang#libclang_path = '/usr/local/llvm50/lib/libclang.so.5'
"let g:deoplete#sources#clang#clang_header = '/usr/local/llvm50/lib/clang'
"let g:deoplete#sources#clang#sort_algo = 'alphabetical'
"let g:deoplete#enable_at_startup = 1

let g:ycm_filetype_whitelist = {
    \ 'c' : 1,
    \ 'cpp' : 1,
    \ 'py' : 1,
    \}

autocmd FileType c      let g:ycm_global_ycm_extra_conf = '~/.ycm/ycm_c_conf.py'
autocmd FileType cpp    let g:ycm_global_ycm_extra_conf = '~/.ycm/ycm_cpp_conf.py'
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

let g:ycm_extra_conf_globlist = ['~/projects/*', '!~/*']

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 0 "default 0
let g:ycm_open_loclist_on_ycm_diags = 0 "default 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_auto_trigger = 0
let g:ycm_error_symbol = '>'
let g:ycm_warning_symbol = '>'

let g:clang_format#code_style = 'llvm'
let g:clang_format#command = 'clang-format50'

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 0
let g:cpp_concepts_highlight = 0

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~30%' }

" In Neovim, you can set up fzf window using a Vim command
"let g:fzf_layout = { 'window': 'enew' }
"let g:fzf_layout = { 'window': '-tabnew' }
"let g:fzf_layout = { 'window': '10split enew' }

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

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=25 ctermbg=235
  highlight fzf2 ctermfg=231 ctermbg=235
  highlight fzf3 ctermfg=59 ctermbg=235
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

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

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif
