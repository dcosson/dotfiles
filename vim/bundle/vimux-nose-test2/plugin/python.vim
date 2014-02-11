if exists("g:loaded_vimux_nose_test2") || &cp
  finish
endif
let g:loaded_vimux_nose_test2 = 1


" Define a setup command that you can customize with a variable in your vimrc, e.g. `vagrant ssh && cd /vagrant`
function! VimuxRunNoseSetup()
  call VimuxRunCommand(g:vimux_nose_setup_cmd)
endfunction

function! VimuxRunNoseAll()
  call VimuxRunCommand("nosetests " . g:vimux_nose_options)
endfunction

function! VimuxRunNoseFile()
  call VimuxRunCommand("nosetests " . g:vimux_nose_options . " " . expand("%"))
endfunction

function! VimuxRunNoseLine()
  call VimuxRunCommand("noseline " . g:vimux_nose_options . " " . expand("%") . " --line " . line("."))
endfunction
