;; extends

; Highlight longer lines as a suggestion to consider using less characters.
((subject) @comment.warning
  (#vim-match? @comment.warning ".\{50,}")
  (#offset! @comment.warning 0 50 0 0))

((message_line) @comment.warning
  (#vim-match? @comment.warning ".\{72,}")
  (#offset! @comment.warning 0 72 0 0))
