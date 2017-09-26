" unimpaired.vim - Pairs of handy bracket mappings
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.2
" GetLatestVimScripts: 1590 1 :AutoInstall: unimpaired.vim

if exists("g:loaded_unimpaired")
  finish
endif
let g:loaded_unimpaired = 1

" Next and previous {{{1

function! s:MapNextFamily(map, cmd)
  let l:map = toupper(a:map)
  let l:cmd = '(v:count ? v:count : "") . "' . a:cmd
  let l:end = '"<CR>' . (a:cmd == 'l' || a:cmd == 'c' ? 'zv' : '')
  exe join(['nmap <silent> [' . a:map, ':<C-u>exe ', l:cmd . 'prev' . l:end])
  exe join(['nmap <silent> ]' . a:map, ':<C-u>exe ', l:cmd . 'next' . l:end])
  exe join(['nmap <silent> [' . l:map, ':<C-u>exe ', l:cmd . 'firs' . l:end])
  exe join(['nmap <silent> ]' . l:map, ':<C-u>exe ', l:cmd . 'last' . l:end])
endfunction

call s:MapNextFamily('a', '')
call s:MapNextFamily('b', 'b')
call s:MapNextFamily('l', 'l')
call s:MapNextFamily('q', 'c')
call s:MapNextFamily('t', 't')

" }}}1
" Line operations {{{1

function! s:BlankUp(count) abort
  put! =repeat(nr2char(10), a:count)
  ']+1
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
endfunction

nmap <silent> [<Space> :<C-u>call <SID>BlankUp(v:count1)<CR>
nmap <silent> ]<Space> :<C-u>call <SID>BlankDown(v:count1)<CR>

function! s:Move(cmd, count, map) abort
  normal! m`
  silent! exe 'move' . a:cmd . a:count
  norm! ``
endfunction

function! s:MoveSelectionUp(count) abort
  normal! m`
  silent! exe "'<,'>move'<--" . a:count
  norm! ``
endfunction

function! s:MoveSelectionDown(count) abort
  normal! m`
  exe "'<,'>move'>+"  . a:count
  norm! ``
endfunction

nmap <silent> [e :<C-u>call <SID>Move('--', v:count1, 'Up')<CR>
nmap <silent> ]e :<C-u>call <SID>Move('+', v:count1, 'Down')<CR>
xmap <silent> [e :<C-u>call <SID>MoveSelectionUp(v:count1)<CR>
xmap <silent> ]e :<C-u>call <SID>MoveSelectionDown(v:count1)<CR>

" }}}1
" Option toggling {{{1

function! s:option_map(letter, option) abort
  for [key, value] in items({ '[' : '', ']' : 'no' })
    let l:cmd = ':setlocal ' . value . a:option
    exe 'nnoremap <silent> ' . key . 'o' . a:letter . ' ' . l:cmd .
          \ '<Bar> redrawstatus<CR>'
  endfor
endfunction

call s:option_map('h', 'hlsearch')
call s:option_map('i', 'ignorecase')
call s:option_map('l', 'list')
call s:option_map('n', 'number')
call s:option_map('r', 'relativenumber')
call s:option_map('s', 'spell')
call s:option_map('w', 'wrap')

nnoremap [oc :set colorcolumn=80<CR>
nnoremap ]oc :set colorcolumn=0<CR>

nnoremap [ox :set cursorline cursorcolumn<CR>
nnoremap ]ox :set nocursorline nocursorcolumn<CR>

nnoremap [ov :set virtualedit+=all<CR>
nnoremap ]ov :set virtualedit-=all<CR>

function! Unimpaired_WindowSaveIndex(key, letter)
  let l:win = winnr()
  windo exe 'norm ' . a:key . 'o' . a:letter
  exe l:win . 'wincmd w'
endfunction

function! s:window_option_map(letter)
  for l:key in ['[', ']']
    exe 'nnoremap <silent> ' . l:key . 'wo' . a:letter
          \ ':call g:Unimpaired_WindowSaveIndex("' . l:key . '", "' . a:letter . '")<CR>'
  endfor
endfunction

call s:window_option_map('n')
call s:window_option_map('r')
call s:window_option_map('s')
call s:window_option_map('w')
call s:window_option_map('c')
call s:window_option_map('x')

" }}}1

" vim:set sw=2 sts=2:
