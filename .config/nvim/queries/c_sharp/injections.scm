; Replaces nvim-treesitter's c_sharp injections.

; XML documentation comments (///): parse the text after the slashes as XML
; so <summary>, <param name="..."> etc. get tag/attribute highlighting.
((comment) @injection.content
  (#lua-match? @injection.content "^///")
  (#offset! @injection.content 0 3 0 0)
  (#set! injection.language "xml")
  (#set! injection.combined))

; All other comments keep the comment parser (TODO:, FIXME:, urls, ...).
((comment) @injection.content
  (#not-lua-match? @injection.content "^///")
  (#set! injection.language "comment"))
