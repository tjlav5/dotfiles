set nocompatible

filetype plugin on

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"===================="
" Some basic options "
"===================="

let mapleader="\<Space>"
let maplocalleader="\\"

" Enable syntax highlighting
syntax on

" Uncomment if you want to map ; to : to cut down on chording
nnoremap ; :

" Show line numbers
" set number
set relativenumber

" Set tab spacing for Golang
au Filetype go setlocal ts=4
au Filetype scss setlocal sw=2 ts=2
au Filetype html setlocal sw=2 ts=2 expandtab

" use » to mark Tabs and ° to mark trailing whitespace. This is a
" non-obtrusive way to mark these special characters.
set list listchars=tab:»\ ,trail:°

" Highlight the search term when you search for it.
set hlsearch

" By default, it looks up man pages for the word under the cursor, which isn't
" very useful, so we map it to something else.
nnoremap <s-k> <CR>

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

" TypeScript plugin setup
" let g:tsuquyomi_use_dev_node_module = 2

" Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

colorscheme zenburn

" Function to source only if file exists {
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" }

call SourceIfExists("~/vimrc.local")
