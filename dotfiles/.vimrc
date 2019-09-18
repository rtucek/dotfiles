set nocompatible

"-----VIM-PLUG-----
"Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"PLUGINS
call plug#begin('~/.vim/bundle')
"vim-sensible - ONLY for vim
if !has('nvim')
	Plug 'tpope/vim-sensible'
endif


Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'djoshea/vim-autoread'
Plug 'dyng/ctrlsf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'gregsexton/matchtag'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install({'tag':1})}}
Plug 'qpkorr/vim-bufkill'
Plug 'rayburgemeestre/phpfolding.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'szw/vim-maximizer'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-php/tagbar-phpctags.vim'
Plug 'vim-scripts/tinykeymap'
Plug 'w0rp/ale'


"COLORSCHEMES
Plug 'crusoexia/vim-monokai'
Plug 'gosukiwi/vim-atom-dark'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
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

"Don't yank selected text after overwriting via paste
vnoremap <silent> p "_dP

"Move lines up and down in visual mode
vnoremap <silent> <C-J> :m '>+1<CR>gv
vnoremap <silent> <C-K> :m '<-2<CR>gv

"(Un-)Indent lines and preserve selection
vnoremap <silent> < <<CR>gv
vnoremap <silent> > ><CR>gv

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
let NERDTreeShowHidden = 1
nnoremap <silent> <Leader>d :NERDTreeToggle<CR>
nnoremap <silent> <Leader>D :NERDTreeFind<CR>
let NERDTreeIgnore = [
	\ '\~$',
	\ '\.sw[op]$',
	\'\.\=tags$', '^\.tags\.\(lock\|temp\)$',
	\ '^Session.vim',
	\ '^.git$[[dir]]',
\ ]


"fzf
nnoremap <silent> <C-P> :Files<CR>
nnoremap <silent> <Leader>cwdp :Files <C-R>=expand('%:p:h') . '/'<CR><CR>
nnoremap <silent> <Leader>p :GFiles<CR>
nnoremap <silent> <Leader>gp :GFiles?<CR>
nnoremap <silent> <Leader>buf :Buffers<CR>
nnoremap <silent> <Leader>lin :BLines<CR>
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


