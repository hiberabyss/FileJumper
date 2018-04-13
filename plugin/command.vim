if !exists('g:file_jumper_command')
    let g:file_jumper_command = {
                \ "Gbin": {'dir': expand("$HOME/bin"), 'extension': ''},
                \ "Gwiki": {'dir': g:myvimwikidir, 'extension': '.wiki', 'keymap': '<Leader>wg'},
                \ }
endif

function! s:DefineDirFileCompletionCommand()

	for cmd in keys(g:file_jumper_command)
		execute(printf("command! -nargs=+ -bar -complete=customlist,jumper#DirFileCompletionList %s call jumper#GotoDirItem('%s', <f-args>)", cmd, cmd))
		if has_key(g:file_jumper_command[cmd], 'keymap')
			execute(printf('nmap %s :%s ', g:file_jumper_command[cmd].keymap, cmd))
		endif
	endfor
endfunction

call s:DefineDirFileCompletionCommand()
