" Author: Riley Wilburn <rhino1998@gmail.com>
" Description: output handler for the languagetool JSON format

function! ale#handlers#languagetool#Handle(buffer, lines) abort
    try
        let l:errors = json_decode(join(a:lines, ''))
    catch
        return []
    endtry

    if empty(l:errors)
        return []
    endif

    let l:output = []
	let l:save_cursor = getcurpos()
    for l:error in l:errors['matches']
		let l:col_span = str2nr(l:error['length'])
		let l:byte_num = str2nr(l:error['offset'])
		call cursor(byte2line(l:byte_num)-1, 0)
		let l:pos = searchpos(substitute(
			\ l:error['context']['text'],
			\ ' ',
			\ '\s',
			\ '',
			\ ), 'n', byte2line(l:byte_num)+1)
		call add(l:output, {
        \   'lnum': l:pos[0],
        \   'col': l:pos[1],
        \   'end_col': l:pos[1] + l:col_span,
        \   'code': l:error['rule']['id'],
        \   'text': l:error['message'],
        \   'type': 'E',
        \})
    endfor
	call cursor(l:save_cursor[1], l:save_cursor[2])

    return l:output
endfunction
