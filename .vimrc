" Self-contained vimrc (replaces the old Janus distribution setup).

" Auto-bootstrap vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'            " gcc / gc to toggle comments (replaces NERDCommenter)
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'posva/vim-vue'
Plug 'jlanzarotta/bufexplorer'         " \be to browse buffers
Plug 'rizzatti/dash.vim'               " macOS Dash doc lookup
Plug 'vim-scripts/vibrantink'          " gvim colorscheme
call plug#end()

" Core settings (what Janus used to provide)
syntax on
filetype plugin indent on
set hidden
set backspace=indent,eol,start
set number relativenumber              " replaces numbers.vim
set incsearch hlsearch
set ignorecase smartcase
set expandtab shiftwidth=2 softtabstop=2
set autoindent
set laststatus=2
set wildmenu
set ttimeoutlen=50
set scrolloff=3

" Unify Mac cut-and-paste with vim
if has("macunix")
  set clipboard=unnamed
endif

" git blame selected lines
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" F3 - F4 to toggle line numbering (native; replaces numbers.vim)
nnoremap <F3> :set relativenumber!<CR>
nnoremap <F4> :set number! relativenumber!<CR>

" F5 to remove trailing spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

" TODO/FIXME/XXX list in the quickfix window (replaces TaskList.vim)
map <leader>l :vimgrep /\C\<\(TODO\|FIXME\|XXX\)\>/j %<CR>:copen<CR>

" Dash doc lookup
nmap <silent> <leader>d <Plug>DashSearch

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Format Column
vmap <leader>fc :!column -t<cr>gv:s/\v ([^ ])/\1<cr>gv=
