# vim-powershell

## prerequisites

1. vim/neovim
1. [vim-plug](https://github.com/junegunn/vim-plug)
1. git

## installation

1. `build.ps1`
1. Put this in your Init.vim:

```vim
call plug#begin('~/.vim/plugged')
" Use 'powershell -executionpolicy bypass -File install.ps1' in place of the 'bash install.sh' if on Windows.
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
3. Run the vim command: `:PlugInstall`
