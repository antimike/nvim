call plug#begin('~/.config/nvim/vim-plug')
"" vim-plug section
"" How to disable a plugin:
"" Option 1: Plug 'random-plugin', { 'on': [] }
"" Option 2: call remove(g:plugs, 'plugin-name')

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

"" Eye candy
Plug 'vim-airline/vim-airline'
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#poetv#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#denite#enabled = 1
Plug 'ryanoasis/vim-devicons'
" Color options for lightline: powerline, wombat, jellybeans, solarized dark, solarized
" light, PaperColor light, seoul256, one dark, one light, landscape
"let g:lightline = { 'colorscheme': 'one dark' }

"" New plugins
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'fatih/vim-go'
Plug 'AndrewRadev/inline_edit.vim'
Plug 'amiorin/vim-fenced-code-blocks', { 'for': ['markdown'] } 
Plug 'goerz/jupytext.vim' 
Plug 'jpalardy/vim-slime', { 'for': ['python', 'julia'] }
Plug 'hanschen/vim-ipython-cell', { 'for': ['python', 'julia'] }
Plug 'puremourning/vimspector'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
let g:pydocstring_enable_mapping=0
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
Plug 'papis/papis-vim'
Plug 'wellle/targets.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'machakann/vim-sandwich'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
"Snippet repo for various languages
Plug 'honza/vim-snippets'
Plug 'kshenoy/vim-signature'
" Git branch viewer---updated GitV
Plug 'rbong/vim-flog'
Plug 'tomtom/quickfixsigns_vim'
Plug 'jmcantrell/vim-virtualenv'

Plug 'jreybert/vimagit'
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['tex']
Plug 'Yggdroot/LeaderF'
Plug 'justinmk/vim-sneak'
Plug 'sbdchd/neoformat'
Plug 'lambdalisue/vim-backslash'
let g:vim_backslash_disable_default_mappings=1
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
Plug 'tpope/vim-afterimage'
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-yoink'
Plug 'amiorin/vim-project'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
let g:session_directory='~/.config/nvim/Sessions'
let g:session_autoload='no'
Plug 'tpope/vim-haystack'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mox-mox/vim-localsearch'
Plug 'petobens/poet-v', { 'on': [] }

"" Old plugins
Plug 'SirVer/ultisnips'
Plug 'ncm2/ncm2-ultisnips'
Plug 'vim-scripts/CRefVim'
Plug 'vim-scripts/DrawIt'
Plug 'chrisbra/NrrwRgn'
Plug 'vim-scripts/ShowMarks', { 'on': [] }

Plug 'jiangmiao/auto-pairs', { 'on': [] }
Plug 'chrisbra/csv.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/denite.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'VOID001/graph-easy-vim'
Plug 'junegunn/gv.vim'
Plug 'itchyny/lightline.vim'

Plug 'preservim/nerdcommenter'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'iberianpig/ranger-explorer.vim'
" To consider: 'ipod825/vim-netranger'
"Plug 'vifm/vifm.vim'
Plug 'mcchrish/nnn.vim'
"Plug 'alok/notational-fzf-vim'
Plug 'powerline/powerline', { 'on': [] }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Plug 'tools-life/taskwiki'
Plug 'edkolev/tmuxline.vim'
Plug 'mbbill/undotree'
Plug 'vim-scripts/utl.vim'
"Plug 'vim-vdebug/vdebug'
Plug 'inkarkat/vim-SyntaxRange'

" Completion managers
Plug 'roxma/nvim-yarp'
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc.nvim', { 'branch': 'release' } 
Plug 'dense-analysis/ale'
Plug 'hari-rangarajan/CCTree'
      
" Tag managers
Plug 'ludovicchabant/vim-gutentags', { 'on': [] }
"Plug 'preservim/tagbar'
Plug 'liuchengxu/vista.vim'
Plug 'LucHermitte/lh-tags'

Plug 'LucHermitte/lh-vim-lib'
Plug 'tpope/vim-dispatch', { 'on': [] }
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-flagship', { 'on': [] }
"Dependency for tig-explorer
Plug 'rbgrouleff/bclose.vim'
Plug 'iberianpig/tig-explorer.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'embear/vim-localvimrc'
Plug 'andymass/vim-matchup'
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
Plug 'dhruvasagar/vim-table-mode'
Plug 'blindFS/vim-taskwarrior'
"Plug 'idanarye/vim-vebugger'
Plug 'mg979/vim-visual-multi'
Plug 'michal-h21/vim-zettel'
Plug 'vimoutliner/vimoutliner'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
" Plug 'vimwiki/vimwiki'
Plug 'vim-voom/VOom'
Plug 'jalvesaq/zotcite'
Plug 'holomorph/vim-freefem'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'srstevenson/vim-picker'
Plug 'fszymanski/fzf-quickfix', {'on': 'Quickfix'}
call plug#end()
