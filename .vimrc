"colorscheme grb256
"colorscheme railscasts
colorscheme ir_black
"colorscheme koehler
"colorscheme desert

"enable 256 colors
set t_Co=256

let mapleader = ","
set clipboard=unnamed

filetype on  " Automatically detect file types.
set nocompatible
set nobackup
syntax enable
set synmaxcol=256

" Formatting (some of these are for coding in C and C++)
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set autoindent
set smarttab
set expandtab
set nocp incsearch
set cinwords=if,else,while,do,for,switch,case

" enable Search highlightning
set hlsearch

set ruler  " Ruler on
set nu  " Line numbers on
set nowrap  " Line wrapping off

set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)

if has("autocmd")
  filetype indent on
endif

" http://vimcasts.org/episodes/tidying-whitespace/"
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre *.rb,*.erb,*.py,*.js :call <SID>StripTrailingWhitespaces()

" NERDTreeTabs behavior
let g:nerdtree_tabs_open_on_gui_startup=0
let g:nerdtree_tabs_open_on_new_tab=0
let g:NERDTreeHijackNetrw=0

" map YankRing-Window
nnoremap <silent> <F6> :YRShow<CR>

" show hidden files in NERDTree
let NERDTreeShowHidden=1

" swapping through buffers
":nnoremap <F5> :buffers<CR>:buffer<Space>

execute pathogen#infect()
call pathogen#helptags()
