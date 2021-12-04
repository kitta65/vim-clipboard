if exists('g:loaded_clipboard')
  finish
endif

let g:loaded_clipboard = 1

silent !which clip.exe
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

if s:os ==# "unknown"
  finish
endif

let g:clipboard_result = s:os
