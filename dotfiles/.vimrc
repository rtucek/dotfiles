"-----GENERAL-----
"The default leader is a backslash, but we use ','
let mapleader = ','

"Fix backspace key"
set backspace=indent,eol,start

"Set language for spell check
setlocal spell spelllang=en_us
set spell

"Fixing tabs and indentation
set autoindent
set copyindent
set noexpandtab
set preserveindent
set softtabstop=0

"Refresh buffer automatically
set autoread

"Use system clipboard
set clipboard=unnamedplus

"Add mouse support
set mouse=a

"Suppress warning when changing FROM unsaved buffer
set hidden

"Demand explicit confirmation when closing unsaved buffers
set confirm


"-----MAPPINGS-----

"Quick edit ~/.vimrc
nmap <Leader>ev :tabedit $MYVIMRC<CR>

"Search current selected text
vnoremap // y/\c<C-R>"<CR>

"Removes the highlighted search results
nmap <Leader><space> :nohlsearch<CR>

"Tab navigation
nnoremap <Leader>tab :tabnew<space>
nnoremap <Leader>w :tabclose<CR>
nnoremap <Leader>tabthis :tabnew %<CR>:tabprevious<CR>

"Split Management
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"ctags
nmap <Leader>f :ts<space>

"Fix whitespace errors
nnoremap <Leader>fwe :%s/^ //g<CR>:nohlsearch<CR>

"Unexpand 4 spaces to tab
nnoremap <Leader>uex :%s/    /\t/g<CR>:nohlsearch<CR>

"Move lines up and down in visual mode
vnoremap <C-J> :m '>+1<CR>gv
vnoremap <C-K> :m '<-2<CR>gv



"-----AUTO-COMMANDS-----




"-----PLUGIN CONFIGURATION-----
"editorconfig
"Show visual mark, depending on max_line_length value
let g:EditorConfig_max_line_indicator = "fill"

"NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\~$', '\.swp', '^\.tags$', '^tags$', 'Session.vim', '.git[[dir]]']
nmap <Leader>d :NERDTreeToggle<CR>

"CtrlP
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
nmap <Leader>p :CtrlPBufTag<CR>

"Vim-Gutter
set updatetime=250

"php.vim
function! PhpSyntaxOverride()
	hi! def link phpDocTags	phpDefine
	hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
autocmd!
autocmd FileType php call PhpSyntaxOverride()
augroup END

"vim-php-namespace
"Insert use statement
function! IPhpInsertUse()
	call PhpInsertUse()
	call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

"Expand Namespace
function! IPhpExpandClass()
	call PhpExpandClass()
	call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>

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

"tagbar
nnoremap <Leader>tb :TagbarToggle<CR>

"lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ }

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"easytags
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_auto_highlight = 0
let g:easytags_cmd = '/usr/bin/ctags'



"-----VUNDLE-----
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"PLUGINS
Plugin 'airblade/vim-gitgutter'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'djoshea/vim-autoread'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ekalinin/dockerfile.vim'
Plugin 'ervandew/supertab'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'gregsexton/matchtag'
Plugin 'itchyny/lightline.vim'
Plugin 'lumiliet/vim-twig'
Plugin 'majutsushi/tagbar'
Plugin 'qpkorr/vim-bufkill'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'StanAngeloff/php.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-syntastic/syntastic'
Plugin 'VundleVim/Vundle.vim'

"COLORSCHEMES
Plugin 'davb5/wombat256dave'
Plugin 'gosukiwi/vim-atom-dark'
Plugin 'tomasr/molokai'

call vundle#end()            " required
filetype plugin indent on    " required



"-----POST PLUGIN CONFIGURATION-----
set tags=./.tags;
set cpoptions+=d



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



"-----END-----
"Auto sourcing the .vimrc file on safe
augroup autosourcing
	autocmd!
	autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END
