" Modeline and notes {{{
" vim: set ft=vim.vimrc:
"
" The .vimrc of John Whitley
"
" }}}

" Environment {{{
  set nocompatible                     " must be first!

  " encoding setup
  set encoding=utf-8
  scriptencoding utf-8

  " REQUIRES ASYNC
  " The default updatetime of 4000ms is not good for async update
  set updatetime=100

  " Establish the .vim directory relative to this script, so that isolated
  " testing of this file in a clone repo works.
  let g:vimrc_home=expand("<sfile>:h")
  " Attempt to detect whether we've got a startfile using a neovim-style path
  " layout (.config/nvim/init.vim and .config/nvim) or a traditional vim style
  " layout (.vimrc and .vim/)
  if expand("<sfile>:t") == "init.vim"
    let g:vimrc_home.="/"
  else
    let g:vimrc_home.="/.vim/"
  endif

  function! Dot_vim(path)
    return g:vimrc_home.a:path
  endfunction

  " Enable nvim's true color mode
  if has('termguicolors')
    set termguicolors
  endif
" }}}

" Providers {{{
  let g:loaded_python_provider = 1
  let default_python="/usr/local/bin/python3"
  if executable(default_python)
    let g:python3_host_prog=default_python
  endif
" }}}

" Bundles {{{
  exec "source ".Dot_vim("bootstrap/bundles.vim")
" }}}

" General {{{
  syntax on

  " Setup for securemodelines plugin
  set modelines=0
  let g:secure_modelines_allowed_items = [
              \ "textwidth", "tw",
              \ "softtabstop", "sts",
              \ "tabstop", "ts",
              \ "shiftwidth", "sw",
              \ "expandtab", "et", "noexpandtab", "noet",
              \ "filetype", "ft",
              \ "foldmethod", "fdm",
              \ "foldmarker", "fmr",
              \ "foldlevel", "fdl",
              \ "readonly", "ro", "noreadonly", "noro",
              \ "rightleft", "rl", "norightleft", "norl",
              \ "spell",
              \ "spelllang"
              \ ]

  set background=dark

  " Allow backgrounding buffers without writing them, and remember marks/undo
  " for backgrounded buffers
  set hidden
  set history=1000

  set autoread                       " Read ext. changes when file is unchanged

  set wildmenu                       " Enhanced command-line completion

  " Search settings
  set ignorecase
  set smartcase
  set incsearch                      " Incremental search
  set hlsearch                       " Highlight search
  set showmatch                      " Show matching braces

  set nofoldenable
  set viewoptions=folds,options,cursor,unix,slash

  " Make splits open to right/bottom
  set splitright
  set splitbelow

  " 'spell' set by default is extremely annoying for any code-like
  " filetype, so I now default to 'nospell' and only turn spelling
  " on for known-useful filetypes.
  set nospell
  set spelllang=en_us

  set scrolloff=3                    " context off the end of a buffer

  set undofile                       " Persist undo info in <FILENAME>.un~
  silent !mkdir ~/.vimundo >& /dev/null
  set undodir=~/.vimundo

  " Store temporary files in a central spot

  " The trailing slash tells Vim to encode the absolute path of the file
  " into the swap file name.
  let vimtmp = $HOME . '/.vimtmp//'
  silent! call mkdir(vimtmp, "p", 0700)
  let &backupdir=vimtmp
  let &directory=vimtmp
" }}}

