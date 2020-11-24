function! HasConfigured(var) abort
  return get(g:, a:var, v:null) isnot v:null
endfunction

augroup LanguageClientConfig
  autocmd!
  let g:LanguageClient_serverCommands = lcn_settings#GetCommands()

  if !HasConfigured('LanguageClient_windowLogMessageLevel')
    let g:LanguageClient_windowLogMessageLevel = 'ERROR'
  endif

  if !HasConfigured('LanguageClient_loggingLevel')
    let g:LanguageClient_loggingLevel = 'ERROR'
  endif

  if !HasConfigured('LanguageClient_loggingFile')
    let g:LanguageClient_loggingFile = '/tmp/lcn.log'
  endif

  if !HasConfigured('LanguageClient_hoverPreview')
    let g:LanguageClient_hoverPreview = 'always'
  endif

  if !HasConfigured('LanguageClient_completionPreferTextEdit')
    let g:LanguageClient_completionPreferTextEdit = 0
  endif

  if !HasConfigured('LanguageClient_useVirtualText')
    let g:LanguageClient_useVirtualText = 'All'
  endif

  if !HasConfigured('LanguageClient_echoProjectRoot')
    let g:LanguageClient_echoProjectRoot = 1
  endif

  if !HasConfigured('LanguageClient_preferredMarkupKind')
    let g:LanguageClient_preferredMarkupKind = ['markdown', 'plaintext']
  endif

  if !HasConfigured('LanguageClient_applyCompletionAdditionalTextEdits')
    let g:LanguageClient_applyCompletionAdditionalTextEdits = 0
  endif

  if !HasConfigured('LanguageClient_diagnosticsEnable')
    let g:LanguageClient_diagnosticsEnable = 1
  endif

  if !HasConfigured('LanguageClient_showCompletionDocs')
    let g:LanguageClient_showCompletionDocs = 1
  endif

  if !HasConfigured('LanguageClient_hideVirtualTextsOnInsert')
    let g:LanguageClient_hideVirtualTextsOnInsert = 1
  endif

  if !HasConfigured('LanguageClient_documentHighlightDisplay')
    let g:LanguageClient_documentHighlightDisplay = {
        \ 1: { 'name': 'Text', 'texthl': 'Visual' },
        \ 2: { 'name': 'Read', 'texthl': 'SpellLocal' },
        \ 3: { 'name': 'Write', 'texthl': 'SpellRare' },
        \ }
  endif

  if !HasConfigured('LanguageClient_codeLensDisplay')
    let g:LanguageClient_codeLensDisplay = {
          \ 'texthl': 'CodeLens',
          \ 'signTexthl': 'LCNInfo',
          \ 'signText': '🔍',
          \ 'virtualTexthl': 'LCNCodeLens',
          \ }
  endif

  if executable('fzf')
    if !HasConfigured('LanguageClient_selectionUI')
      let g:LanguageClient_selectionUI = 'FZF'
    endif

    if !HasConfigured('LanguageClient_fzfContextMenu')
      let g:LanguageClient_fzfContextMenu = 1
    endif

    if !HasConfigured('LanguageClient_fzfOptions')
      autocmd User LanguageClientStarted 
            \ let g:LanguageClient_fzfOptions = ['--delimiter', ':', '--preview-window', '+{2}-5'] + fzf#vim#with_preview().options
    endif
  endif

  function! WorkspaceSymbols()
    let query = input('Enter query: ')
    call LanguageClient#workspace_symbol(query)
  endfunction

  function! LCNMappings()
    if !LanguageClient#HasCommand(&filetype)
      return
    endif

    nmap <buffer> <silent><F5>         <Plug>(lcn-menu)
    nmap <buffer> <silent>K            <Plug>(lcn-hover)
    nmap <buffer> <silent>R            <Plug>(lcn-rename)
    nmap <buffer> <silent>E            <Plug>(lcn-explain-error)
    nmap <buffer> <silent>gd           <Plug>(lcn-definition)
    nmap <buffer> <silent>gD           <c-w>v<Plug>(lcn-definition)
    nmap <buffer> <silent>gr           <Plug>(lcn-references)
    nmap <buffer> <silent>gi           <Plug>(lcn-implementation)
    nmap <buffer> <silent>ga           <Plug>(lcn-code-action)
    vmap <buffer> <silent>ga           <Plug>(lcn-code-action)
    nmap <buffer> <silent>gl           <Plug>(lcn-code-lens-action)
    nmap <buffer> gws                  :call WorkspaceSymbols()<CR>
    nmap <buffer> <silent>F            <Plug>(lcn-format-sync)
    nmap <buffer> <silent><c-s><c-s>   <Plug>(lcn-highlight)
    nmap <buffer> <silent><c-s><c-h>   :call LanguageClient#clearDocumentHighlight()<CR>
    nmap <buffer> <silent><c-]>        <Plug>(lcn-diagnostics-next)
    nmap <buffer> <silent><c-[>        <Plug>(lcn-diagnostics-prev)
  endfunction

  if get(g:, 'lcn_settings#enable_mappings', 1)
    autocmd FileType * call LCNMappings()
  endif

  command! LanguageClientRestart call LanguageClientRestart()
augroup END
