"-----GENERAL-----
"The default leader is a backslash, but we use ','
let mapleader = ','

"Fix backspace key"
set backspace=indent,eol,start

"Source  Plugins
so ~/.vim/plugins.vim

"Set language for spell check
setlocal spell spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=bold

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
colorscheme atom-dark-256
set t_Co=256

"Show line numbers
set number
hi LineNr ctermfg=grey ctermbg=black

"Highlight current line
set cursorline

"Show column length
set ruler

"Show visual mark at the 80th character
set colorcolumn=80
hi OverLength ctermbg=red ctermfg=white
match OverLength /\%81v.\+/

"Searching
set hlsearch
set incsearch



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
nmap <Leader>t :tabnew<space>
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



"-----END-----
"Auto sourcing the .vimrc file on safe
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END
