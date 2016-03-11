" zsh_completion.vim - Omni Completion for zsh
" Original Maintainer: Valodim Skywalker <valodim@mugenguild.com>
" Original Last Updated: 03 Oct 2013

function! zsh_completion#Complete(findstart, base) abort

  if a:findstart

    " locate the start of the word
    let l:line = getline('.')
    let l:pos = col('.') - 1
    while l:pos > 0 && l:line[l:pos - 1] =~ '\S'
      let l:pos -= 1
    endwhile

    let s:base = l:line[l:pos :]

    return l:pos

  else

    let l:srcfile = globpath(&rtp, 'plugin/capture.zsh')
    if len(l:srcfile) == 0
      return -1
    endif

    let s:out = system(l:srcfile . ' ' . shellescape(s:base) . ' ' . strlen(s:base))

    let l:result = []
    for item in split(s:out, '\r\n')
      let l:pieces = split(item, ' -- ')
      if len(l:pieces) > 1
        call add(l:result, { 'word': l:pieces[0], 'info': l:pieces[1], 'dup': 1 })
      else
        call add(l:result, { 'word': l:pieces[0], 'dup': 1 })
      endif
    endfor

    return l:result

  endif
endfun
