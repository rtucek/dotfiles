set nocompatible

"-----VIM-PLUG-----
" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"PLUGINS
call plug#begin('~/.vim/bundle')
" vim-sensible - ONLY for vim
if !has('nvim')
	Plug 'tpope/vim-sensible'
endif

" deoplete
if has('nvim')
	" neovim
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	" vim
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

" deoplete plugins
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'djoshea/vim-autoread'
Plug 'dyng/ctrlsf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'fatih/vim-go'
Plug 'gregsexton/matchtag'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'lumiliet/vim-twig'
Plug 'magicalbanana/vim-sql-syntax'
Plug 'majutsushi/tagbar'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'qpkorr/vim-bufkill'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'StanAngeloff/php.vim'
Plug 'szw/vim-maximizer'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-php/tagbar-phpctags.vim'
Plug 'vim-scripts/tinykeymap'
Plug 'vim-vdebug/vdebug'
Plug 'w0rp/ale'

"COLORSCHEMES
Plug 'crusoexia/vim-monokai'
Plug 'gosukiwi/vim-atom-dark'
Plug 'romainl/Apprentice'
call plug#end()

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
set spell

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
set foldenable
set foldmethod=syntax

"Don't use swapfiles
set noswapfile

"Don't change default cursor
"Kudos @binaryreverse https://github.com/neovim/neovim/issues/6005
set guicursor=n-v-c-sm-i-ci-ve-r-cr-o:hor20-blinkwait300-blinkon200-blinkoff150


"-----MAPPINGS-----
"Quick edit ~/.vimrc
nmap <silent> <Leader>ev :e $MYVIMRC<CR>

"Toggle Spell check
nnoremap <Leader>s :set spell!<CR>:set spell?<CR>

"Search word under cursor
nnoremap * *N
nnoremap # #N

"Search selection
function! s:VSetSearch()
	let temp = @@
	norm! gvy
	let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
	let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>N
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>N

"Removes the highlighted search results
nmap <silent> <Leader><space> :nohlsearch<CR>

"Tab navigation
nnoremap <Leader>tab :tabnew<space>
nnoremap <silent> <Leader>w :tabclose<CR>
nnoremap <silent> <Leader>tabthis :tabnew %<CR>:tabprevious<CR>

"Split Management
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"Fix whitespace errors
nnoremap <Leader>fwe :%s/^ //g<CR>:nohlsearch<CR>

"Unexpand 4 spaces to tab
nnoremap <Leader>uex :%s/    /\t/g<CR>:nohlsearch<CR>

"Move lines up and down in visual mode
vnoremap <silent> <C-J> :m '>+1<CR>gv
vnoremap <silent> <C-K> :m '<-2<CR>gv

"(Un-)Indent lines and preserve selection
vnoremap <silent> < <<CR>gv
vnoremap <silent> > ><CR>gv

"Don't yank selected text after overwriting via paste
vnoremap <silent> p "_dP

"Toggle relative line numbers
nnoremap <silent> <Leader>r :set relativenumber!<CR>:set relativenumber?<CR>
vnoremap <silent> <Leader>r <ESC>:set relativenumber!<CR>gv

"Toggle folding
nnoremap <Leader>f :set foldenable!<CR>:set foldenable?<CR>

"Sudo write
cmap w!! w !sudo tee > /dev/null %



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
let g:EditorConfig_exclude_patterns = [
	\ '.*\.diff',
	\ '.*\.patch',
\ ]

"NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore = [
	\ '\~$',
	\ '\.sw[op]$',
	\'\.\=tags$', '^\.tags\.\(lock\|temp\)$',
	\ '^Session.vim',
	\ '^.git$[[dir]]',
\ ]
nnoremap <silent> <Leader>d :NERDTreeToggle<CR>
nnoremap <silent> <Leader>D :NERDTreeFind<CR>

"fzf
nnoremap <silent> <C-P> :Files<CR>
nnoremap <silent> <Leader>p :GFiles<CR>
nnoremap <silent> <Leader>gp :GFiles?<CR>
nnoremap <silent> <Leader>bl :Buffers<CR>
nnoremap <silent> <Leader>fl :BLines<CR>
nnoremap <silent> <Leader>tag :BTags<CR>
nnoremap <silent> <Leader>com :Commits<CR>
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_buffers_jump = 1

"Vim-Gutter
set updatetime=250

"php.vim
let php_html_load = 0
let php_html_in_heredoc = 0
let php_html_in_nowdoc = 0
let php_sql_query = 0
let php_sql_heredoc = 0
let php_sql_nowdoc = 0
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
	call feedkeys('a', 'n')
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
noremap <silent> <Leader>gstatus :Gstatus<CR>
noremap <silent> <Leader>gblame :Gblame w<CR>

