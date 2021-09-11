let maplocalleader="\\"
"" vim-plug section
"" How to disable a plugin:
"" Option 1: Plug 'random-plugin', { 'on': [] }
"" Option 2: call remove(g:plugs, 'plugin-name')
packadd vimball
call plug#begin('~/.config/nvim/vim-plug')

"" Plugins to consider (i.e., they seem cool but don't have that many GH stars
"" and / or I'm not sure if they'll interfere with existing mappings)
Plug 'aaronbieber/vim-quicktask'
""Plug 'fmoralesc/vim-pad'
""Plug 'xolox/vim-notes'
""Plug 'sunuslee/vim-plugin-random-colorscheme-picker'
""Plug 'jonstoler/werewolf.vim'

"" Colorschemes
Plug 'sjl/badwolf'
Plug 'vim-scripts/candy.vim'
Plug 'Lokaltog/vim-distinguished'
Plug 'ParamagicDev/vim-medic_chalk'
Plug 'tpope/vim-vividchalk'
Plug 'joshdick/onedark.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'reedes/vim-colors-pencil'

"" New plugins
Plug 'whiteinge/diffconflicts'
Plug 'sjl/gundo.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'bitc/vim-hdevtools'
Plug 'reedes/vim-wheel'
"Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-litecorrect'
"Plug 'reedes/vim-lexical'
Plug 'ledger/vim-ledger'
Plug 'FooSoft/vim-argwrap'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'michaeljsmith/vim-indent-object'
Plug 'navicore/vissort.vim'
Plug 'christoomey/vim-sort-motion'
Plug 'kassio/neoterm'
Plug 'sillybun/vim-repl'
Plug 'papis/papis-vim'
"Plug 'felipec/notmuch-vim'
"Plug 'guyzmo/notmuch-abook'
Plug 'wellle/targets.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'machakann/vim-sandwich'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'honza/vim-snippets'
Plug 'Yilin-Yang/vim-markbar'
Plug 'kshenoy/vim-signature'
" Git branch viewer---updated GitV
Plug 'rbong/vim-flog'
"Plug 'bling/vim-bufferline'
Plug 'tomtom/quickfixsigns_vim'
Plug 'jmcantrell/vim-virtualenv'
" Allows named tabs
Plug 'gcmt/taboo.vim'

"" Maintains a most-recently-used buffer stack
"Plug 'mildred/vim-bufmru'
"" Mappings suggested on Github page:
""imap <A-B><C-O>:BufMRUPrev<CR>
""imap <A-b><C-O>:BufMRUNext<CR>
""map <A-B> :BufMRUPrev<CR>
""map <A-b> :BufMRUNext<CR>
""nmap <Esc>B :BufMRUPrev<CR>
""nmap <Esc>b :BufMRUNext<CR>
""map LL :BufMRUNext<CR>
"map <C-Tab> :BufMRUNext<CR>
"map <C-S-Tab> :BufMRUPrev<CR>

Plug 'jreybert/vimagit'
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['tex']
Plug 'Yggdroot/LeaderF'
Plug 'justinmk/vim-sneak'
"Plug 'goldfeld/vim-seek', { 'on': [] }
"" Replicates much of the functionality of vim-seek
"Plug 't9md/vim-smalls', { 'on': [] }
Plug 'sbdchd/neoformat'
"Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'lambdalisue/vim-backslash'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'neomake/neomake'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'glts/vim-radical'
Plug 'glts/vim-magnum'
Plug 'tpope/vim-tbone'
Plug 'jalvesaq/vimcmdline'
Plug 'LucHermitte/vim-refactor'
Plug 'svermeulen/vim-subversive'
Plug 'alvan/vim-indexer'
Plug 'mhinz/Vim-Signify'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-jdaddy'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-python/python-syntax'
Plug 'tmhedberg/SimpylFold'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'davidhalter/jedi-vim', { 'on': [] }
Plug 'petRUShka/vim-sage'
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
"Plug 'VimRoom'
"Plug 'LiteDFM'
Plug 'tpope/vim-afterimage'
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-yoink'
Plug 'amiorin/vim-project'
"Plug 'vim-ide'
"Plug 'tpope/vim-obsession'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
let g:session_directory='~/.config/nvim/Sessions'
Plug 'tpope/vim-haystack'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mox-mox/vim-localsearch'
" Virtualenv support"
Plug 'petobens/poet-v', { 'on': [] }

