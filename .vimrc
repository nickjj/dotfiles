" -----------------------------------------------------------------------------
" This config is targeted for Vim 8.0+ and expects you to have Plug installed.
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------

" Specify a directory for plugins.
call plug#begin('~/.vim/plugged')

" Gruvbox theme.
Plug 'gruvbox-community/gruvbox'

" Integrate fzf with Vim.
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" Zoom in and out of a specific split pane (similar to tmux).
Plug 'dhruvasagar/vim-zoom'

" Pass focus events from tmux to Vim (useful for autoread and linting tools).
Plug 'tmux-plugins/vim-tmux-focus-events'

" Navigate and manipulate files in a tree view.
Plug 'scrooloose/nerdtree'

" Launch Ranger from Vim.
Plug 'francoiscabrol/ranger.vim'

" Run a diff on 2 directories.
Plug 'will133/vim-dirdiff'

" Run a diff on 2 blocks of text.
Plug 'AndrewRadev/linediff.vim'

" Add spelling errors to the quickfix list (vim-ingo-library is a dependency).
Plug 'inkarkat/vim-ingo-library' | Plug 'inkarkat/vim-SpellCheck'

" Modify * to also work with visual selections.
Plug 'nelstrom/vim-visual-star-search'

" Automatically clear search highlights after you move your cursor.
Plug 'haya14busa/is.vim'

" Handle multi-file find and replace.
Plug 'mhinz/vim-grepper'

" Better display unwanted whitespace.
Plug 'ntpeters/vim-better-whitespace'

" Toggle comments in various ways.
Plug 'tpope/vim-commentary'

" Surround text with quotes, parenthesis, brackets, and more.
Plug 'tpope/vim-surround'

" Automatically set 'shiftwidth' + 'expandtab' (indention) based on file type.
Plug 'tpope/vim-sleuth'

" A number of useful motions for the quickfix list, pasting and more.
Plug 'tpope/vim-unimpaired'

" Drastically improve insert mode performance in files with folds.
Plug 'Konfekt/FastFold'

" Show git file changes in the gutter.
Plug 'mhinz/vim-signify'

" A git wrapper.
Plug 'tpope/vim-fugitive'

" Dim paragraphs above and below the active paragraph.
Plug 'junegunn/limelight.vim'

" Distraction free writing by removing UI elements and centering everything.
Plug 'junegunn/goyo.vim'

" A bunch of useful language related snippets (ultisnips is the engine).
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Run test suites for various languages.
Plug 'janko/vim-test'

" Languages and file types.
Plug 'cakebaker/scss-syntax.vim'
Plug 'chr4/nginx.vim'
Plug 'chrisbra/csv.vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'elzr/vim-json'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'lifepillar/pgsql.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'stephpy/vim-yaml'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-git'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-rails'
Plug 'vim-python/python-syntax'
Plug 'vim-ruby/vim-ruby'
Plug 'wgwoods/vim-systemd-syntax'

call plug#end()

" -----------------------------------------------------------------------------
" Color settings
" -----------------------------------------------------------------------------

colorscheme gruvbox
" For Gruvbox to look correct in terminal Vim you'll want to source a palette
" script that comes with the Gruvbox plugin.
"
" Add this to your ~/.profile file:
"   source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

" Gruvbox comes with both a dark and light theme.
set background=dark

" Gruvbox has 'hard', 'medium' (default) and 'soft' contrast options.
let g:gruvbox_contrast_light='hard'

" This needs to come last, otherwise the colors aren't correct.
syntax on

" -----------------------------------------------------------------------------
" Status line
" -----------------------------------------------------------------------------

" Heavily inspired by: https://github.com/junegunn/dotfiles/blob/master/vimrc
function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction

let &statusline = s:statusline_expr()

" -----------------------------------------------------------------------------
" Change status line color for insert and replace modes
" -----------------------------------------------------------------------------

" Optimized for gruvbox:hard (both dark and light).
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    if (&background == 'dark')
      hi StatusLine ctermfg=109 ctermbg=0 guifg=#83a598 guibg=#000000
    else
      hi StatusLine ctermfg=24 ctermbg=255 guifg=#076678 guibg=#ffffff
    endif
  elseif a:mode == 'r'
    if (&background == 'dark')
      hi StatusLine ctermfg=106 ctermbg=0 guifg=#98971a guibg=#000000
    else
      hi StatusLine ctermfg=100 ctermbg=255 guifg=#79740e guibg=#ffffff
    endif
  else
    if (&background == 'dark')
      hi StatusLine ctermfg=166 ctermbg=0 guifg=#d65d0e guibg=#000000
    else
      hi StatusLine ctermfg=88 ctermbg=255 guifg=#9d0006 guibg=#ffffff
    endif
  endif
endfunction

function! InsertLeaveActions()
  if (&background == 'dark')
    au InsertLeave * hi StatusLine ctermfg=239 ctermbg=223 guifg=#504945 guibg=#ebdbb2
  else
    au InsertLeave * hi StatusLine ctermfg=250 ctermbg=0 guifg=#d5c4a1 guibg=#000000
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InsertLeaveActions()

