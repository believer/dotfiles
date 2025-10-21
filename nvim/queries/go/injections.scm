;; extends

; :h lua-pattern

; All patterns are case-insensitive and allow any number
; of whitespace at start of template string

; SELECT
(raw_string_literal
  (raw_string_literal_content) @injection.content
  (#lua-match? @injection.content "^%s*[sS][eE][lL][eE][cC][tT]")
  (#set! injection.language "sql"))

; INSERT
(raw_string_literal
  (raw_string_literal_content) @injection.content
  (#lua-match? @injection.content "^%s*[iI][nN][sS][eE][rR][tT]")
  (#set! injection.language "sql"))
