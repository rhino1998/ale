" Author: rhino1998 https://github.com/rhino1998
" Description: languagetool for text files

call ale#linter#Define('text', {
\   'name': 'languagetool',
\   'executable': 'languagetool-http-client-shim',
\   'command': 'languagetool-http-client-shim',
\   'callback': 'ale#handlers#languagetool#Handle',
\})
