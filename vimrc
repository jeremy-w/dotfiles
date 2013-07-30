call pathogen#infect()
" NOTE: You must run pathogen's Helptags command after loading new plugins
" in order to generate vim help files for those plugins.

set nocompatible
scriptencoding utf8
set encoding=utf-8
set backspace=2  "allow backspacing over everything
set scrolloff=3
set undofile
set ttyfast

set wildmenu
set wildmode=list:longest

set formatoptions=qrn1

set modelines=8
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set showmatch

" Show nonprinting characters.
" set nolist to disable.
set listchars=eol:⤶,tab:⇶·,trail:⊔,extends:⋯,precedes:⋯
set list

" Show partial text of a line that flows out of the window,
" rather than one @ sign per window-line.
set display=lastline

set diffopt=filler,horizontal

set ignorecase
set smartcase
set incsearch
set hlsearch
set showmatch
" Easily clear search highlighting when finished.
nnoremap <leader><space> :nohlsearch<cr>

" ./tags uses a tags file in the file's directory.
" tags alone uses a file in vim's cwd.
"
" Suffixed ; searches up till stop dir (not used here) or /.
" See |file-searching| for details.
set tags=./tags,tags,./tags;,tags;

syntax enable
set background=dark
"colorscheme solarized
"let g:solarized_termtrans=0

" Highlight characters in lines exceeding 80 chars
if exists("+colorcolumn")
  set colorcolumn=80,81,82,83,84,85
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Disable w:m2 highlighting.
function RedOff()
  if exists("+colorcolumn")
    set colorcolumn=
  else
    matchdelete(w:m2)
  endif
endfunction

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

" Git commit messages should wrap the body at 72 chars.
" See http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html.
au FileType * if &filetype == "gitcommit" | set tw=72 | endif

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

"" leader shortcuts
" select just-pasted region
nnoremap <leader>v V`]

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
