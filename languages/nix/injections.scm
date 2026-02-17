((comment) @content
    (#set! injection.language "comment"))

; ============================================================================
; Comment-based language injection
; ============================================================================
; Place a comment containing the language name directly before a string
; to inject syntax highlighting for that language. For example:
;
;   # bash
;   ''
;     echo "hello"
;   ''
; ============================================================================

; nushell/nu -> nu
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*(nushell|nu)\\s*$")
  (#set! language "nu")
  (#set! combined))

; kdl -> kdl
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*kdl\\s*$")
  (#set! language "kdl")
  (#set! combined))

; bash/sh -> bash
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*(bash|sh)\\s*$")
  (#set! language "bash")
  (#set! combined))

; python -> python
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*python\\s*$")
  (#set! language "python")
  (#set! combined))

; lua -> lua
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*lua\\s*$")
  (#set! language "lua")
  (#set! combined))

; json -> json
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*json\\s*$")
  (#set! language "json")
  (#set! combined))

; toml -> toml
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*toml\\s*$")
  (#set! language "toml")
  (#set! combined))

; yaml -> yaml
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*yaml\\s*$")
  (#set! language "yaml")
  (#set! combined))

; css -> css
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*css\\s*$")
  (#set! language "css")
  (#set! combined))

; javascript/js -> javascript
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*(javascript|js)\\s*$")
  (#set! language "javascript")
  (#set! combined))

; typescript/ts -> typescript
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*(typescript|ts)\\s*$")
  (#set! language "typescript")
  (#set! combined))

; tsx -> tsx
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*tsx\\s*$")
  (#set! language "tsx")
  (#set! combined))

; fish -> fish
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*fish\\s*$")
  (#set! language "fish")
  (#set! combined))

; rust -> rust
((comment) @_comment .
  [(indented_string_expression (string_fragment) @content)
   (string_expression (string_fragment) @content)]
  (#match? @_comment "^#\\s*rust\\s*$")
  (#set! language "rust")
  (#set! combined))

; ============================================================================
; Function-based injections
; ============================================================================

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

; writeNuScriptBin name '' nushell_code '' (2 args, pkgs pre-applied)
((apply_expression
  function: (apply_expression
    function: (_) @_func)
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "nu")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "nu")))
  ])
  (#match? @_func "(^|\\.)writeNuScriptBin$")
  (#set! combined))

; runNuCommand name bins '' nushell_code '' (3 args, pkgs pre-applied)
((apply_expression
  function: (apply_expression
    function: (apply_expression
      function: (_) @_func))
  argument: [
    (string_expression
      ((string_fragment) @content
        (#set! language "nu")))
    (indented_string_expression
      ((string_fragment) @content
        (#set! language "nu")))
  ])
  (#match? @_func "(^|\\.)runNuCommand$")
  (#set! combined))

; writeNushellApplication { text = '' nushell_code ''; }
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
              (#set! language "nu")))
          (indented_string_expression
            ((string_fragment) @content
              (#set! language "nu")))
        ])))
  (#match? @_func "(^|\\.)writeNushellApplication$")
  (#match? @_path "^text$")
  (#set! combined))