"" Old plugins
Plug 'SirVer/ultisnips'
Plug 'ncm2/ncm2-ultisnips'
Plug 'vim-scripts/CRefVim'
Plug 'vim-scripts/DrawIt'
Plug 'chrisbra/NrrwRgn'
Plug 'vim-scripts/ShowMarks', { 'on': [] }

"Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }

"function! BuildYCM(info)
	"if a:info.status == 'installed' || a:info.force
		"!./install.py
	"endif
"endfunction

Plug 'jiangmiao/auto-pairs', { 'on': [] }
"Plug 'calendar.vim', { 'on': [] }
"Plug 'rafaqz/citation.vim'
Plug 'chrisbra/csv.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/denite.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
"No longer maintained---see Flog (in 'new plugins' sections)
"Plug 'gitv'
Plug 'VOID001/graph-easy-vim'
Plug 'junegunn/gv.vim'
Plug 'itchyny/lightline.vim'

" Color options for lightline: powerline, wombat, jellybeans, solarized dark, solarized
" light, PaperColor light, seoul256, one dark, one light, landscape
"let g:lightline = { 'colorscheme': 'one dark' }

Plug 'preservim/nerdcommenter'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Requires Ranger v >= 1.9.3, which is only available for Fedora >= 33
" Looks pretty dope though
" EDIT: Tried it on Fedora 33, not very good (especially compared with
" ranger-explorer)
"Plug 'kevinhwang91/rnvimr'
"Plug 'rafaqz/ranger.vim'
Plug 'iberianpig/ranger-explorer.vim'
" To consider: 'ipod825/vim-netranger'
"Plug 'vifm/vifm.vim'
Plug 'mcchrish/nnn.vim'
"Plug 'alok/notational-fzf-vim'
Plug 'powerline/powerline', { 'on': [] }
"Plug 'syntastic'
Plug 'godlygeek/tabular'
Plug 'tools-life/taskwiki'
Plug 'edkolev/tmuxline.vim'
Plug 'mbbill/undotree'
"Omitting in favor of Denite
"Plug 'Shougo/unite.vim'
Plug 'vim-scripts/utl.vim'
Plug 'vim-vdebug/vdebug'
Plug 'inkarkat/vim-SyntaxRange'

" Completion managers
Plug 'roxma/nvim-yarp'
Plug 'Shougo/deoplete.nvim', { 'on': [] }
Plug 'deoplete-plugins/deoplete-clang'
Plug 'deoplete-plugins/deoplete-tag'
"Plug 'deoplete-plugins/deoplete-make'
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc.nvim', { 'branch': 'release' } 
Plug 'dense-analysis/ale'
"Plug 'ncm2/ncm2'
"Plug 'ncm2/ncm2-pyclang'
"let g:ncm2_pyclang#library_path = '/usr/lib64/libclang.so.9'
Plug 'hari-rangarajan/CCTree'
"Plug 'autozimu/LanguageClient-neovim', {
      "\ 'branch': 'next',
      "\ 'do': 'bash install.sh'
      "\ }
      
" Tag managers
Plug 'ludovicchabant/vim-gutentags', { 'on': [] }
Plug 'preservim/tagbar'
Plug 'liuchengxu/vista.vim'
Plug 'LucHermitte/lh-tags'

"" Eye candy
Plug 'vim-airline/vim-airline'
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#poetv#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#denite#enabled = 1
Plug 'ryanoasis/vim-devicons'
"Plug 'bagrat/vim-buffet'
"" Vim-buffet suggested maps
" Collide with AirlineSelectTab mappings
"nmap <leader>1 <Plug>BuffetSwitch(1)
"nmap <leader>2 <Plug>BuffetSwitch(2)
"nmap <leader>3 <Plug>BuffetSwitch(3)
"nmap <leader>4 <Plug>BuffetSwitch(4)
"nmap <leader>5 <Plug>BuffetSwitch(5)
"nmap <leader>6 <Plug>BuffetSwitch(6)
"nmap <leader>7 <Plug>BuffetSwitch(7)
"nmap <leader>8 <Plug>BuffetSwitch(8)
"nmap <leader>9 <Plug>BuffetSwitch(9)
"nmap <leader>0 <Plug>BuffetSwitch(10)

