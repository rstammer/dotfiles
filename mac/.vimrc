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
Plugin 'gmarik/vundle'

" languages
Plugin 'tpope/vim-rails.git'
Plugin 'thoughtbot/vim-rspec'
Plugin 'dag/vim2hs'
Plugin 'derekelkins/agda-vim'
Plugin 'def-lkb/vimbufsync.git'
Plugin 'trefis/coquille'
Plugin 'elixir-lang/vim-elixir'

" Other
Plugin 'dermusikman/sonicpi.vim.git'

" workflow
Plugin 'tomtom/tcomment_vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive.git'
Plugin 'altercation/vim-colors-solarized.git'

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
let maplocalleader = "."

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


au BufRead,BufNewFile *.jsx set filetype=javascript
au BufRead,BufNewFile *.es6 set filetype=javascript
let g:syntastic_javascript_checkers = ['eslint']

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


map ,as :call RSpecSpringLine()<CR>
map ,s :call RSpecSpring()<CR>

" agda-vim 
nnoremap <buffer> <LocalLeader>l :Reload<CR>
nnoremap <buffer> <LocalLeader>t :call Infer()<CR>
nnoremap <buffer> <LocalLeader>r :call Refine("False")<CR>
nnoremap <buffer> <LocalLeader>R :call Refine("True")<CR>
nnoremap <buffer> <LocalLeader>g :call Give()<CR>
nnoremap <buffer> <LocalLeader>c :call MakeCase()<CR>
nnoremap <buffer> <LocalLeader>a :call Auto()<CR>
nnoremap <buffer> <LocalLeader>e :call Context()<CR>
nnoremap <buffer> <LocalLeader>n :call Normalize("False")<CR>
nnoremap <buffer> <LocalLeader>N :call Normalize("True")<CR>
nnoremap <buffer> <LocalLeader>M :call ShowModule()<CR>
nnoremap <buffer> <LocalLeader>m :Metas<CR>

" Add Agda libs 
let g:agda_extraincpaths = ["agda-stdlib"]


" funny ASCII 
imap <leader>dunno ¯\_(ツ)_/¯
" Combining marks
imap <leader>over`  ̀
imap <leader>over'  ́
imap <leader>over^  ̂
imap <leader>overv  ̌
imap <leader>over~  ̃
imap <leader>over-  ̄
imap <leader>over_  ̅
imap <leader>over–  ̅
imap <leader>over—  ̅
imap <leader>overcup  ̆
imap <leader>overcap  ̑
imap <leader>over.  ̇
imap <leader>over..  ̈
imap <leader>over  ̈
imap <leader>over...  ⃛
imap <leader>overright.  ͘
imap <leader>overo  ̊
imap <leader>over``  ̏
imap <leader>over''  ̋
imap <leader>overvec  ⃑
imap <leader>vec  ⃑
imap <leader>overlvec  ⃐
imap <leader>lvec  ⃐
imap <leader>overarc  ⃕
imap <leader>overlarc  ⃔
imap <leader>overto  ⃗
imap <leader>overfrom  ⃖
imap <leader>overfromto  ⃡
imap <leader>over*  ⃰
imap <leader>under`  ̖
imap <leader>under'  ̗
imap <leader>under,  ̗
imap <leader>under.  ̣
imap <leader>under..  ̤
imap <leader>under  ̤
imap <leader>undero  ̥
imap <leader>under-  ̱
imap <leader>under_  ̲
imap <leader>under–  ̲
imap <leader>under—  ̲
imap <leader>through~  ̴
imap <leader>through-  ̵
imap <leader>through_  ̶
imap <leader>through–  ̶
imap <leader>through—  ̶
imap <leader>through/  ̷
imap <leader>not  ̷
imap <leader>through?  ̸
imap <leader>Not  ̸
imap <leader>through\|  ⃒
imap <leader>throughshortmid  ⃓
imap <leader>througho  ⃘

