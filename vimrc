" basic vim option settings.
set nocompatible
set number
filetype plugin indent on
syntax enable
set background=dark
set backspace=2
set encoding=utf-8
set list
set listchars=tab:»\ ,trail:·,extends:»,precedes:«,nbsp:+
set autoindent
set expandtab
set smarttab
set softtabstop=4
set shiftwidth=4
set shiftround
set textwidth=80
set cursorline
set hlsearch
set incsearch
set showmatch
set history=1000
set undolevels=1000
set tags=tags;/

" Enable matchit.vim
runtime macros/matchit.vim

" vim-plug sections begin
call plug#begin('~/.vim/plugged')

" Build YCM after installed/updated
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status != 'unchanged' || a:info.force
    !./install.py
  endif
endfunction

" Disable delimitmate during multi-cursor
function! Multiple_cursors_before()
  try
    let b:saved_delimitMate_statues = b:delimitMate_enabled
    silent! execute('imap "')
    DelimitMateOff
    silent! execute('imap "')
  catch
  endtry
endfunction

" Restore delimitmate after multi-cursor
function! Multiple_cursors_after()
  try
    if b:saved_delimitMate_statues
    silent! execute('imap "')
    silent! DelimitMateOn
    silent! execute('imap "')
    endif
  catch
  endtry
endfunction

" solarized color scheme
Plug 'altercation/vim-colors-solarized'
" nerdtreed
Plug 'scrooloose/nerdtree'
" auto completion
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" ycm generator
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" ALE
Plug 'w0rp/ale'
" surround
Plug 'tpope/vim-surround'
" repeat.vim
Plug 'tpope/vim-repeat'
" PreserveNoEOL
Plug 'vim-scripts/PreserveNoEOL'
" vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" git plugins
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" tagbar
Plug 'majutsushi/tagbar'
" vim-javascript
Plug 'pangloss/vim-javascript'
" fzf plugin for vim
" Install fzf itself by brew
Plug 'junegunn/fzf.vim'
" delimitmate
Plug 'raimondi/delimitmate'
" commentary.vim
Plug 'tpope/vim-commentary'
" gitgutter
Plug 'airblade/vim-gitgutter'
" closetag.vim
Plug 'docunext/closetag.vim'
" vim-polyglot
Plug 'sheerun/vim-polyglot'
" vim-markdown-preview
Plug 'jamshedvesuna/vim-markdown-preview'
" multi-cursor
Plug 'terryma/vim-multiple-cursors'
" vim-sleuth
" Plug 'tpope/vim-sleuth'
" vim-indent-object
Plug 'michaeljsmith/vim-indent-object'

" vim-plug section end
call plug#end()

" solarized
colo solarized

" shortcuts
" custom leader-map for OS-X
let mapleader = ','
" quick save shortcut
noremap <Leader>s :update<CR>
" quick quit shortcut
noremap <Leader>q :q<CR>
" nerdtree shortcut
map <Leader>n :NERDTreeToggle<CR>
" tagBar shortcut
nmap <F6> :TagbarToggle<CR>
" fzf buffers search shortcut
nmap ; :Buffers<CR>
" fzf files search shortcut
nmap <Leader>t :Files<CR>
" fzf tags search shortcut
nmap <Leader>r :Tags<CR>
" fzf(+ rg) files search shortcut
nmap <C-p> :Rg<CR>

" ALE
" Open error loclist window
let g:ale_open_list = 1
" Don't close ALE window even there are no errors
let g:ale_keep_list_window_open = 1
" Integration with vim-airline
let g:airline#extensions#ale#enabled = 1
" Completion enabled
let g:ale_completion_enabled = 1
" Detect pipenv automatically for integration
let g:ale_python_auto_pipenv = 1

" ycm
" Auto close after completion
let g:ycm_autoclose_preview_window_after_completion = 1
" Don't ask about local ycm_extra_conf.py
let g:ycm_confirm_extra_conf = 0

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

" tagbar
" focus tagbar when it is opened.
let g:tagbar_autofocus = 1

" vim-javascript
" set concealing
set conceallevel=1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"

" fzf
" Install fzf itself by homebrew
set rtp+=/usr/local/opt/fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" fzf with ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%'),
  \   <bang>0)
" fzf ':Files' with preview
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" delimitmate
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1

" PreserveNoEOL
let g:PreserveNoEOL = 1

" vim-markdown-preview
" automatical buffer write
let vim_markdown_preview_toggle=0
" change hot-key config. <C-p> is already occupied
let vim_markdown_preview_hotkey='<C-m>'
" use 'Github flavored markdown' as default
" it require 'Python grip'
" 'pip install grip', or 'brew install grip'
let vim_markdown_preview_github=1