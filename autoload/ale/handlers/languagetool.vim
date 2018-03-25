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
    for l:error in l:errors['matches']
		let l:col_span = str2nr(l:error['length'])
		let l:byte_num = str2nr(l:error['offset'])
		let [l:lnum, l:col] = searchpos(l:error['context']['text'], 'nb', byte2line(l:byte_num)+1)
		call add(l:output, {
        \   'lnum': l:lnum,
        \   'col': l:col,
        \   'end_col': l:col + l:col_span,
        \   'code': l:error['rule']['id'],
        \   'text': l:error['message'],
        \   'type': 'E',
        \})
    endfor

    return l:output
endfunction
