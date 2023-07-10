;; extends

; ([(attribute (attribute_id)) @keyword
;   (item_attribute (attribute_id)) @keyword]
;  (#match? @keyword "unboxed")
;  (#set! conceal "▢"))

; ((keyword) @keyword.of
;  (#match? @keyword.of "of"))

;; I kind of like `of` not showing up like the rest of the keywords :)
;; we'll try it for now.
["of"] @keyword.faded
