"-----GENERAL-----
"The default leader is a backslash, but we use ','
let mapleader = ','

"Fix backspace key"
set backspace=indent,eol,start

"Source  Plugins
so ~/.vim/plugins.vim

"Set language for spell check
setlocal spell spelllang=en_us
set spell

"Fixing tabs and indentation
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=8
set tabstop=8

"Refresh buffer automatically
set autoread

"Use system clipboard
set clipboard=unnamedplus

"Fix mouse in tmux
set mouse=a

"Supress warning when changing FROM unsaved buffer
set hidden

"Demand explicit confirmation when closing unsaved buffers
set confirm


"-----VISUAL-----

"Syntax highlighting
syntax enable

"From https://github.com/gosukiwi/vim-atom-dark
set t_ut=
colorscheme atom-dark-256
set t_Co=256

"Always display tabline
set showtabline=2

"Highlight current line
set cursorline

"Show column length
set ruler

"Searching
set hlsearch
set incsearch

"Show line numbers
set number

"Show visual mark at the 80th character
set colorcolumn=81
hi OverLength ctermbg=red ctermfg=white
match OverLength /\%81v.\+/



"-----MAPPINGS-----

"Quick edit ~/.vimrc
nmap <Leader>ev :tabedit $MYVIMRC<CR>
"Quick edit ~/.vim/plugins.vim
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<CR>

"Search current selected text
vnoremap // y/\c<C-R>"<CR>

"Removes the highlighted search results
nmap <Leader><space> :nohlsearch<CR>

"Tab navigation
nmap <Leader>tab :tabnew<space>
nmap <Leader>w :tabclose<CR>

"Split Management
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"ctags
nmap <Leader>f :ts<space>


"-----AUTO-COMMANDS-----




"-----PLUGIN CONFIGURATION-----
"NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\~$','\.swp','^\.tags$', '^tags$','.git[[dir]]']
nmap <Leader>d :NERDTreeToggle<CR>
"NERDTree on startup
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"CtrlP
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
nmap <Leader>p :CtrlPBufTag<CR>

"Vim-Gutter
set updatetime=250

"php.vim
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

"NERDCommenter
let g:NERDSpaceDelims = 1

"vim-php-namespace
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

"vim-fugitive
noremap <Leader>gstatus :Gstatus<CR>
noremap <Leader>gcommit :Gcommit -ev<space>
noremap <Leader>glog :Glog<CR>
noremap <Leader>gblame :Gblame<CR>
noremap <Leader>gmv :Gmove<CR>
noremap <Leader>grm :Gremove<CR>

"vim-easytags
set tags=./.tags
set cpoptions=aABceFsd
let g:easytags_file = './.tags'
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_auto_highlight = 0

"lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '⭠ '.branch : ''
  endif
  return ''
endfunction



"-----END-----
"Auto sourcing the .vimrc file on safe
augroup autosourcing
	autocmd!
	autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END
