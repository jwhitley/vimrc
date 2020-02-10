" Vim plugin prelude

let s:bundle_home=Dot_vim("bundle")
let s:plug_tool_home=Dot_vim("bundle/vim-plug")

if !isdirectory(Dot_vim("bundle/vim-plug/.git"))
  silent exec "!mkdir -p ".s:bundle_home
  silent exec "!git clone --depth 1 https://github.com/jwhitley/vim-plug.git ".s:plug_tool_home
  let s:bootstrap=1
endif

exec "set rtp+=".s:plug_tool_home
call plug#begin(s:bundle_home)

" let vim-plug manage vim-plug
Plug       'jwhitley/vim-plug'

" Dependencies of other bundles
Plug     'jwhitley/vim-matchit'

"""
""" Conditionally loaded plugins
"""

if ! exists("vimpager")
" These plugins do not coexist well with vimpager; don't load them in vimpager
" sessions.
  Plug       'tpope/vim-obsession'
  Plug 'dhruvasagar/vim-prosession'   " depends on tpope/vim-obsession

" Optimize vimpager load times by omitting these plugins
  Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
  Plug    'neoclide/coc.nvim', {'branch': 'release'}
endif

" Only load under tmux
if exists('$TMUX')
Plug  'tmux-plugins/vim-tmux'
Plug   'christoomey/vim-tmux-navigator'
endif

"""
""" Unconditionally loaded plugins
"""

Plug             'mileszs/ack.vim'
Plug               'rking/ag.vim'
Plug           'jiangmiao/auto-pairs'
Plug                 'sjl/badwolf'
Plug         'vim-scripts/bufkill.vim'
Plug         'vim-scripts/camelcasemotion'
Plug           'JulesWang/css.vim', { 'for': ['css'] }
Plug        'editorconfig/editorconfig-vim'
Plug               'rhysd/clever-f.vim'
Plug            'ctrlpvim/ctrlp.vim'
Plug            'jwhitley/dtd.vim', { 'for': ['dtd'] }
Plug               'mattn/emmet-vim'
Plug            'eagletmt/ghcmod-vim'
Plug          'gregsexton/gitv'
Plug              'henrik/git-grep-vim'
Plug                 'sjl/gundo.vim'
Plug         'vim-scripts/keepcase.vim'
Plug            'jwhitley/mxml.vim'
Plug          'scrooloose/nerdtree'
Plug              'henrik/rename.vim'
Plug           'rust-lang/rust.vim', { 'for': ['rs'] }
Plug             'ciaranm/securemodelines'
Plug               'keith/swift.vim', { 'for': ['swift'] }
Plug           'godlygeek/tabular'
Plug          'majutsushi/tagbar'
Plug            'jwhitley/tender.vim'
Plug            'jwhitley/Vagrantfile.vim'
Plug              'Shougo/vimproc.vim'
Plug               'tpope/vim-abolish'
Plug         'vim-airline/vim-airline'
Plug         'vim-airline/vim-airline-themes'
Plug            'jwhitley/vim-bolt', { 'for': ['bolt'] }
Plug              'kchmck/vim-coffee-script', { 'for': ['coffee'] }
Plug            'jwhitley/vim-colors-solarized'
Plug               'tpope/vim-commentary'
Plug               'tpope/vim-dispatch'
Plug         'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }
Plug               'tpope/vim-endwise'
Plug             'terryma/vim-expand-region'
Plug               'tpope/vim-fugitive'
Plug            'jnwhiteh/vim-golang', { 'for': ['go'] }
Plug                'bitc/vim-hdevtools'
Plug           'machakann/vim-highlightedyank'
Plug       'nathanaelkane/vim-indent-guides'
Plug        'austintaylor/vim-indentobject'
Plug            'jwhitley/vim-irblack'
Plug            'pangloss/vim-javascript'
Plug                 'mxw/vim-jsx'
Plug            'jwhitley/vim-literate-coffeescript', { 'for': ['litcoffee'] }
Plug               'tpope/vim-markdown'
Plug            'nelstrom/vim-markdown-folding'
Plug            'jwhitley/vim-mdx-js'
Plug               'xolox/vim-misc'
Plug             'terryma/vim-multiple-cursors'
Plug               'jistr/vim-nerdtree-tabs'
Plug            'jwhitley/vim-preserve'
Plug              'rodjek/vim-puppet'
Plug               'tpope/vim-rails'
Plug     'reasonml-editor/vim-reason-plus'
Plug               'tpope/vim-repeat'
Plug            'jwhitley/vim-repotools'
Plug             'jremmen/vim-ripgrep'
Plug            'vim-ruby/vim-ruby', { 'for': ['rb'] }
Plug              'sunaku/vim-ruby-minitest', { 'for': ['rb'] }
Plug            'Raimondi/vim_search_objects'
Plug            'justinmk/vim-sneak'
Plug               'mhinz/vim-signify'
Plug            'jpalardy/vim-slime'
Plug               'tpope/vim-surround'
Plug           'jasonlong/vim-textobj-css'
Plug                'kana/vim-textobj-entire'
Plug                'kana/vim-textobj-line'
Plug            'nelstrom/vim-textobj-rubyblock', { 'for': ['rb'] }
Plug                'kana/vim-textobj-user'
Plug            'jwhitley/vim-visual-star-search'
Plug              'troydm/zoomwintab.vim'
Plug 'HerringtonDarkholme/yats.vim'

if exists("s:bootstrap") && s:bootstrap
  unlet s:bootstrap
  autocmd VimEnter * PlugInstall
endif

call plug#end()
