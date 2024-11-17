; ((comment) @content
;   (#set! language "comment"))

; ((comment) @language
;   . ; this is to make sure only adjacent comments are accounted for the injections
;   [
;     (string_expression
;       (string_fragment) @content)
;     (indented_string_expression
;       (string_fragment) @content)
;   ]
;   (#gsub! @language "/%*%s*([%w%p]+)%s*%*/" "%1")
;   (#set! combined))

; ; #-style Comments
; ((comment) @language
;   . ; this is to make sure only adjacent comments are accounted for the injections
;   [
;     (string_expression
;       (string_fragment) @content)
;     (indented_string_expression
;       (string_fragment) @content)
;   ]
;   (#gsub! @language "#%s*([%w%p]+)%s*" "%1")
;   (#set! combined))

(apply_expression
  function: (_) @_func
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "regex")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "regex")))
  ]
  (#match? @_func "(^|\\.)match$")
  (#set! combined))

(binding
  attrpath: (attrpath
    (identifier) @_path)
  expression: [
    (string_expression
      ((string_fragment) @content
        (#set! language "bash")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "bash")))
  ]
  (#match? @_path "(^\\w+(Phase|Hook|Check)|(pre|post)[A-Z]\\w+|script)$"))

(apply_expression
  function: (_) @_func
  argument: (_
    (_)*
    (_
      (_)*
      (binding
        attrpath: (attrpath
          (identifier) @_path)
        expression: [
          (string_expression
            ((string_fragment) @content
              (#set! language "bash")))
          (indented_string_expression
            ((string_fragment) @content
              (#set! language "bash")))
        ])))
  (#match? @_func "(^|\\.)writeShellApplication$")
  (#match? @_path "^text$")
  (#set! combined))

(apply_expression
  function: (apply_expression
    function: (apply_expression
      function: (_) @_func))
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "bash")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "bash")))
  ]
  (#match? @_func "(^|\\.)runCommand((No)?CC)?(Local)?$")
  (#set! combined))

((apply_expression
  function: (apply_expression
    function: (_) @_func)
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "bash")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "bash")))
  ])
  (#match? @_func "(^|\\.)write(Bash|Dash|ShellScript)(Bin)?$")
  (#set! combined))

((apply_expression
  function: (apply_expression
    function: (_) @_func)
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "fish")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "fish")))
  ])
  (#match? @_func "(^|\\.)writeFish(Bin)?$")
  (#set! combined))

((apply_expression
  function: (apply_expression
    function: (apply_expression
      function: (_) @_func))
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "haskell")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "haskell")))
  ])
  (#match? @_func "(^|\\.)writeHaskell(Bin)?$")
  (#set! combined))

((apply_expression
  function: (apply_expression
    function: (apply_expression
      function: (_) @_func))
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "javascript")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "javascript")))
  ])
  (#match? @_func "(^|\\.)writeJS(Bin)?$")
  (#set! combined))

((apply_expression
  function: (apply_expression
    function: (apply_expression
      function: (_) @_func))
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "perl")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "perl")))
  ])
  (#match? @_func "(^|\\.)writePerl(Bin)?$")
  (#set! combined))

((apply_expression
  function: (apply_expression
    function: (apply_expression
      function: (_) @_func))
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "python")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "python")))
  ])
  (#match? @_func "(^|\\.)write(PyPy|Python)[23](Bin)?$")
  (#set! combined))

((apply_expression
  function: (apply_expression
    function: (apply_expression
      function: (_) @_func))
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "rust")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "rust")))
  ])
  (#match? @_func "(^|\\.)writeRust(Bin)?$")
  (#set! combined))
