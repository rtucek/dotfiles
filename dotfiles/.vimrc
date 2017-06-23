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
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'lumiliet/vim-twig'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'qpkorr/vim-bufkill'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'skwp/greplace.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-syntastic/syntastic'
Plugin 'VundleVim/Vundle.vim'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

"COLORSCHEMES
Plugin 'crusoexia/vim-monokai'
Plugin 'gosukiwi/vim-atom-dark'

call vundle#end()
filetype plugin indent on

"vim-sensible
"Apply configs from vim-sensible
runtime! plugin/sensible.vim



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

"Toggle Spell check
nnoremap <Leader>s :set spell!<CR>

"Search current selected text
vnoremap // y/\c<C-R>"<CR>

"Ack search
nnoremap <Leader>a :Ack!<Space>

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
nmap <Leader>f :tagselect<space>

"Fix whitespace errors
nnoremap <Leader>fwe :%s/^ //g<CR>:nohlsearch<CR>

"Unexpand 4 spaces to tab
nnoremap <Leader>uex :%s/    /\t/g<CR>:nohlsearch<CR>

"Move lines up and down in visual mode
vnoremap <C-J> :m '>+1<CR>gv
vnoremap <C-K> :m '<-2<CR>gv

"(Un-)Indent lines and preserve selection
vnoremap < <<CR>gv
vnoremap > ><CR>gv

"Toggle relative line numbers
nnoremap <Leader>r :set relativenumber!<CR>



"-----AUTO-COMMANDS-----



"-----PLUGIN CONFIGURATION-----
"editorconfig
"Show visual mark, depending on max_line_length value
let g:EditorConfig_max_line_indicator = "line"

"NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\~$', '\.swp', '^\.tags$', '^tags$', 'Session.vim', '.git[[dir]]']
nnoremap <Leader>D :NERDTreeFind<CR>

"NERDTreeMirror
nnoremap <Leader>d :NERDTreeTabsToggle<CR>

"CtrlP
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_working_path_mode = ''
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
let g:php_namespace_sort_after_insert = 1

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

"ack.vim
cnoreabbrev Ack Ack!

"Grepreplace.vim
set grepprg=ack
let g:grep_cmd_opts = '--noheading'


"-----VISUAL-----

"Syntax highlighting
syntax enable

set t_ut=
set t_Co=256
colorscheme monokai

"Always display tabline
set showtabline=2

"Highlight current line
set cursorline

"Show column length
set ruler

"Searching
set hlsearch
set incsearch
set ignorecase

"Show line numbers
set number



"-----DIFF COLORSCHEME-----
" When viewing a diff or patch file
highlight diffAdded     term=bold ctermbg=none ctermfg=green  cterm=bold guibg=DarkGreen   guifg=white gui=none
highlight diffChanged   term=bold ctermbg=none ctermfg=yellow cterm=bold guibg=DarkYellow  guifg=white gui=none
highlight diffFile      term=bold ctermbg=none ctermfg=blue   cterm=bold guibg=DarkYellow  guifg=white gui=none
highlight diffIndexLine term=bold ctermbg=none ctermfg=cyan   cterm=bold guibg=DarkRed     guifg=white gui=none
highlight diffLine      term=bold ctermbg=none ctermfg=yellow cterm=bold guibg=DarkMagenta guifg=white gui=none
highlight diffRemoved   term=bold ctermbg=none ctermfg=red    cterm=bold guibg=DarkRed     guifg=white gui=none
highlight diffSubname   term=bold ctermbg=none ctermfg=yellow cterm=none guibg=DarkYellow  guifg=white gui=none



"-----END-----
"Auto sourcing the .vimrc file on safe
augroup autosourcing
	autocmd!
	autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END