"Math
imap <leader>: ∶
imap <leader>:: ∷
imap <leader>;  ﹔
imap <leader>.. ‥
imap <leader>=? ≟
imap <leader>all ∀
imap <C-a> ∀
imap <leader>always □
imap <leader>approx ≈
imap <leader>bot ⊥
imap <leader>box □
imap <leader>boxdot ⊡
imap <leader>box. ⊡
imap <leader>boxminus ⊟
imap <leader>box- ⊟
imap <leader>boxplus ⊞
imap <leader>box+ ⊞
imap <leader>boxtimes ⊠
imap <leader>box* ⊠
imap <leader>bul •
imap <leader>C ℂ
imap <leader>cdot ∙
imap <leader>. ∙
imap <leader>cdots ⋯
imap <leader>check ✓
imap <leader>yes ✓
imap <leader>Check ✔
imap <leader>Yes ✔
imap <leader>circ ∘
imap <leader>clock ↻
imap <leader>cclock ↺
imap <leader>comp ∘
imap <leader>contra ↯
imap <leader>deg °
imap <leader>den ⟦⟧<left>
imap <leader>diamond ◇
imap <leader>dots …
imap <leader>down ↓
imap <leader>downtri ▼
imap <leader>Down ⇓
imap <leader>dunion ⨃
imap <leader>du ⨃
imap <leader>ell ℓ
imap <C-l> ℓ
imap <leader>empty ∅
imap <leader>equiv ≡
imap <leader>eq ≡
imap <leader>eventually ◇
imap <leader>exists ∃
imap <leader>flat ♭
imap <leader>fold ⦇⦈<left>
imap <leader>(\| ⦇
imap <leader>\|) ⦈
imap <leader>forall ∀
imap <leader>from ←
imap <leader><- ←
imap <leader>From ⇐
imap <leader>fromto ↔
imap <leader>Fromto ⇔
imap <leader>ge ≥
imap <leader>glub ⊓
imap <leader>iff ⇔
imap <leader>implies ⇒
imap <leader>impliedby ⇐
imap <leader>in ∈
imap <leader>infty ∞
imap <leader>inf ∞
imap <leader>int ∫
imap <leader>intersect ∩
imap <leader>iso ≅
imap <leader>join ⋈
imap <leader>land ∧
imap <leader>langle ⟨
imap <leader>lbrac ⟦
imap <leader>[[ ⟦
imap <leader>ldots …
imap <leader>ldown ⇃
imap <leader>leadsto ⇝
imap <leader>~> ⇝
imap <leader>le ≤
imap <leader>lift ⌊⌋<left>
imap <leader>floor ⌊⌋<left>
imap <leader>llangle ⟪
imap <leader>longto ⟶ 
imap <leader>-- ⟶ 
imap <leader>– ⟶ 
imap <leader>lor ∨
imap <leader>lower ⌈⌉<left>
imap <leader>ceil ⌈⌉<left>
imap <leader>lub ⊔
imap <leader>lup ↿
imap <leader>mapsto ↦
imap <leader>map ↦
imap <leader>mid ∣
imap <leader>models ⊨
imap <leader>\|= ⊨
imap <leader>N ℕ
imap <leader>ne ≠
imap <leader>nearrow ↗
imap <leader>Nearrow ⇗
imap <leader>neg ¬
imap <leader>/= ≠
imap <leader>nequiv ≢
imap <leader>neq ≢
imap <leader>nexist ∄
imap <leader>none ∄
imap <leader>ni ∋
imap <leader>ni ∋
imap <leader>nin ∉
imap <leader>niso ≇
imap <leader>notin ∉
imap <leader>nwarrow ↖
imap <leader>Nwarrow ⇖
imap <leader>oast ⊛
imap <leader>odot ⊙
imap <leader>o. ⊙
imap <leader>of ∘
imap <leader>o ∘
imap <leader>ominus ⊖
imap <leader>o- ⊖
imap <leader>oplus ⊕
imap <leader>o+ ⊕
imap <leader>oslash ⊘
imap <leader>o/ ⊘
imap <leader>otimes ⊗
imap <leader>o* ⊗
imap <leader>par ∂
imap <leader>pge ≽
imap <leader>pgt ≻
imap <leader>ple ≼
imap <leader>plt ≺
imap <leader>p≥ ≽
imap <leader>p> ≻
imap <leader>p≤ ≼
imap <leader>p< ≺
imap <leader>pm ±
imap <leader>prec ≼
imap <leader>prod ∏
imap <leader>proves ⊢
imap <leader>\|- ⊢
imap <leader>provedby ⊣
imap <leader>Q ℚ
imap <leader>qed ∎
imap <leader>R ℝ
imap <leader>rangle ⟩
imap <leader>rbrac ⟧
imap <leader>]] ⟧
imap <leader>rdown ⇂
imap <leader>righttri ▸
imap <leader>rrangle ⟫
imap <leader>rup ↾
imap <leader>searrow ↘
imap <leader>Searrow ⇘
imap <leader>setminus ∖
imap <leader>sharp ♯
imap <leader># ♯
imap <leader>sim ∼
imap <leader>simeq ≃
imap <leader>some ∃
imap <C-e> ∃
imap <leader>sqge ⊒
imap <leader>sqgt ⊐
imap <leader>sqle ⊑
imap <leader>sqlt ⊏
imap <leader>s≥ ⊒
imap <leader>s> ⊐
imap <leader>s≤ ⊑
imap <leader>s< ⊏
imap <leader>sqr ²
imap <leader>sqrt √
imap <leader>star ✭
imap <leader>subset ⊂
imap <leader>sub ⊂
imap <leader>subseteq ⊆
imap <leader>subeq ⊆
imap <leader>subsetneq ⊊
imap <leader>subneq ⊊
imap <leader>sum ∑
imap <leader>supset ⊃
imap <leader>sup ⊃
imap <leader>supseteq ⊇
imap <leader>supeq ⊇
imap <leader>supsetneq ⊋
imap <leader>supneq ⊋
imap <leader>swarrow ↙
imap <leader>Swarrow ⇙
imap <leader>thus ∴
imap <leader>times ×
imap <leader>* ×
imap <leader>to →
imap <leader>- →
imap <C-_> →
imap <leader>To ⇒
imap <leader>= ⇒
imap <leader>top ⊤
imap <leader>tuple ⟨⟩<left>
imap <leader>up ↑
imap <leader>updown ↕
imap <leader>ud ↕
imap <leader>unfold ⦉⦊<left>
imap <leader><\| ⦉
imap <leader>\|> ⦊
imap <leader>up;down ⇅
imap <leader>u;d ⇅
imap <leader>uptri ▲
imap <leader>Up ⇑
imap <leader>union ∪
imap <leader>vdots ⋮
imap <leader>voltage ⚡
imap <leader>xmark ✗
imap <leader>no ✗
imap <leader>Xmark ✘
imap <leader>No ✘
imap <leader>Z ℤ

