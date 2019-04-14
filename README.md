# vim-powershell

## prerequisites

1. vim/neovim
1. [vim-plug](https://github.com/junegunn/vim-plug)
1. [pwsh](https://github.com/powershell/powershell)
1. git
1. `:echo has("python3")` prints `1`. This is usually set by `python3 -m pip install pynvim` in shell and `let g:python3_host_prog=/path/to/python/executable/` in vimrc/Init.vim.

## installation

1. Put this in your vimrc/Init.vim:

```vim
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
call plug#begin('~/.vim/plugged')
    " OS specific setup
    let languageClientInstallCommand = 'bash install.sh'
    if has('win32')
        languageClientInstallCommand = 'powershell -executionpolicy bypass -File install.ps1'
    endif

    " the language client used in vim-powershell
    Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': languageClientInstallCommand,
      \ }

    " the PowerShell vim extension
    Plug 'corbob/vim-powershell', {
      \ 'branch': 'dev',
      \ 'do': 'pwsh build.ps1',
      \ }

    " ncm2 setup for completions
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=noinsert,menuone,noselect
call plug#end()
```

2. Reload vim (alternately: reload init.vim).
1. Run the vim command: `:PlugInstall`
1. (Optional) install [vim-polyglot](https://github.com/sheerun/vim-polyglot) for syntax highlighting 🎨
