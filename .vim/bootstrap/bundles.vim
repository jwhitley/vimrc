" Vundle prelude; see https://github.com/gmarik/vundle
filetype off  " required!

let s:bundle_home=Dot_vim("bundle")
let s:vundle_home=Dot_vim("bundle/vundle")

if !isdirectory(Dot_vim("bundle/vundle/.git"))
  silent exec "!mkdir -p ".s:bundle_home
  silent exec "!git clone git://github.com/gmarik/vundle.git ".s:vundle_home
  let s:bootstrap=1
endif

exec "set rtp+=".s:vundle_home
call vundle#rc(s:bundle_home)

" let Vundle manage Vundle
" required!
Plugin       'gmarik/vundle'

" Dependencies of other bundles
Plugin     'jwhitley/vim-matchit'

" My Plugins here:
"

" These plugins do not coexist well with vimpager; don't load them in vimpager
" sessions.
if ! exists("vimpager")
  Plugin       'tpope/vim-obsession'
  Plugin 'dhruvasagar/vim-prosession'
  Plugin      'spiiph/vim-space'
endif

Plugin       'mileszs/ack.vim'
Plugin         'rking/ag.vim'
Plugin           'sjl/badwolf'
Plugin   'vim-scripts/bufkill.vim'
Plugin   'vim-scripts/camelcasemotion'
Plugin  'editorconfig/editorconfig-vim'
Plugin           'sjl/clam.vim'
Plugin          'kien/ctrlp.vim'
Plugin      'Raimondi/delimitMate'
Plugin         'mattn/emmet-vim'
Plugin      'eagletmt/ghcmod-vim'
Plugin    'gregsexton/gitv'
Plugin        'henrik/git-grep-vim'
Plugin           'sjl/gundo.vim'
Plugin   'vim-scripts/keepcase.vim'
Plugin    'scrooloose/nerdtree'
Plugin        'henrik/rename.vim'
Plugin         'wting/rust.vim'
Plugin       'ciaranm/securemodelines'
Plugin    'scrooloose/syntastic'
Plugin     'godlygeek/tabular'
Plugin    'majutsushi/tagbar'
Plugin    'timcharper/textile.vim'
Plugin        'SirVer/ultisnips'
Plugin      'jwhitley/Vagrantfile.vim'
Plugin         'tpope/vim-abolish'
Plugin         'bling/vim-airline'
Plugin        'kchmck/vim-coffee-script'
Plugin      'jwhitley/vim-colors-solarized'
Plugin         'tpope/vim-commentary'
Plugin         'tpope/vim-dispatch'
Plugin         'tpope/vim-endwise'
Plugin       'terryma/vim-expand-region'
Plugin         'tpope/vim-fugitive'
Plugin      'jnwhiteh/vim-golang'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin  'austintaylor/vim-indentobject'
Plugin        'wgibbs/vim-irblack'
Plugin   'digitaltoad/vim-jade'
Plugin      'pangloss/vim-javascript'
Plugin        'jelera/vim-javascript-syntax'
Plugin     'mintplant/vim-literate-coffeescript'
Plugin         'tpope/vim-markdown'
Plugin      'nelstrom/vim-markdown-folding'
Plugin         'xolox/vim-misc'
Plugin       'terryma/vim-multiple-cursors'
Plugin         'jistr/vim-nerdtree-tabs'
Plugin  'tangledhelix/vim-octopress'
Plugin      'jwhitley/vim-preserve'
Plugin        'rodjek/vim-puppet'
Plugin        'henrik/vim-qargs'
Plugin         'tpope/vim-rails'
Plugin         'tpope/vim-repeat'
Plugin      'jwhitley/vim-repotools'
Plugin      'vim-ruby/vim-ruby'
Plugin        'sunaku/vim-ruby-minitest'
Plugin      'goldfeld/vim-seek'
Plugin         'mhinz/vim-signify'
Plugin      'jpalardy/vim-slime'
Plugin     'duganchen/vim-soy'
Plugin         'tpope/vim-surround'
Plugin          'kana/vim-textobj-entire'
Plugin          'kana/vim-textobj-line'
Plugin      'nelstrom/vim-textobj-rubyblock'
Plugin          'kana/vim-textobj-user'
Plugin  'tmux-plugins/vim-tmux'
Plugin   'christoomey/vim-tmux-navigator'
Plugin      'jwhitley/vim-visual-star-search'
Plugin       'skalnik/vim-vroom'

if exists("s:bootstrap") && s:bootstrap
  unlet s:bootstrap
  autocmd VimEnter * PluginInstall
endif

filetype plugin indent on     " required!
