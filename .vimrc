call pathogen#infect()
" NOTE: You must run pathogen's Helptags command after loading new plugins
" in order to generate vim help files for those plugins.

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

"" Code styles
augroup style
au! BufRead,BufNewFile {*.md,*markdown,*.htm,*.html,*.js,*.coffee}
    \ set et ts=2 sw=2
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

" see https://github.com/pbrisbin/vim-config/blob/master/vimrc
" switch leader key to comma
let mapleader = ','
let maplocalleader = ','

" haskellmode-vim needs these set as early as possible
let g:haddock_browser = $BROWSER
let g:haddock_indexfiledir = $HOME . '/.vim/'

" commenter
let NERDCreateDefaultMappings = 0
let NERDCommentWholeLinesInVMode = 1

let g:NERDCustomDelimiters = {
    \ 'haskell': { 'left': '--' , 'right': '' },
    \ 'hamlet' : { 'left': '\<!-- ', 'right': ' -->' },
    \ 'cassius': { 'left': '/* ' , 'right': ' */' },
    \ 'lucius' : { 'left': '/* ' , 'right': ' */' },
    \ 'julius' : { 'left': '//' , 'right': '' }
\ }

" gist-vim
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let g:gist_clip_command = 'pbcopy'
  else
    let g:gist_clip_command = 'xclip'
  endif
endif