Plug 'LucHermitte/vim-build-tools-wrapper'
Plug 'LucHermitte/lh-vim-lib'
"Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'tpope/vim-dispatch'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-flagship', { 'on': [] }
"Dependency for tig-explorer
Plug 'rbgrouleff/bclose.vim'
Plug 'iberianpig/tig-explorer.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'xuhdev/vim-latex-live-preview'
Plug 'embear/vim-localvimrc'
Plug 'andymass/vim-matchup'
"Plug 'adelarsq/vim-matchit'
"Plug 'vim-merginal'
Plug 'jceb/vim-orgmode'
Plug 'vim-pandoc/vim-pandoc'
Plug 'conornewton/vim-pandoc-markdown-preview'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'tpope/vim-projectionist'
Plug 'frazrepo/vim-rainbow'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'mhinz/vim-startify'
"Plug 'tpope/vim-surround'
Plug 'dhruvasagar/vim-table-mode'
Plug 'blindFS/vim-taskwarrior'
"Plug 'sodapopcan/vim-twiggy'
Plug 'idanarye/vim-vebugger'
Plug 'mg979/vim-visual-multi'
Plug 'michal-h21/vim-zettel'
"Plug 'Shougo/vimfiler.vim', { 'on': [] }
Plug 'vimoutliner/vimoutliner'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'vimwiki/vimwiki'
Plug 'vim-voom/VOom'
Plug 'jalvesaq/zotcite'
Plug 'holomorph/vim-freefem'
call plug#end()

 "Init files for specific plugins
source ~/.config/nvim/init.autopairs
source ~/.config/nvim/init.coc-nvim
source ~/.config/nvim/init.inkscape
"source ~/.config/nvim/init.manifest
"source ~/.config/nvim/init.nerdtree
source ~/.config/nvim/init.ranger
"source ~/.config/nvim/init.nnn
"source ~/.config/nvim/init.old
"source ~/.config/nvim/init.pathogen
source ~/.config/nvim/init.search-visual
source ~/.config/nvim/init.spellcheck
source ~/.config/nvim/init.standard
source ~/.config/nvim/init.ultisnips
"source ~/.config/nvim/init.vim-latex
source ~/.config/nvim/init.vimtex
source ~/.config/nvim/init.vimwiki
source ~/.config/nvim/init.zettel
source ~/.config/nvim/init.undotree
source ~/.config/nvim/init.cutlass
source ~/.config/nvim/init.color
source ~/.config/nvim/init.yoink
source ~/.config/nvim/init.subversive
source ~/.config/nvim/init.pandoc
"source ~/.config/nvim/init.notmuch
source ~/.config/nvim/init.ctrlp
source ~/.config/nvim/init.citation
source ~/.config/nvim/init.window-motion
source ~/.config/nvim/init.easy-align
source ~/.config/nvim/init.cmdline
source ~/.config/nvim/init.bookmarks
source ~/.config/nvim/init.syntax-range
"source ~/.config/nvim/init.tagbar
source ~/.config/nvim/init.vista
source ~/.config/nvim/init.ctrlsf
source ~/.config/nvim/init.persistent-backups
"source ~/.config/nvim/init.deoplete
"source ~/.config/nvim/init.ncm2
source ~/.config/nvim/init.misc-mappings
"source ~/.config/nvim/init.language-client
source ~/.config/nvim/init.sandwich
source ~/.config/nvim/init.explorer
source ~/.config/nvim/init.fzf
source ~/.config/nvim/init.clang
source ~/.config/nvim/init.octave
source ~/.config/nvim/init.fold
source ~/.config/nvim/init.git
source ~/.config/nvim/init.haskell

hi clear Conceal