"tagbar
nnoremap <silent> <Leader>tb :TagbarToggle<CR>
"needs manual installation/build of https://github.com/vim-php/phpctags
let g:tagbar_phpctags_bin='/usr/local/bin/phpctags'
let g:tagbar_autoclose = 1

"lightline
set laststatus=2
set noshowmode
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

"gutentags
function! GetPwd(path)
	return getcwd()
endfunction
let g:gutentags_project_root_finder='GetPwd'
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_add_default_project_roots = 0
set tags='.tags'

"ack.vim
let g:ackprg = 'ag --vimgrep --hidden --smart-case --ignore .git/'
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

"ctrlsf.vim
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_auto_close = 0
let g:ctrlsf_extra_backend_args = {
	\ 'ag': '--hidden --smart-case --ignore .git/'
\ }
nnoremap <Leader>A :CtrlSF<Space>

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
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'sql', 'json']
augroup vimMarkdownAutocmd
	autocmd!
	autocmd BufNewFile,BufReadPost *.md set filetype=markdown
	autocmd BufNewFile,BufReadPost *.md.erb set filetype=markdown
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

"deoplete
let g:deoplete#enable_at_startup = 1

"deoplete PHP
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']

"ultisnips
let g:UltiSnipsExpandTrigger = '<Leader>st'
let g:UltiSnipsJumpForwardTrigger = '<Leader>sn'
let g:UltiSnipsJumpBackwardTrigger = '<Leader>sb'

"vim-go
let g:go_fmt_command = "goimports"
let g:go_fold_enable = [
	\ 'block',
	\ 'comment',
	\ 'import',
	\ 'package_comment',
	\ 'varconst',
\ ]
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

"ale
nnoremap <silent> [e :ALEPreviousWrap<CR>
nnoremap <silent> ]e :ALENextWrap<CR>
let g:ale_completion_enabled = 1
let g:ale_set_highlights = 0
let g:ale_linters = {
	\ 'javascript': [
		\ 'eslint',
	\ ],
\ }

"undotree
nnoremap <silent> <Leader><Leader>u :NERDTreeClose<CR>:UndotreeToggle<CR>
if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif

" vim-maximizer
let g:maximizer_set_default_mapping = 0
nmap <silent> <Leader>m :MaximizerToggle!<CR>

" vim-vue
" Fix commenting for NERDCommenter
let g:ft = ''
function! NERDCommenter_before()
	if &ft == 'vue'
		let g:ft = 'vue'
		let stack = synstack(line('.'), col('.'))
		if len(stack) > 0
			let syn = synIDattr((stack)[0], 'name')
			if len(syn) > 0
				exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
			endif
		endif
	endif
endfunction
function! NERDCommenter_after()
	if g:ft == 'vue'
		setf vue
		let g:ft = ''
	endif
endfunction

" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.twig'



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
highlight GitGutterAdd ctermfg=193 ctermbg=65 guifg=#d7ffaf guibg=#5f875f
highlight GitGutterChange ctermfg=193 ctermbg=173 guifg=#FD9720 guibg=#2D2E27
highlight link GitGutterChangeDelete GitGutterChange
highlight GitGutterDelete ctermfg=193 ctermbg=167 guifg=#272822 guibg=#f75f5f

"Tinykeymap
let g:tinykeymaps_default = []
call tinykeymap#Load('windows')
call tinykeymap#Map('windows', '<C-right>', 'wincmd >')
call tinykeymap#Map('windows', '<C-left>', 'wincmd <')
call tinykeymap#Map('windows', '<C-up>', 'wincmd +')
call tinykeymap#Map('windows', '<C-down>', 'wincmd -')



"-----DIFF COLORSCHEME-----
"When viewing a diff or patch file
highlight diffAdded	term=bold	ctermbg=none	ctermfg=green	cterm=bold	guibg=DarkGreen		guifg=white	gui=none
highlight diffChanged	term=bold	ctermbg=none	ctermfg=yellow	cterm=bold	guibg=DarkYellow	guifg=white	gui=none
highlight diffFile	term=bold	ctermbg=none	ctermfg=blue	cterm=bold	guibg=DarkYellow	guifg=white	gui=none
highlight diffIndexLine	term=bold	ctermbg=none	ctermfg=cyan	cterm=bold	guibg=DarkRed		guifg=white	gui=none
highlight diffLine	term=bold	ctermbg=none	ctermfg=yellow	cterm=bold	guibg=DarkMagenta	guifg=white	gui=none
highlight diffRemoved	term=bold	ctermbg=none	ctermfg=red	cterm=bold	guibg=DarkRed		guifg=white	gui=none
highlight diffSubname	term=bold	ctermbg=none	ctermfg=yellow	cterm=none	guibg=DarkYellow	guifg=white	gui=none

if &diff
	colorscheme apprentice
endif



"Override no matter what colorscheme
highlight clear SpellBad
highlight SpellBad cterm=bold,underline ctermfg=red



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
