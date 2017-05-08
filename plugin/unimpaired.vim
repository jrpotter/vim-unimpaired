" unimpaired.vim - Pairs of handy bracket mappings
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.2
" GetLatestVimScripts: 1590 1 :AutoInstall: unimpaired.vim

if exists("g:loaded_unimpaired") || &cp || v:version < 700
  finish
endif
let g:loaded_unimpaired = 1

" Next and previous {{{1

function! s:MapNextFamily(map,cmd)
  let map = '<Plug>unimpaired'.toupper(a:map)
  let cmd = '".(v:count ? v:count : "")."'.a:cmd
  let end = '"<CR>'.(a:cmd == 'l' || a:cmd == 'c' ? 'zv' : '')
  execute 'nnoremap <silent> '.map.'Previous :<C-U>exe "'.cmd.'previous'.end
  execute 'nnoremap <silent> '.map.'Next     :<C-U>exe "'.cmd.'next'.end
  execute 'nnoremap <silent> '.map.'First    :<C-U>exe "'.cmd.'first'.end
  execute 'nnoremap <silent> '.map.'Last     :<C-U>exe "'.cmd.'last'.end
  execute 'nmap <silent> ['.        a:map .' '.map.'Previous'
  execute 'nmap <silent> ]'.        a:map .' '.map.'Next'
  execute 'nmap <silent> ['.toupper(a:map).' '.map.'First'
  execute 'nmap <silent> ]'.toupper(a:map).' '.map.'Last'
  if exists(':'.a:cmd.'nfile')
    execute 'nnoremap <silent> '.map.'PFile :<C-U>exe "'.cmd.'pfile'.end
    execute 'nnoremap <silent> '.map.'NFile :<C-U>exe "'.cmd.'nfile'.end
    execute 'nmap <silent> [<C-'.a:map.'> '.map.'PFile'
    execute 'nmap <silent> ]<C-'.a:map.'> '.map.'NFile'
  endif
endfunction
call s:MapNextFamily('a','')
call s:MapNextFamily('b','b')
call s:MapNextFamily('l','l')
call s:MapNextFamily('q','c')
call s:MapNextFamily('t','t')

" }}}1
" Line operations {{{1

function! s:BlankUp(count) abort
  put != repeat(nr2char(10), a:count)
  ']+1
endfunction

function! s:BlankDown(count) abort
  put = repeat(nr2char(10), a:count)
  '[-1
endfunction

nmap <silent> [<Space> :<C-U>call <SID>BlankUp(v:count1)<CR>
nmap <silent> ]<Space> :<C-U>call <SID>BlankDown(v:count1)<CR>

function! s:Move(cmd, count, map) abort
  normal! m`
  silent! exe 'move'.a:cmd.a:count
  norm! ``
endfunction

function! s:MoveSelectionUp(count) abort
  normal! m`
  silent! exe "'<,'>move'<--".a:count
  norm! ``
endfunction

function! s:MoveSelectionDown(count) abort
  normal! m`
  exe "'<,'>move'>+".a:count
  norm! ``
endfunction

nmap <silent> [e :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
nmap <silent> ]e :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
xmap <silent> [e :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
xmap <silent> ]e :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

" }}}1
" Option toggling {{{1

function! s:statusbump() abort
  let &l:readonly = &l:readonly
  return ''
endfunction

function! s:toggle(op) abort
  call s:statusbump()
  return eval('&'.a:op) ? 'no'.a:op : a:op
endfunction

function! s:option_map(letter, option, mode) abort
  exe 'nnoremap [o'.a:letter ':'.a:mode.' '.a:option.'<C-R>=<SID>statusbump()<CR><CR>'
  exe 'nnoremap ]o'.a:letter ':'.a:mode.' no'.a:option.'<C-R>=<SID>statusbump()<CR><CR>'
  exe 'nnoremap co'.a:letter ':'.a:mode.' <C-R>=<SID>toggle("'.a:option.'")<CR><CR>'
endfunction

call s:option_map('h', 'hlsearch', 'set')
call s:option_map('i', 'ignorecase', 'set')
call s:option_map('l', 'list', 'setlocal')
call s:option_map('n', 'number', 'setlocal')
call s:option_map('r', 'relativenumber', 'setlocal')
call s:option_map('s', 'spell', 'setlocal')
call s:option_map('w', 'wrap', 'setlocal')

nnoremap [oc :set colorcolumn=80<CR>
nnoremap ]oc :set colorcolumn=0<CR>
nnoremap coc :set colorcolumn=<C-R>=&colorcolumn == 80 ? 0 : 80<CR><CR>

nnoremap [ot :set textwidth=80<CR>
nnoremap ]ot :set textwidth=0<CR>
nnoremap cot :set textwidth=<C-R>=&textwidth == 80 ? 0 : 80<CR><CR>

nnoremap [od :diffthis<CR>
nnoremap ]od :diffoff<CR>
nnoremap cod :<C-R>=&diff ? 'diffoff' : 'diffthis'<CR><CR>

nnoremap [ox :set cursorline cursorcolumn<CR>
nnoremap ]ox :set nocursorline nocursorcolumn<CR>
nnoremap cox :set <C-R>=&cursorline && &cursorcolumn ? 'nocursorline nocursorcolumn' : 'cursorline cursorcolumn'<CR><CR>

nnoremap [ov :set virtualedit+=all<CR>
nnoremap ]ov :set virtualedit-=all<CR>
nnoremap cov :set <C-R>=(&virtualedit =~# "all") ? 'virtualedit-=all' : 'virtualedit+=all'<CR><CR>

" }}}1

" vim:set sw=2 sts=2:
