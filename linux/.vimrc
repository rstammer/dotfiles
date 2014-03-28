" NeoBundle ----------------------------------------
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'CSApprox'
NeoBundle 'syntastic'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-rspec'
NeoBundle 'tabular'
NeoBundle 'tComment'

filetype plugin indent on
NeoBundleCheck
" ---------------------------------------------------

colorscheme ir_black
let mapleader = ","
set t_Co=256
set clipboard=unnamed
filetype on  
set nocompatible
set nobackup
syntax enable
set synmaxcol=256
set encoding=utf-8

" Formatting (some of these are for coding in C and C++)
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set autoindent
set smarttab
set expandtab
set nocp incsearch
set cinwords=if,else,while,do,for,switch,case

set hlsearch " enable Search highlightning
set ruler    " Ruler on
set nu       " Line numbers on
set nowrap   " Line wrapping off

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
autocmd BufWritePre *.haml,*.rb,*.erb,*.py,*.js :call <SID>StripTrailingWhitespaces()

" ---------------
" RSpec with zeus
" ---------------
function! RSpecZeusLine()
/  execute("!zeus rspec " . expand("%p") . ":" . line("."))
endfunction

function! RSpecZeus()
  execute("!zeus rspec " . expand("%p"))
endfunction

map ,ZR :call RSpecZeusLine()<CR>
map ,zr :call RSpecZeus()<CR>
nnoremap <leader>t :<C-u>tabnew<CR>
