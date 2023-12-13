" Vim plugin prelude

let s:bundle_home=Dot_vim("bundle")

if !isdirectory(Dot_vim("bundle"))
  silent exec "!mkdir -p ".s:bundle_home
  let s:bootstrap=1
endif

call plug#begin(s:bundle_home)

" Dependencies of other bundles
Plug     'jwhitley/vim-matchit'

" Only load under tmux
if exists('$TMUX')
Plug  'tmux-plugins/vim-tmux'
Plug   'christoomey/vim-tmux-navigator'
endif

"""
""" Unconditionally loaded plugins
"""

" FIXME: endwise disabled as it conflicts with coc completion bindings
" Plug               'tpope/vim-endwise'
Plug          'Raimondi/delimitMate'
Plug       'vim-scripts/camelcasemotion'
Plug           'pskpatil/vim-securemodelines'
Plug         'godlygeek/tabular'
Plug             'tpope/vim-surround'
Plug         'jasonlong/vim-textobj-css'
Plug              'kana/vim-textobj-entire'
Plug              'kana/vim-textobj-line'
Plug          'nelstrom/vim-textobj-rubyblock', { 'for': ['rb'] }
Plug              'kana/vim-textobj-user'
Plug          'justinmk/vim-sneak'
Plug             'tpope/vim-repeat'
Plug             'rhysd/clever-f.vim'

""" Plugins disable under VSCode
if (exists('g:vscode') == v:false)
Plug           'mileszs/ack.vim'
Plug             'rking/ag.vim'
Plug          'neoclide/coc.nvim', {'branch': 'release'}
Plug            'qpkorr/vim-bufkill'
Plug       'vim-scripts/CursorLineCurrentWindow'
Plug            'hail2u/vim-css3-syntax'
Plug      'editorconfig/editorconfig-vim'
Plug          'ctrlpvim/ctrlp.vim'
Plug          'jwhitley/dtd.vim', { 'for': ['dtd'] }
Plug             'mattn/emmet-vim'
Plug          'junegunn/fzf'
Plug          'eagletmt/ghcmod-vim'
Plug        'gregsexton/gitv'
Plug            'henrik/git-grep-vim'
Plug               'sjl/gundo.vim'
Plug       'vim-scripts/keepcase.vim'
Plug       'leafgarland/typescript-vim'
Plug          'jwhitley/mxml.vim'
Plug        'scrooloose/nerdtree'
Plug            'henrik/rename.vim'
Plug         'rust-lang/rust.vim', { 'for': ['rs'] }
Plug             'keith/swift.vim', { 'for': ['swift'] }
Plug          'jwhitley/vim-synthwave84'
Plug          'jwhitley/tender.vim'
Plug            'thinca/vim-themis'
Plug          'jwhitley/Vagrantfile.vim'
Plug          'jreybert/vimagit'
Plug            'Shougo/vimproc.vim'
Plug             'tpope/vim-abolish'
Plug       'vim-airline/vim-airline'
Plug       'vim-airline/vim-airline-themes'
Plug          'jwhitley/vim-bolt', { 'for': ['bolt'] }
Plug            'kchmck/vim-coffee-script', { 'for': ['coffee'] }
Plug        'lifepillar/vim-colortemplate'
Plug             'tpope/vim-commentary'
Plug             'tpope/vim-dispatch'
Plug       'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }
Plug           'terryma/vim-expand-region'
Plug             'tpope/vim-fugitive'
Plug          'jnwhiteh/vim-golang', { 'for': ['go'] }
Plug              'bitc/vim-hdevtools'
Plug         'machakann/vim-highlightedyank'
Plug     'nathanaelkane/vim-indent-guides'
Plug      'austintaylor/vim-indentobject'
Plug          'jwhitley/vim-irblack'
Plug          'pangloss/vim-javascript'
Plug          'peitalin/vim-jsx-typescript'
Plug          'jwhitley/vim-literate-coffeescript', { 'for': ['litcoffee'] }
Plug             'tpope/vim-markdown'
Plug          'nelstrom/vim-markdown-folding'
Plug          'jwhitley/vim-mdx-js'
Plug             'xolox/vim-misc'
Plug             'jistr/vim-nerdtree-tabs'
Plug             'tpope/vim-obsession'
Plug       'dhruvasagar/vim-prosession'   " requires vim-obsession
Plug          'jwhitley/vim-preserve'
Plug            'rodjek/vim-puppet'
Plug             'tpope/vim-rails'
Plug          'jwhitley/vim-repotools'
Plug          'vim-ruby/vim-ruby', { 'for': ['rb'] }
Plug            'sunaku/vim-ruby-minitest', { 'for': ['rb'] }
Plug          'Raimondi/vim_search_objects'
Plug            'inside/vim-search-pulse'
Plug             'mhinz/vim-signify'
Plug          'jpalardy/vim-slime'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug          'jwhitley/vim-visual-star-search'
Plug        'liuchengxu/vista.vim'
Plug            'troydm/zoomwintab.vim'
endif

if exists("s:bootstrap") && s:bootstrap
  unlet s:bootstrap
  autocmd VimEnter * PlugInstall
endif

call plug#end()
