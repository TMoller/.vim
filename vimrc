nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

set nocompatible
set visualbell
set t_vb=
set mouse=a

set ttyfast

syntax enable
set background=light
colorscheme solarized
nnoremap <Leader>bg :let &background = (
            \ &background == "dark"? "light" : "dark" )<CR>

filetype plugin indent on

set history=200
set ruler         " show the cursor position all the time
set cursorline
set scrolloff=3

set showcmd       " display incomplete commands
set laststatus=2  " Always display the status line
set wildmenu

set incsearch
set hlsearch
set ignorecase
nnoremap <CR> :noh<CR><CR>

set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
hi ColorColumn ctermbg=lightgrey guibg=lightgrey

" Use one space, not two, after punctuation.
set nojoinspaces

" Numbers
set number
set numberwidth=5

"place swap and backup files in the vim directory
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" Open new split panes to right and bottom, which feels
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Cursor style fix
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"


augroup rebind
  au!
  au VimEnter * :silent !~/.vim/AHK/AutoHotkeyU32.exe ~/.vim/AHK/RemapCaps.ahk&
  au VimLeave * :silent !~/.vim/AHK/AutoHotkeyU32.exe ~/.vim/AHK/ExitAHK.ahk
augroup END