" Vim UI {{{
  set backspace=indent,eol,start     " backspace over everything in insert mode
  set listchars=tab:⤑\ ,trail:·,eol:¬

  if has('nvim')
    " Hide the end of buffer tilde; (that's a space)
    set fillchars=eob:\ 
    " Enable incremental substitute support
    set inccommand=nosplit
  endif

  if (exists('g:vscode') == v:true)
    set nonumber
    set signcolumn=no
  else
    augroup InitColorScheme
      autocmd!
      au VimEnter * colorscheme synthwave84 | AirlineTheme base16_eighties
    augroup END

    set number                         " Display line numbers ...
    set ruler                          " Display line number and column
  endif

  " Always display the status line, even in the last window
  " -- particularly useful with powerline
  set laststatus=2


  " set wildignore+=.git,.bzr,tmp,public/assets,node_modules

  " Switch to an existing tab if the buffer is open, otherwise
  " create a new tab
  " See http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
  " set switchbuf=usetab,newtab

  " Terminal settings {{{
    " Enable mouse/trackpad scrolling
    set mouse=a
    " Fix escape delay leaving insert mode
    " via https://powerline.readthedocs.org/en/latest/tipstricks.html
    set ttimeoutlen=10
    augroup FastEscape
      autocmd!
      au InsertEnter * set timeoutlen=150
      au InsertLeave * set timeoutlen=1000
    augroup END
    " Fix Cursor in TMUX
    if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
  " }}}

  " GUI settings {{{
    set guioptions-=T
    set guifont=Dank\ Mono:h16,Source\ Code\ Pro\ Light\ for\ Powerline:h16,Anonymous\ Pro\ for\ Powerline:h16,Menlo:h18:Consolas\ Regular:h16,Courier\ New\ Regular:h18

    if has('gui_macvim')
      set lines=50
      set columns=84
      set transparency=3
    endif
  " }}}
" }}}

" Formatting {{{
  set wrap
  set formatoptions=qrn1
  set colorcolumn=100
  " Tabs
  set autoindent
  set smarttab
  set expandtab
  set shiftwidth=2
  set shiftround
  set softtabstop=2

  function! TrimTrailingWhitespace()
    keeppattern %s/\s\+$//e
  endfunction

  " Syntax-specific settings
  let hs_highlight_types = 1
  let hs_highlight_more_types = 1

  " The default formatting for typescriptReserved is 'Error' which is
  " utterly offensive. A recently-introduce neovim bug (circa 2786d96)
  " is causing the typescript-vim plugin to not set/override this stupidity
  " correctly. Hack it for now.
  " Filed as https://github.com/leafgarland/typescript-vim/issues/184
  hi link typescriptReserved             Keyword
" }}}

" Folding {{{

  " Make zO recursively open whatever top level fold we're in, no matter where the
  " cursor happens to be.
  nnoremap zO zCzO
" }}}

