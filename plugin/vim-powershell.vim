"LanguageServerProtocol setup
"required for operations modifying multiple buffers like rename.
set hidden

let s:path = expand('<sfile>:p:h') . '/PowerShellEditorServices/'

let startEditorServicesPath = s:path . 'PowerShellEditorServices/Start-EditorServices.ps1'

" a hash of file types to language server launch command
let g:LanguageClient_serverCommands = {
    \ 'ps1': ['pwsh', startEditorServicesPath, '-HostName', 'nvim', '-HostProfileId', '0', '-HostVersion', '1.0.0', '-LogPath', s:path . 'pses.log', '-LogLevel', 'Diagnostic', '-BundledModulesPath', s:path, '-Stdio', '-SessionDetailsPath', s:path . '.pses_session']
    \ }

" for debugging LanguageClient-neovim
let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_loggingFile =  expand('<sfile>:p:h') . 'LanguageClient.log'

let g:LanguageClient_serverStderr = expand('<sfile>:p:h') . 'LanguageServer.log'

" fun with F8
function! PS1OutputHandle(output) abort
	let g:output = a:output
        echomsg json_encode(a:output)
endfunction

function! PS1Hover() abort
	:pclose
	:call LanguageClient_textDocument_hover()
endfunction

" If the filetype is powershell set up our keybindings
autocmd FileType ps1 call VsimEnableLanguageServerKeys()

function! VsimEnableLanguageServerKeys()
        " TODO hover with timer
        nnoremap <silent> <S-K> :call PS1Hover()<CR>
        nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
        nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
        nnoremap <silent> <F12> :call LanguageClient_textDocument_definition()<CR>
        set formatexpr=LanguageClient_textDocument_rangeFormatting()
        vnoremap = :call LanguageClient_textDocument_rangeFormatting()<CR>
        nnoremap <C-k><C-r> :call LanguageClient_textDocument_references()<CR>
        nnoremap <C-e><C-d> :call LanguageClient_textDocument_formatting()<CR>
        autocmd! CursorHold * call PS1Hover()
	call LanguageClient#registerHandlers({'output': 'PS1OutputHandle'})
        vnoremap <silent> <F8> :call RunCode()<CR>
        autocmd! VimLeave * :LanguageClientStop

endfunction

" fun with F8
function! RunCode()
        let codeString = s:get_visual_selection()
        :call LanguageClient#Call('evaluate', { 'expression': codeString }, function('PS1OutputHandle'))
endfunction

" fun with F8
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction
