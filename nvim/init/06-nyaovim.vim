if !exists("g:nyaovim_version")
    finish
endif


" Markdown Previewer
" Only apply if it is loaded
if exists(':StartMarkdownPreview')
    let g:markdown_preview_auto = 1
    let g:markdown_preview_eager = 1
endif
