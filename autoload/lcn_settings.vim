function! GetConfiguredCommand(filetype) abort
  let l:command = get(get(g:, 'LanguageClient_serverCommands', {}), a:filetype)
  if l:command is v:null || len(l:command) ==# 0
    return v:null
  endif

  return l:command
endfunction

function! HasConfiguredCommand(filetype) abort
  if has_key(get(g:, 'LanguageClient_serverCommands', {}), a:filetype)
    return v:true
  endif

  if has_key(get(g:, 'LanguageClient_serverCommands', {}), a:filetype)
    return v:true
  endif

  return v:false
endfunction

function! GetRustCommand() abort
  if HasConfiguredCommand('rust')
    return GetConfiguredCommand('rust')
  endif

  if executable('rust-analyzer')
    return ['rust-analyzer']
  endif

  if executable('rls')
    return ['rls']
  endif

  return v:null
endfunction

function! GetGoCommand() abort
  if HasConfiguredCommand('go')
    return GetConfiguredCommand('go')
  endif

  if executable('gopls')
    return ['gopls']
  endif

  return v:null
endfunction

function! GetGomodCommand() abort
  if HasConfiguredCommand('gomod')
    return GetConfiguredCommand('gomod')
  endif

  if executable('gopls')
    return ['gopls']
  endif

  return v:null
endfunction

function! GetJavascriptCommand() abort
  if HasConfiguredCommand('javascript')
    return GetConfiguredCommand('javascript')
  endif

  if executable('javascript-typescript-stdio')
    return ['javascript-typescript-stdio']
  endif

  if executable('lsp-tsserver')
    return ['lsp-tsserver', '--stdio']
  endif

  return v:null
endfunction

function! GetTypescriptCommand() abort
  if HasConfiguredCommand('typescript')
    return GetConfiguredCommand('typescript')
  endif

  if executable('javascript-typescript-stdio')
    return ['javascript-typescript-stdio']
  endif

  if executable('lsp-tsserver')
    return ['lsp-tsserver', '--stdio']
  endif

  return v:null
endfunction

function! GetCppCommand() abort
  if HasConfiguredCommand('cpp')
    return GetConfiguredCommand('cpp')
  endif

  if executable('ccls')
    return ['ccls']
  endif

  if executable('clangd')
    return ['clangd']
  endif

  if executable('cquery')
    return ['cquery']
  endif

  return v:null
endfunction

function! GetCCommand() abort
  if HasConfiguredCommand('c')
    return GetConfiguredCommand('c')
  endif

  if executable('ccls')
    return ['ccls']
  endif

  if executable('clangd')
    return ['clangd']
  endif

  if executable('cquery')
    return ['cquery']
  endif

  return v:null
endfunction

function! GetPythonCommand() abort
  if HasConfiguredCommand('python')
    return GetConfiguredCommand('python')
  endif

  if executable('pyls')
    return ['pyls']
  endif

  if executable('pyright-langserver')
    return ['pyright-langserver', '--stdio']
  endif

  return v:null
endfunction

function! GetVimCommand() abort
  if HasConfiguredCommand('vim')
    return GetConfiguredCommand('vim')
  endif

  if executable('vim-language-server')
    return ['vim-language-server', '--stdio']
  endif

  return v:null
endfunction

function! lcn_settings#GetCommands() abort
  let s:output = {}
  let s:rust_command = GetRustCommand()
  if s:rust_command isnot v:null
    let s:output.rust = s:rust_command
  endif

  let s:vim_command = GetVimCommand()
  if s:vim_command isnot v:null
    let s:output.vim = s:vim_command
  endif

  let s:go_command = GetGoCommand()
  if s:go_command isnot v:null
    let s:output.go = s:go_command
  endif

  let s:gomod_command = GetGomodCommand()
  if s:gomod_command isnot v:null
    let s:output.gomod = s:gomod_command
  endif

  let s:python_command = GetPythonCommand()
  if s:python_command isnot v:null
    let s:output.python = s:python_command
  endif

  let s:cpp_command = GetCppCommand()
  if s:cpp_command isnot v:null
    let s:output.cpp = s:cpp_command
  endif

  let s:c_command = GetCCommand()
  if s:c_command isnot v:null
    let s:output.c = s:c_command
  endif

  let s:javascript_command = GetJavascriptCommand()
  if s:javascript_command isnot v:null
    let s:output.javascript = s:javascript_command
    let s:output['javascript.jsx'] = s:javascript_command
  endif

  let s:typescript_command = GetTypescriptCommand()
  if s:typescript_command isnot v:null
    let s:output.typescript = s:typescript_command
    let s:output['typescript.tsx'] = s:typescript_command
  endif

  return s:output
endfunction
