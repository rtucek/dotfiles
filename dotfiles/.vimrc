"-----VUNDLE-----
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"PLUGINS
if !has('nvim')
	Plugin 'tpope/vim-sensible'
endif

Plugin 'airblade/vim-gitgutter'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'djoshea/vim-autoread'
Plugin 'easymotion/vim-easymotion'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ekalinin/dockerfile.vim'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'garbas/vim-snipmate'
Plugin 'gregsexton/matchtag'
Plugin 'itchyny/lightline.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'joonty/vdebug'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'lumiliet/vim-twig'
Plugin 'magicalbanana/vim-sql-syntax'
Plugin 'majutsushi/tagbar'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'mileszs/ack.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'qpkorr/vim-bufkill'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'skwp/greplace.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-php/tagbar-phpctags.vim'
Plugin 'vim-scripts/tinykeymap'
Plugin 'vim-syntastic/syntastic'
Plugin 'VundleVim/Vundle.vim'

"COLORSCHEMES
Plugin 'crusoexia/vim-monokai'
Plugin 'gosukiwi/vim-atom-dark'
Plugin 'romainl/Apprentice'

call vundle#end()
filetype plugin indent on

"vim-sensible
"Apply configs from vim-sensible
if !has('nvim')
	runtime! plugin/sensible.vim
endif



"-----GENERAL-----
"The default leader is a backslash, but we use ','
let mapleader = ','

"Fix backspace key"
set backspace=indent,eol,start

"Set language for spell check
setlocal spell spelllang=en_us
set nospell

"Fixing tabs and indentation
set autoindent
set copyindent
set noexpandtab
set preserveindent
set softtabstop=0

"Make scrolling faster and more accurate
set ttyfast

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

"Deactivate folding
set nofoldenable

"Don't use swapfiles
set noswapfile

"Don't change default curosr
"Kudos @binaryreverse https://github.com/neovim/neovim/issues/6005
set guicursor=



"-----MAPPINGS-----
"Quick edit ~/.vimrc
nmap <Leader>ev :tabedit $MYVIMRC<CR>

"Toggle Spell check
nnoremap <Leader>s :set spell!<CR>:set spell?<CR>

"Highlight word under cursor
nnoremap * *N

"Highlight selection
vnoremap // y/\c<C-R>"<CR>N

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

"Don't yank selected text after overwriting via paste
vnoremap p "_dP

"Toggle relative line numbers
nnoremap <Leader>r :set relativenumber!<CR>



"-----AUTO-COMMANDS-----
augroup generalAutocmd
	autocmd!
	autocmd BufEnter * :syntax sync fromstart
augroup END



"-----FUNCTIONS-----
function! s:DiffWithSaved()
	let filetype=&ft
	diffthis
	vnew | r # | normal! 1Gdd
	diffthis
	exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()



"-----PLUGIN CONFIGURATION-----
"editorconfig
"Show visual mark, depending on max_line_length value
let g:EditorConfig_max_line_indicator = "line"
let g:EditorConfig_preserve_formatoptions = 1

"NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\~$', '\.swp', '^\.tags$', '^tags$', 'Session.vim', '.git[[dir]]']
nnoremap <Leader>d :NERDTreeToggle<CR>
nnoremap <Leader>D :NERDTreeFind<CR>

"CtrlP
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_max_depth = 100
let g:ctrlp_max_files = 30000
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = ''
let g:ctrlp_lazy_update = 1
nnoremap <Leader>p :CtrlPBuffer<CR>
nnoremap <Leader>pt :CtrlPBufTag<CR>
nnoremap <Leader>pT :CtrlPBufTagAll<CR>
let g:ctrlp_buftag_types = {
	\ 'php'     : '--language-force=php --php-kinds=+cfid-v'
\ }

"Vim-Gutter
set updatetime=250

"php.vim
function! PhpSyntaxOverride()
	hi! def link phpDocTags	phpDefine
	hi! def link phpDocParam phpType
endfunction
augroup phpVimAutocmd
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

"Expand Namespace
function! IPhpExpandClass()
	call PhpExpandClass()
	call feedkeys('a', 'n')
endfunction
augroup phpInsertUseAutocmd
	autocmd!
	autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
	autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
	autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
	autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
augroup END

"NERDCommenter
let g:NERDSpaceDelims = 1

