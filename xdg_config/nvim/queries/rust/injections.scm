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

(
 (macro_invocation
  (scoped_identifier
     path: (identifier) @_path
     name: (identifier) @_identifier)

  (token_tree (raw_string_literal) @sql))

 (#eq? @_path "sqlx")
 (#eq? @_identifier "query")
 (#offset! @sql 1 0 0 0)
)
