set nocompatible

filetype plugin on

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

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

set clipboard^=unnamed,unnamedplus

" Set tab spacing
au Filetype go setlocal ts=4
au Filetype scss setlocal sw=2 ts=2 expandtab
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

" netrw config
let g:netrw_liststyle = 3
let g:netrw_banner = 0 " hide the banner
" let g:netrw_browse_split = 1 " open files in a new horizontal split
" let g:netrw_winsize = 25
nmap <C-P> :Sex<CR>

"==================================="
" Load and Configure Other Plugins "
"==================================="

" Deoplete
let g:deoplete#enable_at_startup = 1

"" NERDTree config
"" Ctrl-P to display the file browser tree
"nmap <C-P> :NERDTreeToggle<CR>
"" ,p to show current file in the tree
"nmap <leader>p :NERDTreeFind<CR>

" FZF
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <leader>, :FZF<cr>
nnoremap <leader>. :Buffers<cr>
nnoremap <leader>l :Lines<cr>
nnoremap <leader>B :BTags<cr>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" nerdcommenter
" ,/ to invert comment on the current line/selection
nmap <leader>/ :call NERDComment(0, "invert")<cr>
vmap <leader>/ :call NERDComment(0, "invert")<cr>

"" Snippets
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"set runtimepath+=~/.local/share/nvim/plugged/ultisnips
"
"autocmd FileType typescript UltiSnipsAddFiletypes javascript-jasmine-arrow

" emmet-vim
let g:user_emmet_leader_key='<C-E>'

" colorscheme zenburn
" colorscheme dracula
let g:gruvbox_italic=1
colorscheme onedark

" Function to source only if file exists {
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" }

" airline
" let g:airline_powerline_fonts = 0
" let g:airline_symbols_ascii = 1
" let g:airline_powerline_fonts = 1

" lightline
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

call SourceIfExists("~/vimrc.local")