" Key Mappings {{{
  let mapleader="\<space>"
  let maplocalleader=";"

  " used with vim's :terminal and neovim's :term
  if exists(':tnoremap')
    " Term mode mappings
    tnoremap <c-h> <c-\><c-n><c-w>h
    tnoremap <c-j> <c-\><c-n><c-w>j
    tnoremap <c-k> <c-\><c-n><c-w>k
    tnoremap <c-l> <c-\><c-n><c-w>l
    tnoremap <localleader>l <c-l>

    " Dual term/normal mode mappings
    tnoremap <silent> <localleader>z <c-\><c-n>:ZoomWinTabToggle<cr>
    nnoremap <silent> <localleader>z :ZoomWinTabToggle<cr>

    " Normal-mode mappings for use with :term
    if has('nvim')
      nnoremap <localleader>c :tabnew \| term<cr>
      nnoremap <localleader>\| :vsp \| term<cr>
      nnoremap <localleader>- :sp \| term<cr>
      nnoremap <localleader>k :setlocal scrollback=1 \| setlocal scrollback=100000<cr>
      augroup NeovimTerminal
        autocmd!
        autocmd TermOpen * setlocal scrollback=100000
        autocmd TermOpen * nnoremap <cr> i
      augroup END
    endif
  endif

  " Run the last macro ...
  nnoremap Q @@
  " ... and lock out the rest of ex-mode
  nnoremap gQ <nop>

  " <tab> matches bracket pairs
  nnoremap <tab> %
  vnoremap <tab> %

  " Tired of :W producing an annoying error
  command W w

  " Write file without a final eol
  command WN setlocal binary noeol | w
  command WNQ setlocal binary noeol | wq

  " F1 better as ESC than help
  inoremap <F1> <ESC>
  nnoremap <F1> <ESC>
  vnoremap <F1> <ESC>

  " Buffer next/prev mappings
  nnoremap ]b :bnext<cr>
  nnoremap [b :bprevious<cr>

  " Window mappings, parallel with my tmux mappings
  nnoremap <c-w>- <c-w>s
  nnoremap <c-w>\| <c-w>v

  " Lock out arrow keys
  noremap <Up> <nop>
  noremap <Down> <nop>
  noremap <Left> <nop>
  noremap <Right> <nop>

  " Split movement shortcuts
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  " Improved command-line mode editing
  cnoremap <c-a> <Home>
  cnoremap <c-e> <End>
  cnoremap <c-n> <Down>
  cnoremap <c-p> <Up>
  cnoremap <c-j> <Down>
  cnoremap <c-k> <Up>

  function MapTabs(mapcmd, keypat, ...)
    let l:cmdpat = a:0 > 0 ? a:1 : "%dgt"
    for tabno in range(1,9)
      exec a:mapcmd . " " . printf(a:keypat, tabno) . " " . printf(l:cmdpat, tabno)
    endfor
  endfunction

  if has('gui_macvim')
    " jump to the corresponding Vim tab
    call MapTabs('nnoremap', '<D-%d>')
    nnoremap <D-0> :tablast<cr>

    call MapTabs('inoremap', '<D-%d>')
    inoremap <D-0> :tablast<cr>

    if has('fullscreen')
      noremap <D-CR> :set fullscreen!<CR>
    endif
  else
    " jump to the corresponding Vim tab

    call MapTabs('nnoremap', '<c-]>%d')
    nnoremap <c-]>0 :tablast<cr>

    call MapTabs('inoremap', '<c-]>%d')
    inoremap <c-]>0 :tablast<cr>

    if exists(':tnoremap')
      call MapTabs('tnoremap', '<c-]>%d', '<c-\><c-n>%dgt')
      tnoremap <c-]>0 <c-\><c-n>:tablast<cr>
    endif
  endif

  function! CurrDir()
    let l:lpwd=expand('%:h')
    return escape(empty(l:lpwd) ? getcwd() : l:lpwd, ' ')
  endfunction
  " Expands to the current file's directory or cwd
  cnoremap %% <c-r>=CurrDir().'/'<cr>

  " Leader Mappings

  " Toggle most recent buffer
  nnoremap <leader>' <c-^>

  " Clear search highlight
  "   This can't be baked into a function due to vim restoring search state
  "   when exiting a function, See :h function-search-undo
  nnoremap <silent> <leader><leader> :if v:hlsearch \| nohlsearch \| endif<cr>

  " Yank/put to/from system clipboard
  nnoremap <leader>y "*y
  vnoremap <leader>y "*y
  nnoremap <leader>p "*p
  nnoremap <leader>P "*P

  " See mapping of '%%', above
  nmap <leader>ew :e %%
  nmap <leader>es :sp %%
  nmap <leader>ev :vsp %%
  nmap <leader>et :tabe %%

  " Show syntax highlighting stack for word under cursor
  nnoremap <silent> <F10> :call <SID>SynStack()<CR>
  function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunction

  " http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
  map <F11> :call <SID>SynGroups()<cr>
  function! <SID>SynGroups()
    let l:hi = synIDattr(synID(line("."),col("."),1),"name")
    let l:trans = synIDattr(synID(line("."),col("."),0),"name")
    let l:lo = synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
    echo "hi<" . l:hi . "> trans<" . l:trans . "> lo<" . l:lo . ">"
  endfunction

  " fugitive-style invocation for Git Tower
  if has('mac')
    nnoremap <leader>gv :silent !gittower -s >& /dev/null<cr>
  endif

" }}}

" {{{ Commands
  " Marked.app
  " via http://stackoverflow.com/questions/7483130
  command! Marked silent exe "!open -a Marked\\ 2.app " . shellescape(expand("%:p"))

  " :Q is a shortcut for :qall
  " :Q! 'forgets' the current vim-obsession managed session before exiting
  function! QuitAll(bang)
    if a:bang && exists("g:loaded_obsession")
      Obsession!
    endif
    qall
  endfunction
  command! -bang Q call QuitAll(<bang>0)<cr>
