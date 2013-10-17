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
Bundle       'gmarik/vundle'

" Dependencies of other bundles
Bundle     'jwhitley/vim-matchit'

" My Bundles here:
"
Bundle       'epmatsw/ag.vim'
Bundle           'sjl/badwolf'
Bundle   'vim-scripts/bufkill.vim'
Bundle   'vim-scripts/camelcasemotion'
Bundle  'editorconfig/editorconfig-vim'
Bundle           'sjl/clam.vim'
Bundle          'kien/ctrlp.vim'
Bundle      'Raimondi/delimitMate'
Bundle    'gregsexton/gitv'
Bundle        'henrik/git-grep-vim'
Bundle           'sjl/gundo.vim'
Bundle   'vim-scripts/keepcase.vim'
Bundle    'scrooloose/nerdtree'
Bundle        'nosami/Omnisharp'
Bundle        'henrik/rename.vim'
Bundle         'wting/rust.vim'
Bundle       'ciaranm/securemodelines'
Bundle    'scrooloose/syntastic'
Bundle     'godlygeek/tabular'
Bundle    'majutsushi/tagbar'
Bundle    'timcharper/textile.vim'
Bundle        'SirVer/ultisnips'
Bundle      'jwhitley/Vagrantfile.vim'
Bundle         'tpope/vim-abolish'
Bundle         'bling/vim-airline'
Bundle        'kchmck/vim-coffee-script'
Bundle      'jwhitley/vim-colors-solarized'
Bundle         'tpope/vim-commentary'
Bundle         'tpope/vim-dispatch'
Bundle         'tpope/vim-endwise'
Bundle       'terryma/vim-expand-region'
Bundle         'tpope/vim-fugitive'
Bundle      'jnwhiteh/vim-golang'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle  'austintaylor/vim-indentobject'
Bundle        'wgibbs/vim-irblack'
Bundle   'digitaltoad/vim-jade'
Bundle      'pangloss/vim-javascript'
Bundle        'jelera/vim-javascript-syntax'
Bundle     'mintplant/vim-literate-coffeescript'
Bundle         'tpope/vim-markdown'
Bundle      'nelstrom/vim-markdown-folding'
Bundle         'xolox/vim-misc'
Bundle       'terryma/vim-multiple-cursors'
Bundle         'jistr/vim-nerdtree-tabs'
Bundle  'tangledhelix/vim-octopress'
Bundle      'jwhitley/vim-open-url'
Bundle        'rodjek/vim-puppet'
Bundle        'henrik/vim-qargs'
Bundle         'tpope/vim-rails'
Bundle         'tpope/vim-repeat'
Bundle      'jwhitley/vim-repotools'
Bundle      'vim-ruby/vim-ruby'
Bundle        'sunaku/vim-ruby-minitest'
Bundle      'goldfeld/vim-seek'
Bundle         'xolox/vim-session'
Bundle         'mhinz/vim-signify'
Bundle      'jpalardy/vim-slime'
Bundle     'duganchen/vim-soy'
if ! exists("vimpager")
  Bundle      'spiiph/vim-space'
endif
Bundle        'tpope/vim-surround'
Bundle         'kana/vim-textobj-entire'
Bundle         'kana/vim-textobj-line'
Bundle     'nelstrom/vim-textobj-rubyblock'
Bundle         'kana/vim-textobj-user'
Bundle  'christoomey/vim-tmux-navigator'
Bundle     'jwhitley/vim-visual-star-search'
Bundle      'skalnik/vim-vroom'

if exists("s:bootstrap") && s:bootstrap
  unlet s:bootstrap
  autocmd VimEnter * BundleInstall
endif

filetype plugin indent on     " required!
