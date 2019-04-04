# vim-powershell

1. `build.ps1`
1. Put this in your Init.vim:

```vim
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/vim-easy-align'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Put your path
Plug 'path/to/vim-powershell'
call plug#end()
```
