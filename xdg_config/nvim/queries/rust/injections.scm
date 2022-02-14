(
 ((line_comment) @_comment_start
   (#eq? @_comment_start "/// ```")) @_start

 (line_comment) @rust

 ((line_comment) @_comment_end
   (#eq? @_comment_end "/// ```")) @_end

 (#offset! @rust 0 4 0 0)
)
