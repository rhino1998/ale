" Author: rhino1998 https://github.com/rhino1998
" Description: langtool for text files

call ale#linter#Define('text', {
\   'name': 'langtool',
\   'executable': 'langtool-http-client-shim',
\   'command': 'langtool-http-client-shim',
\   'callback': 'ale#handlers#langtool#Handle',
\})
