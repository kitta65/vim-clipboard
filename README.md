# vim clipboard
## Features
* Copy from vim into clipboard
* Paste into vim from clipboard
* Works almost independently from registers

## Prerequisite
These commands need to be available in your PATH.

### for WSL
* powershell.exe
* clip.exe

### for Mac
* pbcopy
* pbpaste

## Installation
### for [vim-plug](https://github.com/junegunn/vim-plug)
```vim
call plug#begin('~/.vim/plugged')
  " ... other plugins ...
  Plug 'dr666m1/vim-clipboard'
  " ... other plugins ...
call plug#end()
```

## Example mapping
```vim
" Save selected text into clipboard
vnoremap <leader>y <esc>:ClipboardYank<cr>

" Paste clipboard text after the cursor
nnoremap <leader>v :ClipboardPut<cr>
```
