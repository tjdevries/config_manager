let g:ale_open_list = 1
let g:ale_lint_delay = 500
" let g:ale_lint_on_text_changed = 'never'


" let g:ale_python_pylint_executable = 'python3 -m pylint'
let g:ale_python_pylint_executable = 'python3'

let g:ale_pattern_options = {
      \ '*.py': {'ale_enabled': 1},
      \ }

