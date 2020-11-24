This plugin adds the basic LanguageClient-neovim configuration needed to get the most out of it.

## Installation

```
Plug 'martskins/lcn-settings'
```

## Features

By default it will enable most functionality in LanguageClient-neovim and it will also set a set the following mappings:

```
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
```

Those mapping will only work for filetypes that have a configured language server.

If you prefer lcn-settings not to set any mapping and do that yourself you can disable mappings altogether by adding the following line to your vimrc:

```
let lcn_settings#enable_mappings = 0
```
