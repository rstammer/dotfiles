set nocompatible
filetype off

call plug#begin()
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular'
Plug 'iCyMind/NeoSolarized'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'janko-m/vim-test'
Plug 'kassio/neoterm'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-grepper'
Plug 'leanprover/lean.vim'
Plug 'dense-analysis/ale'
call plug#end()

map <silent> <PageUp> 1000<C-U>
map <silent> <PageDown> 1000<C-D>
imap <silent> <PageUp> <C-O>1000<C-U>
imap <silent> <PageDown> <C-O>1000<C-D>
set nostartofline

" Start R with localleader + rf
"
filetype plugin indent on
set bg=dark 
colorscheme NeoSolarized
"colorscheme solarized

let mapleader = ","
let maplocalleader = "."

set nocompatible
set nobackup
syntax enable

let g:netrw_banner = 1
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set tabstop=2
set softtabstop=2
let r_indent_align_args = 0

set nobomb
set autoindent
set smarttab
set expandtab " Always convert tabs to spaces
set tabstop=2
set nocp incsearch
set cinwords=if,else,while,do,for,switch,case
set clipboard=unnamed

set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8
setglobal bomb
set fileencodings=ucs-bom,utf-8,latin1

set hlsearch
set ruler
set nu
set nowrap
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)
autocmd Filetype gitcommit setlocal spell textwidth=72

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_swift_checkers = ['swiftlint', 'swiftpm']
"
au BufRead,BufNewFile *.jsx set filetype=javascript
au BufRead,BufNewFile *.es6 set filetype=javascript

" airline
let g:airline_powerline_fonts = 1

" ALE
let g:airline#extensions#ale#enabled = 1
let g:ale_change_sign_column_color = 1
let g:ale_fixers = ['fixjson', 'prettier', 'eslint']
let g:ale_linters = {'ruby': 'standardrb'}


"let g:airline_symbols.branch = '⎇'

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
autocmd BufWritePre *.haml,*.rb,*.erb,*.py,*.js,*.rake,*.ex,*.exs,*.hs,*.md,*.R,*.r,*.tex,*.css,*.scss :call <SID>StripTrailingWhitespaces()
"
" shortcuts
nnoremap <leader>t :<C-u>tabnew<CR>
nnoremap <leader>gs :Gstatus<CR>
" nnoremap <leader>d :set bg=dark<CR>
" nnoremap <leader>l :set bg=light<CR>
"
" opens search results in a window w/ links and highlight the matches
command! -nargs=+ Grep execute 'silent grep! -I -r -n --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=tmp --exclude-dir=log --exclude=*.{log,sock,swo,swp}  . -e <args>' | copen | execute 'silent /<args>'

" SonicPi
" Somehow does ¬ play well with Nvim-R
" nnoremap <leader>m :silent w !sonic_pi<CR>
" nnoremap <leader>n :SonicPiStop<CR>

let g:vim_redraw = 1

let test#ruby#rspec#executable = 'rspec'
" let test#strategy = "neovim"
" let g:test#preserve_screen = 1
"
" Test
let g:test#strategy = "neoterm"
let g:neoterm_shell = '$SHELL -l' " use the login shell
let g:neoterm_default_mod = 'botright'
let g:neoterm_autoscroll = 1      " autoscroll to the bottom when entering insert mode
let g:neoterm_size = 20
let g:neoterm_fixedsize = 1       " fixed size. The autosizing was wonky for me
let g:neoterm_keep_term_open = 0  " when buffer closes, exit the terminal too.
"let test#ruby#rspec#options = { 'suite': '--profile 5' }

nmap <silent> <leader>s :TestFile<CR>
nmap <silent> <leader>as :TestNearest<CR>

" NVIM-R
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

autocmd Filetype ipynb nmap <silent><Leader>p :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>

let R_assign = 0

"Math
imap <leader>: ∶
imap <leader>:: ∷
imap <leader>all ∀
imap <C-a> ∀
imap <leader>always □
imap <leader>approx ≈
imap <leader>bot ⊥
imap <leader>box □
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
imap <leader>comp ∘
imap <leader>contra ↯
imap <leader>deg °
imap <leader>dots …
imap <leader>down ↓
imap <leader>dunion ⨃
imap <leader>du ⨃
imap <leader>empty ∅
imap <leader>equiv ≡
imap <leader>eq ≡
imap <leader>eventually ◇
imap <leader>∃ ∃
imap <leader>flat ♭
imap <leader>∀ ∀
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
imap <leader≥ ⇒
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
