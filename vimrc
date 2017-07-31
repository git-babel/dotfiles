set nocompatible
set number
filetype off
syntax enable
set background=dark
set backspace=2
set encoding=utf-8
set list
set listchars=tab:>\ ,trail:·,extends:»,precedes:«,nbsp:+
set autoindent
set expandtab
set smarttab
set softtabstop=2
set shiftwidth=2
set shiftround
set textwidth=80
set cursorline
set hlsearch
set incsearch
set showmatch
set history=1000
set undolevels=1000

" vim-plug sections begin
call plug#begin('~/.vim/plugged')

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

" solarized color scheme
Plug 'altercation/vim-colors-solarized'
" nerdtreed
Plug 'scrooloose/nerdtree'
" syntastic
Plug 'scrooloose/syntastic'
" auto completion
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" ycm generator
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" surround
Plug 'tpope/vim-surround'
" vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" git plugin
Plug 'tpope/vim-fugitive'

" vim-plug section end
call plug#end()

" solarized
colo solarized

" nerdtree
map <C-n> :NERDTreeToggle<CR>

" syntastic
" show error in status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" Skip checks when you issue :wq, :x and :ZZ
let g:syntastic_check_on_wq = 0
" Display all of the errors from all of the checkers together
let g:syntastic_aggregate_errors = 1
" Sort errors by file, line number, type, column number
let g:syntastic_sort_aggregated_errors = 1
" Turn off highlighting for marking errors
let g:syntastic_enable_highlighting = 0
" Always stick any detected errors into the location-list
let g:syntastic_always_populate_loc_list = 1
" Pop up lcoation-list if any error happens, disappear when resolved.
let g:syntastic_auto_loc_list = 1
" Automatically check.
let g:syntastic_mode_map = { 'mode': 'active' }
" Check header files
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_check_header = 1
" Enable JSCS for JavaScript files
let g:syntastic_javascript_checkers = ['jshint', 'jslint', 'jscs']
" Enable python checkers; flake8
let g:syntastic_python_checkers = ['flake8']

" ycm
let g:ycm_autoclose_preview_window_after_completion=1

" airline
" Turn on status line
set laststatus=2
" Use powerline fonts
let g:airline_powerline_fonts = 1
" Use powerlineish theme
let g:airline_theme='powerlineish'
" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
set hidden
