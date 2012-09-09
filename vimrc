" Pathogen
set nocompatible
filetype off " Pathogen needs to run before plugin indent on
call pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
" call pathogen#runtime_append_all_bundles()
filetype plugin indent on
filetype on
filetype plugin on
filetype indent on
syntax enable
" let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast='high'
let g:solarized_visibility='normal'
set background=dark
colorscheme solarized

" good example vimrc (and well documented!):
" http://github.com/twerth/dotfiles/blob/master/etc/vim/vimrc

set nocompatible

"Simple switching between hard tabs and spaces
command! -nargs=* HardTab setlocal noexpandtab shiftwidth=4
command! -nargs=? SoftTab setlocal expandtab tabstop=<args> shiftwidth=<args> softtabstop=<args>

set number
set et
set sw=4
set smarttab
" set smartindent
set incsearch
set hlsearch
set smartcase
set cursorline
" set cursorcolumn
" set list " turn invisibles on by default
" show in title bar
set title
set ruler
set showmode
set showcmd
set ai " Automatically set the indent of a new line (local to buffer)
set tags=./tags;
set grepprg=ack

set equalalways " Multiple windows, when created, are equal in size
"set splitbelow splitright"

set mouse=a  " enable scroll with mouse wheel

"set up a dece statusline
set statusline=%F%m%r%h%w\ \ \ [TYPE=%Y]\ \ \ [POS=%l,%v][%p%%]" [FORMAT=%{&ff}] %{strftime(\"%d/%m/%y\ -\ %H:%M\")} %F%m%r%h%w
set laststatus=2 "show even if window not split

" Professor VIM says '87% of users prefer jj over esc', jj abrams disagrees
" imap jj <Esc>

" to set cursorline/column when going to a new buffer (so you know where you are)
" autocmd WinEnter * setlocal cursorline  " always leave it on for now
" autocmd WinLeave * setlocal nocursorline
" autocmd WinEnter * setlocal cursorcolumn
" autocmd WinLeave * setlocal nocursorcolumn
" autocmd BufRead,BufNewFile,BufDelete * :syntax on

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" let g:pyflakes_use_quickfix = 0

" Python (no smart indent, set up the built-in omni complete and pydiction)
autocmd FileType python set nosmartindent
autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
autocmd FileType python setlocal list
autocmd FileType python SoftTab 4
autocmd FileType python nmap ,8 :call Pep8()<CR>
" autocmd FileType python nmap ,8 :call Flake8()<CR>
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html SoftTab 4 
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css SoftTab 4
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" SnipMate?? Don't know what it is
"autocmd FileType python set ft=python.django " For SnipMate
"autocmd FileType html set ft=html.django_template " For SnipMate

au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" fix backspace in vim 7
:set backspace=indent,eol,start
"nmap <buffer> <CR> gf
"nmap <buffer> <C-S-y> <Esc>yy<Esc>:bd<CR>:edit @"<CR>

" popout split buffer hack
" map <C-S-p>  <Esc>:hide<CR>:blast<CR>

nmap ,bs :ConqueTermSplit bash<CR>
nmap ,bv :ConqueTermVSplit bash<CR>

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

nmap ,t <Leader>t

"clear the fucking search buffer, not just remove the highlight
map \c :let @/ = ""<CR>

" Revert the current buffer
nnoremap \r :e!<CR>

"Easy edit of vimrc
nmap \s :source $MYVIMRC<CR>
nmap \v :e $MYVIMRC<CR>

:runtime! ~/.vim/
":helptags ~/.vim/doc 


