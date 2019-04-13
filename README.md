# vim-powershell

## prerequisites

1. vim/neovim
1. [vim-plug](https://github.com/junegunn/vim-plug)
1. [pwsh](https://github.com/powershell/powershell)
1. git

## installation

1. Put this in your Init.vim:

```vim
call plug#begin('~/.vim/plugged')

" LanguageClient used for interfacing with PowerShellEditorServices
" Use 'powershell -executionpolicy bypass -File install.ps1' in place of the 'bash install.sh' if on Windows.
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Required for intellisense style completions.
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Required to switch to PowerShell???
Plug 'sheerun/vim-polyglot'

" vim-powershell Plugin (this is us HYPE)
Plug 'corbob/vim-powershell', {
    \ 'do': 'pwsh build.ps1',
    \ }

call plug#end()
```
3. Reload vim (alternately: reload init.vim).
1. Run the vim command: `:PlugInstall`
