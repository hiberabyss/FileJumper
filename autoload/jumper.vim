function! s:OpenFile(filepath, args)
	let cmd = ":tabnew"

    if exists("g:ctrlp_open_cmd") && exists("g:ctrlp_open_mode") &&
                \ has_key(g:file_jumper_command, split(g:ctrlp_open_cmd, '\t')[0])
        if g:ctrlp_open_mode == 'v'
            let cmd = ":vnew"
        elseif g:ctrlp_open_mode == 'h'
            let cmd = ":new"
        endif

        unlet g:ctrlp_open_cmd
        unlet g:ctrlp_open_mode
    endif

	if len(a:args) > 0
		let cmd = join(a:args)
	endif
	execute(cmd ." ". a:filepath)
endfunction

function! jumper#DirFileCompletionList(lead, cmdline, ...) abort
	let cmd = split(a:cmdline)[0]
	if has_key(g:file_jumper_command, cmd)
		let complete_dir = g:file_jumper_command[cmd].dir
	endif

	return map(split(globpath(complete_dir, a:lead . '*'), '\n'), 'fnamemodify(v:val, ":t:r")')
endfunction

function! jumper#GotoDirItem(cmdname, ...)
	if !has_key(g:file_jumper_command, a:cmdname)
		echoerr printf('Could not find %s setting!', a:cmdname)
	endif

	let completion_entry = g:file_jumper_command[a:cmdname]
	let dir = completion_entry.dir
	let extension = completion_entry.extension

	let filepath = printf("%s/%s%s", dir, a:1, extension)
	call s:OpenFile(filepath, a:000[1:])

	if !has_key(completion_entry, 'handler') | return | endif
	execute(printf("call %s('%s')", completion_entry.handler, filepath))
endfunction

