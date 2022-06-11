(
 ((line_comment) @_comment_start
   (#eq? @_comment_start "/// ```")) @_start

 (line_comment) @rust

 ((line_comment) @_comment_end
   (#eq? @_comment_end "/// ```")) @_end

 (#offset! @rust 0 4 0 0)
)

(
  (macro_invocation
    macro: ((identifier) @_html_def)
    (token_tree) @rsx)

    (#eq? @_html_def "html")
)
