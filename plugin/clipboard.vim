if exists('g:loaded_clipboard')
  finish
endif

let g:loaded_clipboard = 1

if executable("clip.exe") && executable("powershell.exe")
  let s:yank_command = "iconv -t cp932 | clip.exe"
  let s:paste_command = "powershell.exe Get-Clipboard | iconv -f cp932 -t utf-8"
elseif executable("pbcopy") && executable("pbpaste")
  let s:yank_command = "pbcopy"
  let s:paste_command = "pbpaste"
else
  echom "Cannot find necessary commands in your PATH."
  finish
endif

function! s:Yank()
  let original_value = @c
  let original_position = getpos(".")
  normal! `<
  " `v` is necessary! See :help o_v
  normal! "cyv`>
  call system(s:yank_command, @c)
  call cursor(original_position[1], original_position[2])
endfunction

function! s:Put()
  let original_line = line(".")
  let original_formatoptions = &formatoptions
  set formatoptions-=ro
  " See :help i_0_CTRL-D
  execute "normal! a\r0\<c-d>\<esc>\<up>"
  execute "read !" . s:paste_command
  execute "normal! gJ" . original_line . "GgJ"
  let &formatoptions = original_formatoptions
endfunction

command! ClipboardYank call <SID>Yank()
command! ClipboardPut call <SID>Put()
