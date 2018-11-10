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

" These plugins do not coexist well with vimpager; don't load them in vimpager
" sessions.
if ! exists("vimpager")
  Plug       'tpope/vim-obsession'
  Plug 'dhruvasagar/vim-prosession'
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
Plug                'w0rp/ale'
Plug                 'sjl/badwolf'
Plug         'vim-scripts/bufkill.vim'
Plug         'vim-scripts/camelcasemotion'
Plug           'JulesWang/css.vim', { 'for': ['css'] }
Plug        'editorconfig/editorconfig-vim'
Plug               'rhysd/clever-f.vim'
Plug            'ctrlpvim/ctrlp.vim'
Plug            'Raimondi/delimitMate'
Plug              'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug            'jwhitley/dtd.vim', { 'for': ['dtd'] }
Plug               'mattn/emmet-vim'
Plug            'eagletmt/ghcmod-vim'
Plug          'gregsexton/gitv'
Plug              'henrik/git-grep-vim'
Plug                 'sjl/gundo.vim'
Plug         'vim-scripts/keepcase.vim'
Plug            'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug            'jwhitley/mxml.vim'
Plug                'ncm2/ncm2'
Plug                'ncm2/ncm2-bufword'
Plug                'ncm2/ncm2-html-subscope'
Plug                'ncm2/ncm2-markdown-subscope'
Plug                'ncm2/ncm2-path'
Plug                'ncm2/ncm2-tagprefix'
Plug          'scrooloose/nerdtree'
Plug                'chr4/nginx.vim'
Plug         'mhartington/nvim-typescript'
Plug               'roxma/nvim-yarp'
Plug              'henrik/rename.vim'
Plug           'rust-lang/rust.vim', { 'for': ['rs'] }
Plug             'ciaranm/securemodelines'
Plug               'keith/swift.vim', { 'for': ['swift'] }
Plug           'godlygeek/tabular'
Plug          'majutsushi/tagbar'
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
Plug            'peitalin/vim-jsx-typescript'
Plug            'jwhitley/vim-literate-coffeescript', { 'for': ['litcoffee'] }
Plug               'tpope/vim-markdown'
Plug            'nelstrom/vim-markdown-folding'
Plug               'xolox/vim-misc'
Plug             'terryma/vim-multiple-cursors'
Plug               'jistr/vim-nerdtree-tabs'
Plug            'jwhitley/vim-preserve'
Plug              'rodjek/vim-puppet'
Plug               'tpope/vim-rails'
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
Plug            'nelstrom/vim-textobj-rubyblock'
Plug                'kana/vim-textobj-user'
Plug            'jwhitley/vim-visual-star-search'
Plug              'troydm/zoomwintab.vim'
Plug 'HerringtonDarkholme/yats.vim'

if exists("s:bootstrap") && s:bootstrap
  unlet s:bootstrap
  autocmd VimEnter * PlugInstall
endif

call plug#end()