"vim-fugitive
noremap <Leader>gstatus :Gstatus<CR>
noremap <Leader>gcommit :Gcommit -ev<space>
noremap <Leader>glog :Glog<CR>
noremap <Leader>gblame :Gblame<CR>
noremap <Leader>gmv :Gmove<CR>
noremap <Leader>grm :Gremove<CR>

"tagbar
nnoremap <Leader>tb :TagbarToggle<CR>
let g:tagbar_phpctags_bin='/usr/local/bin/phpctags'
let g:tagbar_autoclose = 1

"lightline
set laststatus=2
let g:lightline = {
	\ 'colorscheme': 'landscape',
	\ 'active': {
		\ 'left': [
			\ ['mode', 'paste'],
			\ ['gitbranch', 'readonly', 'filename'],
			\ ['tagbar', 'gutentags'],
		\ ]
	\ },
	\ 'component_function': {
		\ 'gitbranch': 'fugitive#head',
		\ 'filename': 'LightlineFilename',
	\ },
	\ 'component': {
		\ 'lineinfo': '%l\%L [%p%%], %c, %n',
		\ 'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
		\ 'gutentags': '%{gutentags#statusline("[Generating...]")}',
	\ },
\ }
function! LightlineFilename()
	let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
	let modified = &modified ? ' +' : ''
	return filename . modified
endfunction

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"gutentags
function! GetPwd(path)
	return getcwd()
endfunction
let g:gutentags_project_root_finder='GetPwd'
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_add_default_project_roots = 0
set tags='.tags'

"ack.vim
cnoreabbrev Ack Ack!

"Grepreplace.vim
set grepprg=ack
let g:grep_cmd_opts = '--noheading'

"vim-gitgutter
if exists('&signcolumn')
	set signcolumn=yes
else
	let g:gitgutter_sign_column_always = 1
endif
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified = '±'
let g:gitgutter_sign_modified_removed = '±'

"vim-markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'sql']
augroup vimMarkdownAutocmd
	autocmd!
	autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END

"vdebug
let g:vdebug_options = {
	\ 'port' : 9000,
	\ 'server' : '',
	\ 'timeout' : 20,
	\ 'on_close' : 'detach',
	\ 'ide_key' : '',
	\ 'visualpath_maps' : {},
	\ 'debug_window_level' : 0,
	\ 'debug_file_level' : 0,
	\ 'debug_file' : "",
	\ 'marker_default' : '⬦',
	\ 'marker_closed_tree' : '▸',
	\ 'marker_open_tree' : '▾',
	\ 'break_on_open': 0,
	\ 'continuous_mode': 1,
	\ 'watch_window_style': 'compact',
\ }

"bufexplorer
let g:bufExplorerShowRelativePath = 1



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

"GitGutter
highlight link GitGutterAdd DiffAdd
highlight link GitGutterChange DiffChange
highlight link GitGutterDelete DiffDelete
highlight link GitGutterChangeDelete DiffChange

"Tinykeymap
let g:tinykeymaps_default = []
call tinykeymap#Load('windows')
call tinykeymap#Map('windows', '<C-right>', 'wincmd >')
call tinykeymap#Map('windows', '<C-left>', 'wincmd <')
call tinykeymap#Map('windows', '<C-up>', 'wincmd +')
call tinykeymap#Map('windows', '<C-down>', 'wincmd -')



"-----DIFF COLORSCHEME-----
"When viewing a diff or patch file
highlight diffAdded     term=bold ctermbg=none ctermfg=green  cterm=bold guibg=DarkGreen   guifg=white gui=none
highlight diffChanged   term=bold ctermbg=none ctermfg=yellow cterm=bold guibg=DarkYellow  guifg=white gui=none
highlight diffFile      term=bold ctermbg=none ctermfg=blue   cterm=bold guibg=DarkYellow  guifg=white gui=none
highlight diffIndexLine term=bold ctermbg=none ctermfg=cyan   cterm=bold guibg=DarkRed     guifg=white gui=none
highlight diffLine      term=bold ctermbg=none ctermfg=yellow cterm=bold guibg=DarkMagenta guifg=white gui=none
highlight diffRemoved   term=bold ctermbg=none ctermfg=red    cterm=bold guibg=DarkRed     guifg=white gui=none
highlight diffSubname   term=bold ctermbg=none ctermfg=yellow cterm=none guibg=DarkYellow  guifg=white gui=none

if &diff
	colorscheme apprentice
endif



"-----END-----
"Auto sourcing the .vimrc file on safe
augroup sourcingAutocmd
	autocmd!
	autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

	"Reload lightline
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()
augroup END
