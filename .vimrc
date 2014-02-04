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
" workflow
Bundle 'Shougo/unite.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'scrooloose/syntastic'
Bundle 'joestelmach/lint.vim'
Bundle 'godlygeek/tabular'
Bundle 'rking/ag.vim'

filetype plugin indent on " required!

" -----------------------
" BASIC VIM CONFIGURATION
" -----------------------

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
autocmd BufWritePre *.haml,*.rb,*.erb,*.py,*.js :call <SID>StripTrailingWhitespaces()

" using Rspec with zeus
function! RSpecZeusLine()
  execute("!zeus rspec " . expand("%p") . ":" . line("."))
endfunction

function! RSpecZeus()
  execute("!zeus rspec " . expand("%p"))
endfunction

map ,ZR :call RSpecZeusLine()<CR>
map ,zr :call RSpecZeus()<CR>

" lint.vim
let lint_default = 0

function! LintAndSave()
  execute(":LintVimToggle")
  execute(":w")
  execute(":LintVimToggle")
endfunction
map ,l  :call LintAndSave()<CR><C-w><C-w>

" ---  unite.vim 

" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_enable = 1
"let g:unite_source_rec_max_cache_files = 10000

call unite#filters#matcher_default#use(['matcher_fuzzy'])

" --- 

" shortcuts
nnoremap <leader>t :<C-u>tabnew<CR>
nnoremap <leader>f :Unite file_rec/async<cr>
nnoremap <leader>r :<C-u>Unite file_mru<CR>
nnoremap <leader>f :<C-u>Unite -start-insert file_rec/async<CR>
nnoremap <leader>g :Unite grep:.<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction
