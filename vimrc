" Vim plugins
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'b4b4r07/vim-hcl'
Plug 'benmills/vimux'
Plug 'w0rp/ale'
Plug 'dcosson/vimux-nose-test2'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go'
Plug 'flowtype/vim-flow'
Plug 'jgdavey/tslime.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mxw/vim-jsx'
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
Plug 'pgr0ss/vimux-ruby-test'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/Pydiction'
Plug 'vim-scripts/Rename'
Plug 'vim-scripts/mru.vim'
Plug 'vim-scripts/taglist.vim'
call plug#end()
colorscheme tomorrow-night-dcosson

"Simple switching between hard tabs and spaces
command! -nargs=* HardTab setlocal noexpandtab shiftwidth=4
command! -nargs=? SoftTab setlocal expandtab tabstop=<args> shiftwidth=<args> softtabstop=<args>

set number
set et
set sw=2
set smarttab
" set smartindent
set incsearch
set hlsearch
set smartcase
set cursorline
" set cursorcolumn
set title
set ruler
set showmode
set showcmd
set ai " Automatically set the indent of a new line (local to buffer)
set tags=./tags;
set grepprg=ack
" set text width so gq-like commands wrap at 100 chars
set tw=100
" new regex engine seems to be really slow, particularly with ruby. Set to previous one
set re=1

set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

set mouse=a  " enable scroll with mouse wheel

let mapleader=","

" Turn off Ex mode which I only ever enter by accident
nnoremap Q <Nop>

" Turn off the swapfiles
set nobackup
set nowritebackup
set noswapfile
set t_Co=256
set laststatus=2 "show even if window not split

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" cursorline only in active buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Language-specific settings
autocmd FileType python set nosmartindent list shiftwidth=4 softtabstop=4
autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
autocmd FileType python nmap ,8 :call Pep8()<CR>
let g:pyindent_open_paren = '&sw'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'

autocmd FileType ruby set expandtab shiftwidth=2 softtabstop=2
autocmd FileType yaml set expandtab shiftwidth=2 softtabstop=2

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd Filetype javascript set expandtab tabstop=2 softtabstop=2 shiftwidth=2
let g:flow#enable = 0
let g:flow#omnifunc = 1
" let g:flow#flowpath = './dev-scripts/flow-proxy.sh'

autocmd FileType html SoftTab 2
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html.handlebars SoftTab 2
autocmd FileType css SoftTab 2
autocmd FileType scss SoftTab 2
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType text set wrap linebreak

augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

autocmd FileType markdown set formatoptions=cqln

" vim-javascript and vim-jsx settings
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0


" SnipMate? Not using it, maybe someday i will
"autocmd FileType python set ft=python.django " For SnipMate
"autocmd FileType html set ft=html.django_template " For SnipMate

" Custom filetypes
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
au BufRead,BufNewFile {*.less,*.sass} set ft=css
au BufRead,BufNewFile *.us set ft=html "our underscore.js html templates
au BufRead,BufNewFile {*.tfstate,*.tfstate.backup} set ft=json

" Open useful sidebars (taglist, nerdtree), and navigation tools
nnoremap ,w :TlistToggle<CR>
nnoremap ,W :NERDTreeToggle<CR>
nnoremap <C-p> :FZF<CR>
" nnoremap <C-[> :Tags<CR>
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let NERDTreeIgnore=[ '\.pyc$', '\.pyo$' ]

" fix backspace in vim 7
:set backspace=indent,eol,start

""" Clipboard
" copy all to clipboard
nmap ,a ggVG"*y
" copy word to clipboard
nmap ,d "*yiw
" copy highlighted to clipboard
vmap ,c "*y
" paste 
nmap ,v :set paste<CR>"*p:set nopaste<CR>
" underline current line, markdown style
nmap ,u "zyy"zp:.s/./-/g<CR>:let @/ = ""<CR>

" delete inner xml tag
nmap ,dit dt<dT>
nmap ,cit dt<cT>
"
"clear the search buffer, not just remove the highlight
map \c :let @/ = ""<CR>

" Revert the current buffer
nnoremap \r :e!<CR>

"Easy edit of vimrc
nmap \s :source $MYVIMRC<CR>
nmap \v :e $MYVIMRC<CR>

"Allow setting a hard tab with shift+Tab
:inoremap <S-Tab> <C-V><Tab>

" :runtime! ~/.vim/

" re-run last command
nmap ,R :!!<CR>

" w!! to write with sudo
cnoreabbrev <expr> w!!
    \((getcmdtype() == ':' && getcmdline() == 'w!!')
    \?('!sudo tee % >/dev/null'):('w!!'))

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set foldlevel=1
set foldlevelstart=99

" Taglist options
let g:Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 45


"""
""" Ale syntax checking & formatting
"""
let g:ale_enabled = 1

" visual options
let g:ale_sign_column_always = 1
let g:ale_sign_warning = '✋'
let g:ale_sign_error = '🚫'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Linting options
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'jsx': ['eslint', 'flow'],
\   'python': ['flake8'],
\   'ruby': ['ruby', 'rubocop'],
\   'hcl': [],
\}
" Only lint on save or when switching back to normal mode, not every keystroke in insert mode
let g:ale_lint_on_text_changed = 'normal'

" Fixer options
let g:ale_fixers = {
\   'javascript': ['prettier', 'remove_trailing_lines'],
\   'ruby': ['rubocop', 'remove_trailing_lines'],
\}
let g:ale_fix_on_save = 1
" language-specific options
let g:ale_javascript_prettier_options = ' --parser babylon --single-quote --jsx-bracket-same-line --trailing-comma es5 --print-width 100'

" Display Ale status in Airline
call airline#parts#define_function('ALE', 'ALEGetStatusLine')
call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
let g:airline_section_error = airline#section#create_right(['ALE'])

nmap <Leader>e :ALENextWrap<CR>
nmap <Leader>E :ALEPreviousWrap<CR>


" """
" """ Neoformat options
" """
" autocmd BufWritePre *.js Neoformat
" autocmd FileType javascript setlocal formatprg=prettier\ --write\ --single-quote\ --jsx-bracket-same-line\ --parser\ babylon\ --trailing-comma\ es5\ --print-width\ 100
" let g:neoformat_try_formatprg = 1  " Use formatprg when available



" --- Vimux commands to run tests
let g:vimux_nose_setup_cmd="echo 'run tests here'"
let g:vimux_nose_options="--nologcapture"
map <Leader>rs :call VimuxRunNoseSetup()<CR>
map <Leader>ri :call VimuxInspectRunner()<CR>
map <Leader>rc :call VimuxCloseRunner()<CR>
map <Leader>rr :call VimuxRunLastCommand()<CR>

autocmd FileType python map <Leader>ra :call VimuxRunNoseAll()<CR>
autocmd FileType python map <Leader>rF :call VimuxRunNoseFile()<CR>
autocmd FileType python map <Leader>rf :call VimuxRunNoseLine()<CR>

autocmd FileType javascript map <Leader>ra :call VimuxRunCommand("clear; $NODE_PATH/karma/bin/karma run -- --grep=")<CR>
autocmd FileType javascript map <Leader>rf :call VimuxRunCommand("clear; ./dev-scripts/karma-run-line-number.sh " . expand("%.") . ":" . line("."))<CR>

let g:vimux_ruby_file_relative_paths = 1
autocmd FileType ruby map <Leader>ra :call VimuxRunCommand("rspec")<CR>
autocmd FileType ruby map <Leader>rF :call VimuxRunCommand("clear; ./bin/rspec " . expand("%."))<CR>
autocmd FileType ruby map <Leader>rf :call VimuxRunCommand("clear; ./bin/rspec " . expand("%.") . ":" . line("."))<CR>

" Show what syntax highlighting recognizes the context as
map <Leader>sh :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

