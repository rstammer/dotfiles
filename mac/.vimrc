" ------------------------------------------
" Setting up Vundle - the vim plugin bundler
" ------------------------------------------

let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')

if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

"-------------------------------------------
 
if has("gui_macvim")
  set guioptions-=T "if using a GUI Version
endif

"---------------
" VUNDLE CONFIG
"---------------

set nocompatible " be iMproved
filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" languages
Bundle 'tpope/vim-rails.git'
Bundle 'thoughtbot/vim-rspec'

" Other
Bundle 'dermusikman/sonicpi.vim.git'


" workflow
Bundle 'tomtom/tcomment_vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'rking/ag.vim'
Bundle 'lambdatoast/elm.vim'
Bundle 'tpope/vim-fugitive.git'
Bundle 'altercation/vim-colors-solarized.git'

filetype plugin indent on " required!

" -----------------------
" BASIC VIM CONFIGURATION
" -----------------------

"let g:solarized_termcolors=256
set background=dark
colorscheme solarized
"colorscheme ir_black

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

let g:syntastic_javascript_checkers = ['jshint']

"encoding
set encoding=utf-8
set termencoding=utf-8

" enable Search highlightning
set hlsearch

set ruler  " Ruler on
set nu  " Line numbers on
set nowrap  " Line wrapping off

set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)
autocmd Filetype gitcommit setlocal spell textwidth=72

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

" shortcuts
nnoremap <leader>t :<C-u>tabnew<CR>
nnoremap <leader>gs :Gstatus<CR>

" opens search results in a window w/ links and highlight the matches
command! -nargs=+ Grep execute 'silent grep! -I -r -n --exclude-dir=.git --exclude-dir=tmp --exclude=*.{log,sock,swo,swp}  . -e <args>' | copen | execute 'silent /<args>'

"OpenChangedFiles (<Leader>O)---------------------- {{{
function! OpenChangedFiles()
  only "Close all windows, unless they're modified"
  let status = system('git status -s | grep "^ \?\(M\|A\)" | cut -d " " -f3')
  let filenames = split(status, "\n")

  if len(filenames) < 1
    let status = system('git show --pretty="format:" --name-only')
    let filenames = split(status, "\n")
  endif

  exec "edit " . filenames[0]

  for filename in filenames[1:]
    if len(filenames) > 4
      exec "tabedit " . filename
    else
      exec "sp " . filename
    endif
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()
noremap<Leader>o :OpenChangedFiles <CR>
" }}}

" SonicPi
"
nnoremap <leader>m :silent w !sonic_pi<CR>
nnoremap <leader>n :call system("sonic_pi stop")<CR>

" using Rspec with spring
function! RSpecSpringLine()
  execute("!spring rspec " . expand("%p") . ":" . line("."))
endfunction

function! RSpecSpring()
  execute("!spring rspec " . expand("%p"))
endfunction

" using Rspec with zeus
function! RSpecZeusLine()
  execute("!zeus rspec " . expand("%p") . ":" . line("."))
endfunction

function! RSpecZeus()
  execute("!zeus rspec " . expand("%p"))
endfunction

map ,ZR :call RSpecZeusLine()<CR>
map ,zr :call RSpecZeus()<CR>

map ,A :call RSpecSpringLine()<CR>
map ,s :call RSpecSpring()<CR>

