if exists('g:loaded_clipboard')
  finish
endif

let g:loaded_clipboard = 1

silent !which clip.exe && which powershell.exe
if v:shell_error
  silent !which pbcopy && which pbpaste
  if v:shell_error
    let s:os = "unknown"
  else
    let s:os = "mac"
  endif
else
  let s:os = "windows"
endif

if s:os ==# "windows"
  let s:yank_command = "clip.exe"
  let s:paste_command = "powershell Get-Clipboard"
elseif s:os ==# "mac"
  let s:yank_command = "pbcopy"
  let s:paste_command = "pbpaste"
else
  finish
endif

function Yank()
  let original_value = @c
  let original_position = getpos(".")
  normal! `<
  " `v` is necessary! See :help o_v
  normal! "cyv`>
  call system(s:yank_command, @c)
  call cursor(original_position[1], original_position[2])
endfunction

vnoremap <leader>y <esc>:call Yank()<cr>
