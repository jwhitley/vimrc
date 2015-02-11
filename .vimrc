" Modeline and notes {{{
" vim: set ft=vim.vimrc:
"
" The .vimrc of John Whitley
"
" }}}

" Environment {{{
  set nocompatible                     " must be first!
  set encoding=utf-8
  scriptencoding utf-8

  " Establish the .vim directory relative to this script, so that isolated
  " testing of this file in a clone repo works.
  let g:vimrc_home=expand("<sfile>:h")
  function! Dot_vim(path)
    return g:vimrc_home."/.vim/".a:path
  endfunction
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

  set spell
  set spelllang=en_us

  set scrolloff=3                    " context off the end of a buffer

  set undofile                       " Persist undo info in <FILENAME>.un~
  silent !mkdir ~/.vimundo >& /dev/null
  set undodir=~/.vimundo

  " Store temporary files in a central spot
  let vimtmp = $HOME . '/.tmp/' . getpid()
  silent! call mkdir(vimtmp, "p", 0700)
  let &backupdir=vimtmp
  let &directory=vimtmp
" }}}

" Vim UI {{{
  set backspace=indent,eol,start     " backspace over everything in insert mode
  set listchars=tab:⤑\ ,trail:·,eol:¬

  set background=dark
  if filereadable(Dot_vim("bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
    colorscheme solarized
  endif

  " Always display the status line, even in the last window
  " -- particularly useful with powerline
  set laststatus=2

  set number                         " Display line numbers ...
  set ruler                          " Display line number and column

  " set wildignore+=.git,.bzr,tmp,public/assets,node_modules

  " Switch to an existing tab if the buffer is open, otherwise
  " create a new tab
  " See http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
  " set switchbuf=usetab,newtab

  " Terminal settings {{{
    if !has('gui_running')
      " Enable mouse/trackpad scrolling
      set mouse=nicr
      " Fix escape delay leaving insert mode
      " via https://powerline.readthedocs.org/en/latest/tipstricks.html
      set ttimeoutlen=10
      augroup FastEscape
          autocmd!
          au InsertEnter * set timeoutlen=150
          au InsertLeave * set timeoutlen=1000
          " Fix Cursor in TMUX
          if exists('$TMUX')
            let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
            let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
          else
            let &t_SI = "\<Esc>]50;CursorShape=1\x7"
            let &t_EI = "\<Esc>]50;CursorShape=0\x7"
          endif
      augroup END
    endif
  " }}}

  " GUI settings {{{
    if has('gui_running')
      set lines=50
      set columns=84
      set guioptions-=T
      if has('gui_macvim')
        set transparency=3
      endif
      set guifont=Source\ Code\ Pro\ Light\ for\ Powerline:h16,Anonymous\ Pro\ for\ Powerline:h16,Menlo:h18:Consolas\ Regular:h16,Courier\ New\ Regular:h18
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
" }}}

" Folding {{{

  " Make zO recursively open whatever top level fold we're in, no matter where the
  " cursor happens to be.
  nnoremap zO zCzO
" }}}

" Key Mappings {{{
  " \ is the default leader
  let mapleader=";"

  " ... and temporarily lock out \ until we're fully switched to ;
  nnoremap \ :echoerr "Don't do that!"<cr>

  " Run the last macro ...
  nnoremap Q @@
  " ... and lock out the rest of ex-mode
  nnoremap gQ <nop>

  " Make jj a shortcut for ESC
  inoremap jj <ESC>

  " <tab> matches bracket pairs
  nnoremap <tab> %
  vnoremap <tab> %

  " Tired of :W producing an annoying error
  command W w

  " F1 better as ESC than help
  inoremap <F1> <ESC>
  nnoremap <F1> <ESC>
  vnoremap <F1> <ESC>

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

  if has('gui_macvim')
    " jump to the corresponding Vim tab
    nnoremap <D-1> 1gt
    nnoremap <D-2> 2gt
    nnoremap <D-3> 3gt
    nnoremap <D-4> 4gt
    nnoremap <D-5> 5gt
    nnoremap <D-6> 6gt
    nnoremap <D-7> 7gt
    nnoremap <D-8> 8gt
    nnoremap <D-9> 9gt
    nnoremap <D-0> :tablast<cr>

    inoremap <D-1> 1gt
    inoremap <D-2> 2gt
    inoremap <D-3> 3gt
    inoremap <D-4> 4gt
    inoremap <D-5> 5gt
    inoremap <D-6> 6gt
    inoremap <D-7> 7gt
    inoremap <D-8> 8gt
    inoremap <D-9> 9gt
    inoremap <D-0> :tablast<cr>

    if has('fullscreen')
      noremap <D-CR> :set fullscreen!<CR>
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
  nnoremap <silent> <leader><space> :nohlsearch<cr>

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

  " http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
  map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

  " fugitive-style invocation for Git Tower
  if has('mac')
    nnoremap <leader>gv :silent !gittower -s >& /dev/null<cr>
  endif

" }}}

" {{{ Commands
  " Marked.app
  " via http://stackoverflow.com/questions/7483130
  command! Marked silent !open -a "Marked.app" expand("%:p")

  command! Q :qall
" }}}

" Plugins {{{
  " vim-airline {{{
    set noshowmode                     " Redundant when used with airline/powerline
    let g:airline_powerline_fonts = 1
    let g:airline_section_z = ' %3l:%3c'
  " }}}

  " vim-commentary {{{
    let g:commentary_map_backslash = 0
  " }}}

  " matchit {{{
    let b:match_ignorecase = 1
  " }}}

  " ctrlp {{{
    if !exists("g:ctrlp_extensions")
      let g:ctrlp_extensions = []
    endif
    let g:ctrlp_extensions += ['buffertag', 'changes']
    let g:ctrlp_working_path_mode = 2
    let g:ctrlp_map = '<leader>ff'
    let g:ctrlp_mruf_relative = 1
    let g:ctrlp_mruf_exclude = '/\.git/.*\|^/tmp/vimpager.*\|^/var/folders.*'
    let g:ctrlp_match_window_reversed = 0
    " Adding .vim/bundle hacks CtrlP into not using the -o option in $HOME,
    " where it's terribly slow.
    let g:ctrlp_user_command = {
      \ 'types': {
        \ 1: ['.config/vcsh/', 'cd %s && vcsh-ls-files'],
        \ 2: ['.bzr/', 'cd %s && echo bzr'],
        \ 3: ['.git/', 'cd %s && git ls-files -co --exclude-standard'],
        \ 4: ['.hg/',  'cd %s && hg status -cu | cut -f 2 -d" " | sort'],
        \ }
      \ }

    let g:ctrlp_buftag_types = {
      \ 'coffee' : {
        \ 'bin': 'coffeetags',
        \ },
      \ }
    nnoremap <silent> <leader>fb :CtrlPBuffer<CR>
    nnoremap <silent> <leader>fr :CtrlPMRU<CR>
    nnoremap <silent> <leader>ft :CtrlPBufTag<CR>

    let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$\|\node_modules\|public/assets',
      \ 'file': '\.exe$\|\.so$\|\.dll$\|\.vagrant$' }
  "}}}

  " Fugitive {{{
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <leader>gu :Git add -u<CR>
  "}}}

  " emmet {{{
    let g:user_emmet_install_global = 0
    let g:user_emmet_leader_key='<C-e>'
    autocmd FileType html,css EmmetInstall
  " }}}

  " tabular {{{
    nnoremap <leader>a\| :Tabularize /\|<cr>
    vnoremap <leader>a\| :Tabularize /\|<cr>
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

  " NERDTree {{{
    " Replace netrw with secondary NERDTree
    let NERDTreeHijackNetrw=1

    " Augmented with vim-nerdtree-tabs plugin
    nnoremap <leader>n :NERDTreeTabsToggle<cr>
    nnoremap <leader>fn :NERDTreeFind<cr>

    function! NERDTreeTabsOpener()
      " The number of columns for the trigger is the total width of:
      " - a NERDTree window
      " - a help window
      " - a four-column line number gutter
      if &columns < 114
        let g:nerdtree_tabs_open_on_gui_startup=0
      else
        let g:nerdtree_tabs_open_on_gui_startup=1
      endif
    endfunction
    call NERDTreeTabsOpener()
    autocmd SessionLoadPost * call NERDTreeTabsOpener()
  " }}}

  " ag.vim {{{
    nnoremap <leader>* *:AgFromSearch<cr>
  " }}}

  " Gundo {{{
    nnoremap <leader>u :GundoToggle<cr>
  " }}}

  " lushtags {{{
    let $PATH=Dot_vim("bundle/lushtags/.cabal-sandbox/bin").":".$PATH
  " }}}

  " tagbar {{{
    nnoremap <silent> <leader>t :TagbarToggle<cr>
    let g:tagbar_type_go = {
      \ 'ctagstype': 'go',
      \ 'kinds'     : [
            \ 'f:func',
            \ 't:type',
            \ 'v:var',
            \ 'm:method',
      \ ]
    \ }

    if executable('coffeetags')
      let g:tagbar_type_coffee = {
            \ 'ctagsbin' : 'coffeetags',
            \ 'ctagsargs' : '',
            \ 'kinds' : [
            \ 'f:functions',
            \ 'o:object',
            \ ],
            \ 'sro' : ".",
            \ 'kind2scope' : {
            \ 'f' : 'object',
            \ 'o' : 'object',
            \ }
            \ }
    endif

    let g:tagbar_type_markdown = {
            \ 'ctagstype' : 'markdown',
            \ 'kinds' : [
                    \ 'h:Heading_L1',
                    \ 'i:Heading_L2',
                    \ 'k:Heading_L3'
            \ ]
    \ }
  " }}}

  " vim-slime {{{
    let g:slime_target = "tmux"
  " }}}

  " vim-surround {{{
    " Remap v_s to surround
    xmap s <Plug>VSurround
  " }}}

  " vim-space {{{
    " Avoid conflict on ]c and [c mappings with vim-signify
    " See https://github.com/spiiph/vim-space/issues/20
    let g:space_no_diff = 1
  " }}}

  " vim-signify {{{
    let g:signify_sign_change = '~'
  " }}}

  " UltiSnips {{{
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  " }}}

  " Syntastic {{{
    let g:syntastic_html_tidy_ignore_errors = [
          \ "proprietary attribute",
          \ ]
    if executable($HOME . '/.rbenv/shims/ruby')
      let g:syntastic_ruby_exec = $HOME . '/.rbenv/shims/ruby'
    endif
  " }}}

  " delimitMate {{{
    let delimitMate_expand_cr = 1
  " }}}

  " vim-hdevtools {{{
    au FileType haskell nnoremap <buffer> <leader>ht :HdevtoolsType<CR>
    au FileType haskell nnoremap <buffer> <silent> <leader>hc :HdevtoolsClear<CR>

    let $PATH=Dot_vim("bundle/vim-hdevtools/.cabal-sandbox/bin").":".$PATH
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
" }}}


" Autocmds {{{
  augroup vimrcEx
    " Clear all autocmds in the group
    autocmd!
    autocmd FileType bzr setlocal tw=72
    autocmd FileType gitcommit setlocal fo+=t fo-=q tw=72
    autocmd FileType markdown setlocal autoindent
    autocmd FileType go setlocal noexpandtab ts=4 sw=4 sts=4
    autocmd FileType haskell setlocal nospell

    " Jump to last cursor position unless it's invalid or in an event handler
    autocmd BufReadPost *
      \ if &filetype != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal g`\"" |
      \ endif

    " Highlight current line in windows without the cursor
    autocmd WinEnter * setlocal nocursorline
    autocmd WinLeave * setlocal cursorline

    " Override unknown filetypes in certain zsh directories
    autocmd BufNewFile,BufRead */.zfunctions/* if &ft == '' || &ft =~# '^\(conf\)$' | set filetype=zsh | endif
    autocmd BufNewFile,BufRead */.zlocal/* if &ft == '' || &ft =~# '^\(conf\)$' | set filetype=zsh | endif

    " Close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

    autocmd BufNewFile,BufRead Guardfile set filetype=ruby
  augroup END
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return UltiSnips_ExpandSnippetOrJump()
    else
        return "\<c-p>"
    endif
endfunction

"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <s-tab> <c-n>