" }}}

" Plugins {{{
  " ag.vim {{{
    nnoremap <leader>* *:AgFromSearch<cr>
  " }}}

  " vim-airline {{{
    set noshowmode                     " Redundant when used with airline/powerline
    let g:airline_powerline_fonts = 1
    let g:airline_section_z = ' %3l:%3c'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline#extensions#tabline#show_close_button = 0
    let g:airline#extensions#tabline#show_splits = 0
    let g:airline#extensions#tabline#show_tab_count = 0
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#tabs_label = ''
    let g:airline#extensions#hunks#enabled = 0
    augroup AirlineColorScheme
      autocmd!
      au ColorScheme * AirlineTheme g:colors_name
    augroup END
  " }}}

  " CoC {{{
  if exists('g:did_coc_loaded')
    " Prevent |ins-completion-menu| messages
    set shortmess+=c

    let g:coc_global_extensions = [
          \ 'coc-actions',
          \ 'coc-css',
          \ 'coc-highlight',
          \ 'coc-html',
          \ 'coc-json',
          \ 'coc-reason',
          \ 'coc-python',
          \ 'coc-snippets',
          \ 'coc-spell-checker',
          \ 'coc-tsserver',
          \ 'coc-vimlsp',
          \]

    " map <tab> to trigger completion, completion confirm, snippet expand, and
    " jump ala VSCode. Requires coc-snippet
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? coc#_select_confirm() :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'

    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
    inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Note: These do not work with `noremap`
    nmap <leader>lc <Plug>(coc-references)
    nmap <leader>ld <Plug>(coc-definition)
    nmap <leader>li <Plug>(coc-implementation)
    nmap <leader>lr <Plug>(coc-rename)
    nmap <leader>ls <Plug>(coc-documentSymbols)
    nmap <leader>lt <Plug>(coc-type-definition)

    vmap <leader>lf <Plug>(coc-format-selected)
    nmap <leader>lf <Plug>(coc-format-selected)

    nmap <silent> [d <Plug>(coc-diagnostic-prev)
    nmap <silent> ]d <Plug>(coc-diagnostic-next)

    " Navigation snippet sections with C-j/k
    let g:coc_snippet_next = '<C-j>'
    let g:coc_snippet_prev = '<C-k>'

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','vim.vimrc','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Start multiple cursors session with current word
    nmap <leader>r :CocCommand document.renameCurrentWord<CR>

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup cocSetup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " NOTE: Requires coc-action
    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    function! s:cocActionsOpenFromSelected(type) abort
      execute 'CocCommand actions.open ' . a:type
    endfunction
    xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
    nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    nmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <TAB> <Plug>(coc-range-select)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold   :call CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')
  endif
  " }}}

  " vimagit {{{
    nmap <leader>m :Magit<cr>
  " }}}

  " vim-colortemplate {{{
    let g:colortemplate_no_mappings = 1
  " }}}

  " vim-commentary {{{
    let g:commentary_map_backslash = 0
  " }}}

  " ctrlp {{{
    if !exists("g:ctrlp_extensions")
      let g:ctrlp_extensions = []
    endif
    let g:ctrlp_extensions += ['buffertag', 'changes']
    let g:ctrlp_working_path_mode = 2
    let g:ctrlp_map = '<leader>ff'
    let g:ctrlp_mruf_relative = 1
    let g:ctrlp_mruf_exclude = '/\.git/.*\|^/var/folders.*'
    let g:ctrlp_match_window_reversed = 0
    " Adding .vim/bundle hacks CtrlP into not using the -o option in $HOME,
    " where it's terribly slow.
    let g:ctrlp_user_command = {
      \ 'types': {
        \ 1: ['.config/vcsh/', 'cd %s && vcsh-ls-files'],
        \ 2: ['.bzr/', 'cd %s && echo bzr'],
        \ 3: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
        \ 4: ['.hg/',  'cd %s && hg status -cu | cut -f 2 -d" " | sort'],
        \ }
      \ }

    let g:ctrlp_buftag_types = {
      \ 'coffee' : {
        \ 'bin': 'coffeetags',
        \ },
      \ }
    nnoremap <silent> <leader>fb :CtrlPBuffer<CR>
    nnoremap <silent> <leader>fm :CtrlPMRU<CR>
    nnoremap <silent> <leader>ft :CtrlPBufTag<CR>

    let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$\|\node_modules\|public/assets',
      \ 'file': '\.exe$\|\.so$\|\.dll$\|\.vagrant$' }
  "}}}

  " CursorLineCurrentWindow {{{
    set cursorline
  " }}}

  " emmet-vim {{{
  if (exists('g:loaded_emmet_vim') && g:loaded_emmet_vim)
    let g:user_emmet_install_global = 0
    let g:user_emmet_leader_key='<C-e>'
    autocmd FileType javascript,php,html,css EmmetInstall
    let g:user_emmet_settings = {
      \ 'javascript.jsx': { 'extends': 'jsx' }
    \ }
  endif
  " }}}

  " vim-fugitive {{{
    nnoremap <silent> <leader>gs :Git<CR>
    nnoremap <silent> <leader>gd :Gdiffsplit<CR>
    nnoremap <silent> <leader>gc :Git commit<CR>
    nnoremap <silent> <leader>gb :Git blame<CR>
    nnoremap <silent> <leader>gl :Git log<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <leader>gu :Git add -u<CR>

    " Restore prior fugitive status binding for 'q'
    augroup Fugitive
      autocmd!
      autocmd FileType fugitive nnoremap <buffer> q <C-W>q
      autocmd FileType fugitive nmap <buffer> <C-N> )
      autocmd FileType fugitive nmap <buffer> <C-P> (
    augroup END
  "}}}

  " gundo.vim {{{
    nnoremap <leader>u :GundoToggle<cr>
  " }}}

  " vim-hdevtools {{{
    augroup Hdevtools
      autocmd!
      autocmd FileType haskell nnoremap <buffer> <leader>ht :HdevtoolsType<CR>
      autocmd FileType haskell nnoremap <buffer> <silent> <leader>hc :HdevtoolsClear<CR>
    augroup END

    let $PATH=Dot_vim("bundle/vim-hdevtools/.cabal-sandbox/bin").":".$PATH
  " }}}

  " lushtags {{{
    let $PATH=Dot_vim("bundle/lushtags/.cabal-sandbox/bin").":".$PATH
  " }}}

  " matchit {{{
    let b:match_ignorecase = 1
  " }}}

  " NERDTree {{{
    " Replace netrw with secondary NERDTree
    let NERDTreeHijackNetrw=1

    " Augmented with vim-nerdtree-tabs plugin
    nnoremap <leader>n :NERDTreeTabsToggle<cr>
    nnoremap <leader>fn :NERDTreeFind<cr>
    let g:nerdtree_tabs_open_on_gui_startup=0
  " }}}

  " vim-preserve {{{
    nnoremap <leader>$ <plug>(preserve-kill-trailing-whitespace)
    nnoremap <leader>= <plug>(preserve-reindent-file)
    nnoremap <leader>W <plug>(preserve-wombat)
  " }}}

  " vim-prosession {{{
    if exists('$TMUX')
      let g:prosession_tmux_title = 1
    endif
    let g:prosession_dir = Dot_vim("sessions")
    silent! call mkdir(g:prosession_dir, "p", 0700)
    let g:prosession_on_startup = 1
  " }}}

  " vim-signify {{{
    let g:signify_sign_change = '~'
  " }}}

  " vim-slime {{{
    let g:slime_target = "tmux"
  " }}}

  " vim-sneak {{{
    let g:sneak#s_next = 1
  " }}}

  " vim-surround {{{
    " Remap v_s to surround
    xmap s <Plug>VSurround
  " }}}

  " vista.vim {{{
    nnoremap <silent> <leader>t :Vista<cr>
  " }}}

  " tabular {{{
    nnoremap <leader>a\| :Tabularize /\|<cr>
    vnoremap <leader>a\| :Tabularize /\|<cr>
    " ah is for Haskell -- useful for guard and pattern match alignment
    nnoremap <leader>ah :Tabularize /[=\|]>\@!<cr>
    vnoremap <leader>ah :Tabularize /[=\|]>\@!<cr>
    nnoremap <leader>a= :Tabularize /=<cr>
    vnoremap <leader>a= :Tabularize /=<cr>
    nnoremap <leader>a: :Tabularize /:\zs<cr>
    vnoremap <leader>a: :Tabularize /:\zs<cr>
    nnoremap <leader>a. :Tabularize /^[^.]*\zs\./r0c0l0<cr>
    vnoremap <leader>a. :Tabularize /^[^.]*\zs\./r0c0l0<cr>
    " Tabularize Bundle declarations
    augroup CustomTabularize
      autocmd!
      autocmd VimEnter * if exists(":Tabularize") | exe ":AddTabularPattern! bundles /[^ ]\\+\\//l1r0" | endif

      autocmd BufRead */.vim/bootstrap/bundles.vim nnoremap <leader>ab :Tabularize bundles<cr>
      autocmd BufRead */.vim/bootstrap/bundles.vim vnoremap <leader>ab :Tabularize bundles<cr>
    augroup END
  " }}}
" }}}


" Autocmds {{{
  augroup vimrcEx
    " Clear all autocmds in the group
    autocmd!
    autocmd FileType bzr setlocal tw=72
    autocmd FileType gitcommit setlocal fo+=t fo-=q tw=72
    autocmd FileType markdown setlocal autoindent wrap tw=72
    autocmd FileType go setlocal noexpandtab ts=4 sw=4 sts=4

    " Set Mac .mailsignature files to use html syntax
    autocmd BufNewFile,BufRead *.mailsignature set ft=mailsignature
    autocmd BufNewFile,BufRead *.mailsignature set syntax=html

    " Filetypes to auto-trim trailing whitespace
    autocmd FileType javascript,ruby autocmd FileWritePre   * :call TrimTrailingWhitespace()
    autocmd FileType javascript,ruby autocmd FileAppendPre  * :call TrimTrailingWhitespace()
    autocmd FileType javascript,ruby autocmd FilterWritePre * :call TrimTrailingWhitespace()
    autocmd FileType javascript,ruby autocmd BufWritePre    * :call TrimTrailingWhitespace()

    " Set vim's c-style indenting options, including for javascript. See :h
    " cinoptions-values for details.
    set cinoptions=l1,:0

    " Jump to last cursor position unless it's invalid or in an event handler
    autocmd BufReadPost *
      \ if &filetype != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal g`\"" |
      \ endif

    " Override unknown filetypes in certain zsh directories
    autocmd BufNewFile,BufRead */.zfunctions/* if &ft == '' || &ft =~# '^\(conf\)$' | set filetype=zsh | endif
    autocmd BufNewFile,BufRead */.zlocal/* if &ft == '' || &ft =~# '^\(conf\)$' | set filetype=zsh | endif

    " Close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

    autocmd BufNewFile,BufRead Guardfile,Podfile,Fastfile set filetype=ruby
    autocmd BufNewFile,BufRead .gitconfig.local set filetype=gitconfig
  augroup END

  " Reload externally changed files
  "   via https://github.com/neovim/neovim/issues/2127#issuecomment-150954047
  augroup AutoSwap
          autocmd!
          autocmd SwapExists *  call AS_HandleSwapfile(expand('<afile>:p'), v:swapname)
  augroup END

  function! AS_HandleSwapfile (filename, swapname)
          " if swapfile is older than file itself, just get rid of it
          if getftime(v:swapname) < getftime(a:filename)
                  call delete(v:swapname)
                  let v:swapchoice = 'e'
          endif
  endfunction

  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
    \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

  augroup checktime
      au!
      if !has("gui_running")
          "silent! necessary otherwise throws errors when using command
          "line window.
          autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * if getcmdwintype() != '' | silent! checktime | endif
      endif
  augroup END
" }}}
