function! lcn_settings#format#after(...) abort
  noautocmd w
endfunction

function! lcn_settings#format#on_save(...)
  if !LanguageClient#HasCommand(&filetype)
    return
  endif

  let l:format_on_save = get(g:, 'lcn_settings#format_on_save', [])
  if index(l:format_on_save, &filetype) ==# -1
    return 
  endif

  noautocmd call LanguageClient#textDocument_formatting({}, 'lcn_settings#format#after')
endfunction
