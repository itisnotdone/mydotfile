" https://github.com/VundleVim/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim

" --------------------------------------
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-fugitive'
Plugin 'Yggdroot/indentLine'
Plugin 'itchyny/lightline.vim'
Plugin 'morhetz/gruvbox'

call vundle#end()
" --------------------------------------

filetype plugin indent on

set shell=/bin/bash

" https://stackoverflow.com/questions/33380451/is-there-a-difference-between-syntax-on-and-syntax-enable-in-vimscript
syntax enable

" https://github.com/skwp/dotfiles/blob/master/vimrc
set hidden

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" ================ General Config ====================
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set autoread                    "Reload files changed outside vim
set visualbell                  "No sounds

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
" set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" for indentLine
" https://github.com/Yggdroot/indentLine
let g:indentLine_color_term = 242
let g:indentLine_char = '|'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1

" for vim-fugitive
" https://github.com/skwp/dotfiles/blob/79e5d1a9f4c77bc072775e1285d2aa48810defa7/vim/settings/vim-fugitive.vim
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

autocmd BufReadPost fugitive://* set bufhidden=delete

" for lightline
" https://github.com/skwp/dotfiles/blob/79e5d1a9f4c77bc072775e1285d2aa48810defa7/vim/settings/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'filename': 'MyFilename',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤ "
  else
    return ""
  endif
endfunction

" TODO: it seems to be better with fugitive plugin.
function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%') ? expand('%') : '[NoName]')
endfunction

" Use status bar even with single buffer
set laststatus=2
set noshowmode

" for gruvbox
colorscheme gruvbox
set t_Co=256
set background=dark


" ================ Custom Settings ========================
set conceallevel=0  " but it doesn't seem to work somehow...
" inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
" inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
" just use ctrl-n and ctrl-p

" Resize windows with arrow keys
" https://github.com/skwp/dotfiles/blob/master/vim/settings/yadr-keymap-linux.vim
" nnoremap <C-Up> <C-w>+
" nnoremap <C-Down> <C-w>-
" nnoremap <C-Left> <C-w><
" nnoremap <C-Right>  <C-w>>
nnoremap <C-j> <C-w>+
nnoremap <C-k> <C-w>-
nnoremap <C-l> <C-w><
nnoremap <C-h>  <C-w>>

nnoremap <C-n> :tabprevious<CR>
nnoremap <C-p> :tabnext<CR>

let mapleader = ","
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

inoremap jk <esc>

iabbrev @@ Donoldfashioned@gmail.com
iabbrev DD Don Draper


" To get started
" mkdir -p ~/.vim/bundle
" mkdir ~/.vim/sessions
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" git clone https://github.com/itisnotdone/mydotfile.git
" sudo ln -s ~/mydotfile/.vimrc ~/.vimrc
" vim +PluginInstall +qall
"
" When using sessions
" :mks ~/.vim/sessions/my_sessions1.vim
" :source ~/.vim/sessions/my_sessions1.vim or vim -S ~/.vim/sessions/my_sessions1.vim