" Not math
imap <leader>sec §

" Superscripts
imap <leader>^0 ⁰
imap <leader>^1 ¹
imap <leader>^2 ²
imap <leader>^3 ³
imap <leader>^4 ⁴
imap <leader>^5 ⁵
imap <leader>^6 ⁶
imap <leader>^7 ⁷
imap <leader>^8 ⁸
imap <leader>^9 ⁹
imap <leader>^n ⁿ
imap <leader>^i ⁱ
imap <leader>^+ ⁺
imap <leader>^- ⁻
imap <leader>' ′
imap <leader>'' ″
imap <leader>''' ‴
imap <leader>'''' ⁗
imap <leader>` ‵
imap <leader>`` ‶
imap <leader>``` ‷

" Subscripts
imap <leader>0 ₀
imap <leader>1 ₁
imap <leader>2 ₂
imap <leader>3 ₃
imap <leader>4 ₄
imap <leader>5 ₅
imap <leader>6 ₆
imap <leader>7 ₇
imap <leader>8 ₈
imap <leader>9 ₉
imap <leader>_i ᵢ
imap <leader>_j ⱼ
imap <leader>_+ ₊
imap <leader>_- ₋
imap <leader>p0 π₀
imap <leader>p1 π₁
imap <leader>p2 π₂
imap <leader>p3 π₃
imap <leader>p4 π₄
imap <leader>p5 π₅
imap <leader>p6 π₆
imap <leader>p7 π₇
imap <leader>p8 π₈
imap <leader>p9 π₉
imap <leader>i0 ι₀
imap <leader>i1 ι₁
imap <leader>i2 ι₂
imap <leader>i3 ι₃
imap <leader>i4 ι₄
imap <leader>i5 ι₅
imap <leader>i6 ι₆
imap <leader>i7 ι₇
imap <leader>i8 ι₈
imap <leader>i9 ι₉

" Greek (lower)
imap <leader>alpha α
imap <leader>a α
imap <leader>beta β
imap <leader>b β
imap <leader>gamma γ
imap <leader>g γ
imap <leader>delta δ
imap <leader>d δ
imap <leader>epsilon ε
imap <leader>e ε
imap <leader>zeta ζ
imap <leader>z ζ
imap <leader>eta η
imap <leader>h η
imap <leader>theta θ
imap <leader>iota ι
imap <leader>i ι
imap <leader>kappa κ
imap <leader>k κ
imap <leader>lambda λ
imap <leader>l λ
imap <C-\> λ
imap <leader>mu μ
imap <leader>m μ
imap <leader>nu ν
imap <leader>n ν
imap <leader>xi ξ
imap <leader>omicron ο
imap <leader>o ο  Shadows ∘
imap <leader>pi π
imap <leader>p π
imap <leader>rho ρ
imap <leader>r ρ
imap <leader>sigma σ
imap <leader>s σ
imap <leader>varsigma ς
imap <leader>vars ς
imap <leader>tau τ
imap <leader>t τ
imap <leader>upsilon υ  Delays <leader>up
imap <leader>u υ
imap <leader>phi φ
imap <leader>f φ
imap <leader>chi χ
imap <leader>x χ
imap <leader>psi ψ
imap <leader>c ψ
imap <leader>omega ω
imap <leader>v ω

" Greek (upper)
imap <leader>Alpha Α
imap <leader>Beta Β
imap <leader>Gamma Γ
imap <leader>G Γ
imap <leader>Delta Δ
imap <leader>D Δ
imap <leader>Epsilon Ε
imap <leader>Zeta Ζ
imap <leader>Eta Η
imap <leader>Theta Θ
imap <leader>Iota Ι
imap <leader>Kappa Κ
imap <leader>Lambda Λ
imap <leader>L Λ
imap <leader>Mu Μ
imap <leader>Nu Ν
imap <leader>Xi Ξ
imap <leader>Omicron Ο
imap <leader>Pi Π
imap <leader>P Π
imap <leader>Rho Ρ
imap <leader>Sigma Σ
imap <leader>S Σ
imap <leader>Tau Τ
imap <leader>Upsilon Υ
imap <leader>Phi Φ
imap <leader>F Φ
imap <leader>Chi Χ
imap <leader>Psi Ψ
imap <leader>C Ψ  Shadows ℂ
imap <leader>Omega Ω
imap <leader>V Ω