"nerdcommenter
filetype plugin on
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1


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
	\ 'colorscheme': 'onedark',
	\ 'active': {
		\ 'left': [
			\ ['mode', 'paste'],
			\ ['gitbranch', 'readonly', 'filename', 'cocstatus'],
			\ ['tagbar', 'gutentags'],
		\ ]
	\ },
	\ 'component_function': {
		\ 'gitbranch': 'fugitive#head',
		\ 'filename': 'LightlineFilename',
		\ 'cocstatus': 'coc#status',
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
let g:gutentags_ctags_tagfile = '.tags'
set tags='.tags'


"ack.vim
let g:ackprg = 'ag --vimgrep --hidden --smart-case --ignore .git/'
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>


"ctrlsf.vim
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_auto_close = 0
nnoremap <Leader>A :CtrlSF<Space>
let g:ctrlsf_extra_backend_args = {
	\ 'ag': '--hidden --smart-case --ignore .git/'
\ }


"vim-gitgutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified = '±'
let g:gitgutter_sign_modified_removed = '±'
if exists('&signcolumn')
	set signcolumn=yes
else
	let g:gitgutter_sign_column_always = 1
endif


"vim-markdown
augroup vimMarkdownAutocmd
	autocmd!
	autocmd BufNewFile,BufReadPost *.md.erb set filetype=markdown
augroup END


"bufexplorer
let g:bufExplorerShowRelativePath = 1


"ultisnips
let g:UltiSnipsExpandTrigger = '<Leader>st'
let g:UltiSnipsJumpForwardTrigger = '<Leader>sn'
let g:UltiSnipsJumpBackwardTrigger = '<Leader>sb'


"vim-go
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
let g:go_version_warning = 0
let g:go_fmt_command = "goimports"
let g:go_fold_enable = [
	\ 'block',
	\ 'comment',
	\ 'import',
	\ 'package_comment',
	\ 'varconst',
\ ]


"ale
nnoremap <silent> [e :ALEPreviousWrap<CR>
nnoremap <silent> ]e :ALENextWrap<CR>
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_set_highlights = 1

let g:ale_linter_aliases = {
	\ 'vue': [
		\ 'css',
		\ 'javascript',
	\ ]
\ }

let g:ale_linters = {
	\ 'css': [
		\ 'stylelint',
	\ ],
	\ 'javascript': [
		\ 'eslint',
	\ ],
	\ 'sass': [
		\ 'stylelint',
	\ ],
	\ 'scss': [
		\ 'stylelint',
	\ ],
	\ 'typescript': [
		\ 'eslint',
	\ ],
	\ 'vue': [
		\ 'eslint',
		\ 'stylelint',
	\ ],
\ }

let g:ale_fixers = {
	\ 'css': [
		\ 'stylelint',
	\ ],
	\ 'javascript': [
		\ 'eslint',
	\ ],
	\ 'sass': [
		\ 'stylelint',
	\ ],
	\ 'scss': [
		\ 'stylelint',
	\ ],
	\ 'typescript': [
		\ 'eslint',
	\ ],
	\ 'vue': [
		\ 'eslint',
		\ 'stylelint',
	\ ],
\ }


"undotree
nnoremap <silent> <Leader><Leader>u :NERDTreeClose<CR>:UndotreeToggle<CR>
if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif


"vim-maximizer
let g:maximizer_set_default_mapping = 0
nmap <silent> <Leader>m :MaximizerToggle!<CR>


"vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.twig,*.blade.php'


"vim-vue
let g:vue_disable_pre_processors = 1

"Make NERDCommenter work with vue files
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


"incsearch.vim, vim-asterisk & incsearch-easymotion.vim
set hlsearch
set ignorecase
let g:incsearch#auto_nohlsearch = 1
let g:asterisk#keeppos = 1
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl)<Plug>(asterisk-*)
map # <Plug>(incsearch-nohl)<Plug>(asterisk-#)
map g* <Plug>(incsearch-nohl)<Plug>(asterisk-g*)
map g# <Plug>(incsearch-nohl)<Plug>(asterisk-g#)
map z* <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map gz* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
map z# <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
map gz# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)


"COC
"Config
call coc#config('diagnostic', {
	\ 'displayByAle': 1,
\ })

"Plugins
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-emmet',
	\ 'coc-eslint',
	\ 'coc-gocode',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-phpls',
	\ 'coc-python',
	\ 'coc-stylelint',
	\ 'coc-svg',
	\ 'coc-tsserver',
	\ 'coc-vetur',
\ ]

"Some server have issues with backup files, see #649
set nobackup
set nowritebackup
"Better display for messages
set cmdheight=2
"Don't give |ins-completion-menu| messages.
set shortmess+=c

"Use tab for trigger completion with characters ahead and navigate.
"Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]=~# '\s'
endfunction

"Use <c-space> for trigger completion.
inoremap <silent><expr> <C-SPACE> coc#refresh()
"Use <CR> for confirm completion, `<C-g>u` means break undo chain at current position.
"Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-Y>" : "\<C-G>u\<CR>"

"Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if &filetype == 'vim'
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

"Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
"Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

"Remap for format selected region
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
augroup coc
	autocmd!
	"Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	"Update signature help on jump placeholder
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
"Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
"Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)
"Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')
"Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

"Using CocList
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j :<C-u>CocNext<CR>
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
nnoremap <silent> <space>p :<C-u>CocListResume<CR>



"-----VISUAL-----

"Syntax highlighting
syntax enable

set t_ut=
set t_Co=256
colorscheme onedark

"Always display tabline
set showtabline=2

"Highlight current line
set cursorline

"Show column length
set ruler

"Show line numbers
set number

"Tinykeymap
let g:tinykeymaps_default = []
call tinykeymap#Load('windows')
call tinykeymap#Map('windows', '<C-right>', 'wincmd >')
call tinykeymap#Map('windows', '<C-left>', 'wincmd <')
call tinykeymap#Map('windows', '<C-up>', 'wincmd +')
call tinykeymap#Map('windows', '<C-down>', 'wincmd -')



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
