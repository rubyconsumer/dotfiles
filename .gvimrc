" gvim/MacVim-only settings (replaces .gvimrc.local / .gvimrc.after).

silent! colorscheme vibrantink

set gfn=Monaco:h12

" Command-/ to toggle comments (MacVim)
nmap <D-/> <Plug>CommentaryLine
vmap <D-/> <Plug>Commentary
