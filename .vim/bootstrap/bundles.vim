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

Plug       'mileszs/ack.vim'
Plug         'rking/ag.vim'
Plug           'sjl/badwolf'
Plug   'vim-scripts/bufkill.vim'
Plug   'vim-scripts/camelcasemotion'
Plug     'JulesWang/css.vim'
Plug  'editorconfig/editorconfig-vim'
Plug           'sjl/clam.vim'
Plug         'rhysd/clever-f.vim'
Plug      'ctrlpvim/ctrlp.vim'
Plug      'Raimondi/delimitMate'
Plug         'mattn/emmet-vim'
Plug      'eagletmt/ghcmod-vim'
Plug    'gregsexton/gitv'
Plug        'henrik/git-grep-vim'
Plug           'sjl/gundo.vim'
Plug   'vim-scripts/keepcase.vim'
Plug          'bitc/lushtags'
Plug    'scrooloose/nerdtree'
Plug        'henrik/rename.vim'
Plug         'wting/rust.vim'
Plug       'ciaranm/securemodelines'
Plug    'scrooloose/syntastic'
Plug     'godlygeek/tabular'
Plug    'majutsushi/tagbar'
Plug    'timcharper/textile.vim'
Plug       'davidoc/taskpaper.vim'
Plug      'jwhitley/Vagrantfile.vim'
Plug        'Shougo/vimproc.vim'
Plug         'tpope/vim-abolish'
Plug         'bling/vim-airline'
Plug        'kchmck/vim-coffee-script'
Plug      'jwhitley/vim-colors-solarized'
Plug         'tpope/vim-commentary'
Plug         'tpope/vim-dispatch'
Plug   'elixir-lang/vim-elixir'
Plug         'tpope/vim-endwise'
Plug       'terryma/vim-expand-region'
Plug         'tpope/vim-fugitive'
Plug      'jnwhiteh/vim-golang'
Plug          'bitc/vim-hdevtools'
Plug 'nathanaelkane/vim-indent-guides'
Plug  'austintaylor/vim-indentobject'
Plug        'wgibbs/vim-irblack'
Plug   'digitaltoad/vim-jade'
Plug      'pangloss/vim-javascript'
Plug        'jelera/vim-javascript-syntax'
Plug     'mintplant/vim-literate-coffeescript'
Plug         'tpope/vim-markdown'
Plug      'nelstrom/vim-markdown-folding'
Plug         'xolox/vim-misc'
Plug       'terryma/vim-multiple-cursors'
Plug         'jistr/vim-nerdtree-tabs'
Plug  'tangledhelix/vim-octopress'
Plug      'jwhitley/vim-preserve'
Plug        'rodjek/vim-puppet'
Plug        'henrik/vim-qargs'
Plug         'tpope/vim-rails'
Plug         'tpope/vim-repeat'
Plug      'jwhitley/vim-repotools'
Plug      'vim-ruby/vim-ruby'
Plug        'sunaku/vim-ruby-minitest'
Plug      'Raimondi/vim_search_objects'
Plug      'justinmk/vim-sneak'
Plug         'mhinz/vim-signify'
Plug      'jpalardy/vim-slime'
Plug     'duganchen/vim-soy'
Plug         'tpope/vim-surround'
Plug          'kana/vim-textobj-entire'
Plug          'kana/vim-textobj-line'
Plug      'nelstrom/vim-textobj-rubyblock'
Plug          'kana/vim-textobj-user'
Plug      'jwhitley/vim-vimperator'
Plug      'jwhitley/vim-visual-star-search'
Plug       'skalnik/vim-vroom'
Plug        'troydm/zoomwintab.vim'

if exists("s:bootstrap") && s:bootstrap
  unlet s:bootstrap
  autocmd VimEnter * PlugInstall
endif

call plug#end()
