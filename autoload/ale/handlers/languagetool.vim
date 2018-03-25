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
    for l:error in l:errors[keys(l:errors['matches'])[0]]
		let l:col_span = str2nr(str2nr(l:error['length']))
		let l:byte_num = str2nr(str2nr(l:error['offset']))
		let l:line_num = byte2line(l:byte_num)
		let l:col_num = l:byte_num - line2byte(l:line_num)
        call add(l:output, {
        \   'lnum': l:line_num,
        \   'col': l:col_num,
        \   'end_col': l:col_num + l:col_span,
        \   'code': l:error['rule']['id'],
        \   'text': l:error['shortMessage'],
        \   'type': 'E',
        \})
    endfor

    return l:output
endfunction