"##################################################
"# move through CamelCaseWords
"##################################################
" http://vim.wikia.com/wiki/Moving_through_camel_case_words
" Use one of the following to define the camel characters.
" Stop on capital letters.
let g:camelchar = "A-Z"
" Also stop on numbers.
let g:camelchar = "A-Z0-9"
" Include '.' for class member, ',' for separator, ';' end-statement,
" and <[< bracket starts and "'` quotes.
let g:camelchar = "A-Z0-9.,;:{([`'\""
nnoremap <silent><C-Left> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
nnoremap <silent><C-Right> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
inoremap <silent><C-Left> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
inoremap <silent><C-Right> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
vnoremap <silent><C-Left> :<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>v`>o
vnoremap <silent><C-Right> <Esc>`>:<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>v`<o

"##################################################

" https://wincent.com/blog/2-hours-with-vim
"function! AckGrep(command)
"    cexpr system("ack " . a:command)
"    cw " show quickfix window already
"endfunction
"command! -nargs=+ -complete=file Ack call AckGrep(<q-args>)
"map <leader>a :Ack<space>

" prevent comments from going to beginning of line
"autocmd BufRead *.py inoremap # X<c-h>#


"##################################################
" markdown
"##################################################
 augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
 augroup END

"##################################################
" via http://www.vim.org/scripts/script.php?script_id=30
"##################################################

"##################################################
" Python block commenting shortcuts
"##################################################
map  ,cm   :call PythonCommentSelection()<CR>
vmap ,cm   :call PythonCommentSelection()<CR>
map  ,cu   :call PythonUncommentSelection()<CR>
vmap ,cu   :call PythonUncommentSelection()<CR>
" Comment out selected lines
" commentString is inserted in non-empty lines, and should be aligned with
" the block
function! PythonCommentSelection()  range
  let commentString = "#"
  let cl = a:firstline
  let ind = 1000    " I hope nobody use so long lines! :)

  " Look for smallest indent
  while (cl <= a:lastline)
    if strlen(getline(cl))
      let cind = indent(cl)
      let ind = ((ind < cind) ? ind : cind)
    endif
    let cl = cl + 1
  endwhile
  if (ind == 1000)
    let ind = 1
  else
    let ind = ind + 1
  endif

  let cl = a:firstline
  execute ":".cl
  " Insert commentString in each non-empty line, in column ind
  while (cl <= a:lastline)
    if strlen(getline(cl))
      execute "normal ".ind."|i".commentString
    endif
    execute "normal \<Down>"
    let cl = cl + 1
  endwhile
endfunction

" Uncomment selected lines
function! PythonUncommentSelection()  range
  " commentString could be different than the one from CommentSelection()
  " For example, this could be "# \\="
  let commentString = "#"
  let cl = a:firstline
  while (cl <= a:lastline)
    let ul = substitute(getline(cl),
             \"\\(\\s*\\)".commentString."\\(.*\\)$", "\\1\\2", "")
    call setline(cl, ul)
    let cl = cl + 1
  endwhile
endfunction

"############################################
"######## My own customizations (DC) ########
"############################################
"Make switching btwn split buffers easier
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
"Nicer buffer window sizing
map = <C-w>+
map - <C-w>-
map + <C-w>>
map _ <C-w><

" Full on IDE style (aka Workhorse)
nnoremap ,w :TlistToggle<CR>
nnoremap ,W :TlistToggle<CR> :NERDTreeToggle<CR>

" use kortina's color scheme
" colorscheme ir_black_kortina

" pyflakes-vim customizations
highlight SpellBad term=undercurl gui=undercurl guisp=Orange

"this function maps Alt-down and Alt-Up to move other window

function! ScrollOtherWindow(dir)
    if a:dir == "down"
        let move = "\<C-E>"
    elseif a:dir == "up"
        let move = "\<C-Y>"
    endif
    exec "normal \<C-W>p" . move . "\<C-W>p"
endfunction
"map ,y :call ScrollOtherWindow("down")<CR>
"map <C-E> :call ScrollOtherWindow("up")<CR>

" ---- Syntastic syntax checking ----
" status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" let g:syntastic_disable=['py']
let g:syntastic_enable_signs=0 "sign markings (at beginning of line, before line numbers)
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_loc_list=0
let g:syntastic_check_on_open=1
" mode info
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['txt'] }
" key shortcuts
nmap ,e :SyntasticCheck<CR> :Errors<CR>
nmap ,r :edit<CR>  " reload current file

let g:Tlist_Ctags_Cmd = '/usr/local/bin/ctags' " tell taglist where exuberant ctags is
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 45

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "I can't handle the fold...
set foldlevel=1         "this is just what i use


" Testing syntastic hack
noremap <silent><leader>lc :lcl<CR>
noremap <silent><leader>lo :lw<CR>



" Test Functions
function WhatFunctionAreWeIn()
  let strList = ["while", "foreach", "ifelse", "if else", "for", "if", "else", "try", "catch", "case"]
  let foundcontrol = 1
  let position = ""
  let pos=getpos(".")          " This saves the cursor position
  let view=winsaveview()       " This saves the window view
  while (foundcontrol)
    let foundcontrol = 0
    normal [{
    call search('\S','bW')
    let tempchar = getline(".")[col(".") - 1]
    if (match(tempchar, ")") >=0 )
      normal %
      call search('\S','bW')
    endif
    let tempstring = getline(".")
    for item in strList
      if( match(tempstring,item) >= 0 )
        let position = item . " - " . position
        let foundcontrol = 1
        break
      endif
    endfor
    if(foundcontrol == 0)
      call cursor(pos)
      call winrestview(view)
      return tempstring.position
    endif
  endwhile
  call cursor(pos)
  call winrestview(view)
  return tempstring.position
endfunction
