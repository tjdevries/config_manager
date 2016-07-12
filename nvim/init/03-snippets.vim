
if g:my_snippet_manager == 'ultisnips'
    " Configuration for custom snips
    let g:UltiSnipsSnippetsDir = "~/.config/nvim/snips"
    let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snips"]

    " Trigger configuration.
    let g:UltiSnipsExpandTrigger='<leader>e'
    let g:UltiSnipsJumpForwardTrigger='<leader>r'
    let g:UltiSnipsJumpBackwardTrigger='<leader>w'

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit='vertical'

    " Use Python Version
    let g:UltiSnipsUsePythonVersion = 3

    let g:ultisnips_python_style="google"
elseif g:my_snippet_manager == 'neosnippet'
    let g:neosnippet#snippets_directory = [
                \ "~/.config/nvim/snips/",
                \ g:plugin_path . "/vim-snippets/"
                \ ]

    let g:neosnippet#enable_snipmate_compatibility = 1

    imap <C-k>  <Plug>(neosnippet_expand_or_jump)
else
    echoerr "You have set your `g:my_snippet_manager`"
endif
