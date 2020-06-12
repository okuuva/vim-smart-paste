" Code from:
" https://github.com/ConradIrwin/vim-bracketed-paste
" and:
" https://github.com/chrisjohnson/vim8-bracketed-paste-mode-tmux

let s:screen  = &term =~ 'screen'
let s:tmux = &term =~ 'tmux'
let s:xterm   = &term =~ 'xterm'

" make use of Xterm "bracketed paste mode"
" http://www.xfree86.org/current/ctlseqs.html#Bracketed%20Paste%20Mode
" http://stackoverflow.com/questions/5585129
if s:screen || s:xterm || s:tmux
  let &t_ti .= "\<Esc>[?2004h"
  let &t_te = "\e[?2004l" . &t_te
  
  function! XTermPasteBegin(ret)
    set pastetoggle=<f29>
    set paste
    return a:ret
  endfunction
  
  execute "set <f28>=\<Esc>[200~"
  execute "set <f29>=\<Esc>[201~"
  map <expr> <f28> XTermPasteBegin("i")
  imap <expr> <f28> XTermPasteBegin("")
  vmap <expr> <f28> XTermPasteBegin("c")
  cmap <f28> <nop>
  cmap <f29> <nop>
endif
