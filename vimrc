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

" AutoHotKey script to rebind caps to Esc and Ctrl
augroup rebind
  au!
  au VimEnter * :silent !~/.vim/AHK/AutoHotkeyU32.exe ~/.vim/AHK/RemapCaps.ahk&
  au VimLeave * :silent !~/.vim/AHK/AutoHotkeyU32.exe ~/.vim/AHK/ExitAHK.ahk
augroup END

" Plugins or stuff to implement later:
" https://github.com/nathanaelkane/vim-indent-guides
" folding (with simpylFold and FastFold)
" NerdTree
" YouCompleteMe


" From http://vim.wikia.com/wiki/Move_to_next/previous_line_with_same_indentation
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>
