set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"========================"
" Vim-plug configuration "
"========================"

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-sensible'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Valloric/MatchTagAlways'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'            " enables TypeScript auto-completion.
Plug 'leafgarland/typescript-vim'
Plug 'jnurmine/Zenburn'
call plug#end()

" if isdirectory(expand('$HOME/.vim/bundle/Vundle.vim'))
"   call vundle#begin()
"   " Required
"   Plugin 'gmarik/vundle'
"   " Install plugins that come from github.  Once Vundle is installed, these can be
"   " installed with :PluginInstall
"   Plugin 'bling/vim-airline'
"   " Plugin 'ctrlpvim/ctrlp.vim'
"   Plugin 'junegunn/fzf'
"   Plugin 'scrooloose/nerdcommenter'
"   Plugin 'scrooloose/nerdtree'
"   Plugin 'SirVer/ultisnips'
"   Plugin 'tpope/vim-sensible'
"   Plugin 'tpope/vim-fugitive'
"   Plugin 'christoomey/vim-tmux-navigator'
"   Plugin 'Valloric/MatchTagAlways'
"   Plugin 'vim-scripts/netrw.vim'
"   Plugin 'Shougo/vimproc.vim'          " Force install a dependency of tsuquyomi.
"   Plugin 'leafgarland/typescript-vim'  " enables TypeScript syntax-highlighting.
"   Plugin 'Quramy/tsuquyomi'            " enables TypeScript auto-completion.
"   Plugin 'fatih/vim-go'
"   " Plugin 'joshdick/onedark.vim'
"   Plugin 'jnurmine/Zenburn'
"   " Provide many default snippets for a variety of snippets.
"   " Uncomment and :PluginInstall to enable
"   " Plugin 'honza/vim-snippets'
" 
"   call vundle#end()
" else
"   echomsg 'Vundle is not installed. You can install Vundle from'
"       \ 'https://github.com/VundleVim/Vundle.vim'
" endif

filetype plugin indent on

"===================="
" Some basic options "
"===================="

" Enable syntax highlighting
syntax on

" Uncomment if you want to map ; to : to cut down on chording
" nnoremap ; :

" Automatically change the working path to the path of the current file
autocmd BufNewFile,BufEnter * silent! lcd %:p:h

" Show line numbers
set number

" Set tab spacing for Golang
au Filetype go setlocal ts=4
au Filetype scss setlocal sw=2

" use » to mark Tabs and ° to mark trailing whitespace. This is a
" non-obtrusive way to mark these special characters.
set list listchars=tab:»\ ,trail:°

" Highlight the search term when you search for it.
set hlsearch
set hlsearch
" By default, it looks up man pages for the word under the cursor, which isn't
" very useful, so we map it to something else.
nnoremap <s-k> <CR>

" Explicitly set the Leader to comma. You you can use '\' (the default),
" or anything else (some people like ';').
let mapleader=','

" Easy split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle paste mode
nnoremap <leader>P :se invpaste paste?<return>

"==================================="
" Load and Configure Other Plugins "
"==================================="

" NERDTree config
" Ctrl-P to display the file browser tree
nmap <C-P> :NERDTreeToggle<CR>
" ,p to show current file in the tree
nmap <leader>p :NERDTreeFind<CR>

" FZF
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <leader>, :FZF<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>l :Lines<cr>

" nerdcommenter
" ,/ to invert comment on the current line/selection
nmap <leader>/ :call NERDComment(0, "invert")<cr>
vmap <leader>/ :call NERDComment(0, "invert")<cr>

" Fugitive
autocmd QuickFixCmdPost *grep* cwindow

" TypeScript plugin setup
let g:tsuquyomi_use_dev_node_module = 2

colorscheme zenburn