" Ensure status line color gets reverted if exiting insert mode with CTRL + C.
inoremap <C-c> <C-o>:call InsertLeaveActions()<CR><C-c>

" -----------------------------------------------------------------------------
" Basic Settings
"   Research any of these by running :help <setting>
" -----------------------------------------------------------------------------

let mapleader=" "
let maplocalleader=" "

set autoindent
set autoread
set backspace=indent,eol,start
set backupdir=/tmp//,.
set clipboard=unnamedplus
set colorcolumn=80
set complete-=i
set completeopt=menuone,preview
set cryptmethod=blowfish2
set directory=/tmp//,.
set encoding=utf-8
set expandtab smarttab
set formatoptions=tcqrn1
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set matchpairs+=<:> " Use % to jump between pairs
set modelines=2
set mouse=a
set nocompatible
set noerrorbells visualbell t_vb=
set noshiftround
set nospell
set nostartofline
set number relativenumber
set regexpengine=1
set ruler
set scrolloff=3
set shiftwidth=2
set showcmd
set showmatch
set showmode
set smartcase
set softtabstop=2
set spelllang=en_us
set splitbelow
set splitright
set tabstop=2
set textwidth=0
set ttimeout
set ttyfast
set ttymouse=sgr
set undodir=/tmp//,.
set virtualedit=block
set whichwrap=b,s,<,>
set wildmenu
set wildmode=full
set wrap

runtime! macros/matchit.vim

" -----------------------------------------------------------------------------
" Basic mappings
" -----------------------------------------------------------------------------

" Seamlessly treat visual lines as actual lines when moving around.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Navigate around splits with a single key combo.
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Cycle through splits.
nnoremap <S-Tab> <C-w>w

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Clear search highlights.
map <Leader><Space> :let @/=''<CR>

" Format paragraph (selected or not) to 80 character lines.
nnoremap <Leader>g gqap
xnoremap <Leader>g gqa

" Prevent x from overriding what's in the clipboard.
noremap x "_x
noremap X "_x

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" Edit Vim config file in a new tab.
map <Leader>ev :tabnew $MYVIMRC<CR>

" Source Vim config file.
map <Leader>sv :source $MYVIMRC<CR>

" Eliminate issues where you accidentally hold shift for too long with :w.
command! W write

" Toggle spell check.
map <F5> :setlocal spell!<CR>

" Toggle quickfix window.
function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction
nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>

" Convert the selected text's title case using the external tcc script.
"   Requires: https://github.com/nickjj/title-case-converter
vnoremap <Leader>tc c<C-r>=system('tcc', getreg('"'))[:-2]<CR>

" -----------------------------------------------------------------------------
" Basic autocommands
" -----------------------------------------------------------------------------

" Reduce delay when switching between modes.
augroup NoInsertKeycodes
  autocmd!
  autocmd InsertEnter * set ttimeoutlen=0
  autocmd InsertLeave * set ttimeoutlen=50
augroup END

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Update a buffer's contents on focus if it changed outside of Vim.
au FocusGained,BufEnter * :checktime

" Unset paste on InsertLeave.
autocmd InsertLeave * silent! set nopaste

" Make sure all types of requirements.txt files get syntax highlighting.
autocmd BufNewFile,BufRead requirements*.txt set syntax=python

" Ensure tabs don't get converted to spaces in Makefiles.
autocmd FileType make setlocal noexpandtab

" ----------------------------------------------------------------------------
" Basic commands
" ----------------------------------------------------------------------------

" Add all TODO items to the quickfix list relative to where you opened Vim.
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niIw -e TODO -e FIXME 2> /dev/null',
            \ 'grep -rniIw -e TODO -e FIXME . 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction

command! Todo call s:todo()

" Profile Vim by running this command once to start it and again to stop it.
function! s:profile(bang)
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction

command! -bang Profile call s:profile(<bang>0)

" -----------------------------------------------------------------------------
" Plugin settings, mappings and autocommands
" -----------------------------------------------------------------------------

" .............................................................................
" junegunn/fzf.vim
" .............................................................................

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>

" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>

" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)

" .............................................................................
" scrooloose/nerdtree
" .............................................................................

let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1

" Open nerd tree at the current file or close nerd tree if pressed again.
nnoremap <silent> <expr> <Leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" .............................................................................
" mhinz/vim-grepper
" .............................................................................

let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <Leader>R
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <Leader>R
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" .............................................................................
" ntpeters/vim-better-whitespace
" .............................................................................

let g:strip_whitespace_confirm=0
let g:strip_whitespace_on_save=1

" .............................................................................
" Konfekt/FastFold
" .............................................................................

let g:fastfold_savehook=0
let g:fastfold_fold_command_suffixes=[]

" .............................................................................
" junegunn/limelight.vim
" .............................................................................

let g:limelight_conceal_ctermfg=244

" .............................................................................
" plasticboy/vim-markdown
" .............................................................................

autocmd FileType markdown let b:sleuth_automatic=0
autocmd FileType markdown set conceallevel=0
autocmd FileType markdown normal zR

let g:vim_markdown_frontmatter=1

" .............................................................................
" iamcco/markdown-preview.nvim
" .............................................................................

let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='/home/nick/.local/lib/github-markdown-css/github-markdown.css'
