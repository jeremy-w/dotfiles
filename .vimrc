set nocompatible
scriptencoding utf8
set encoding=utf-8
set backspace=2  "allow backspacing over everything

set modelines=8
set shiftwidth=4
set tabstop=4
"set expandtab
set autoindent
set showmatch

" Show nonprinting characters.
" set nolist to disable.
set listchars=eol:⤶,tab:⇶·,trail:⊔,extends:⋯,precedes:⋯
set list

set ignorecase
set smartcase
set incsearch
set hlsearch

syntax enable
set background=dark
"colorscheme solarized
"let g:solarized_termtrans=0

" Highlight characters in lines exceeding 80 chars
if has("colorcolumn")
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"" Filetypes
" LLVM assembly files
augroup filetype
au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" LLVM tablegen files
augroup filetype
au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END

" .md should be Markdown, not Modula-2
augroup filetype
au! BufRead,BufNewFile *.md     set filetype=markdown
augroup END

" Disable arrow keys for navigation.
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Enable commandline navigation without hardware Home/End keys
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <M-B> <S-Left>
cnoremap <Esc>b <S-Left>
cnoremap <M-F> <S-Right>
cnoremap <Esc>f <S-Right>
