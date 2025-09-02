; basic keywords
[
  "assert"
  "in"
  "inherit"
  "let"
  "rec"
  "with"
] @keyword

; if/then/else
[
  "if"
  "then"
  "else"
] @keyword.conditional

; field access default (`a.b or c`)
"or" @keyword.operator

; comments
(comment) @comment ; @spell

; strings
(string_fragment) @string

(string_expression
  "\"" @string)

(indented_string_expression
  "''" @string)

; paths and URLs
[
  (path_expression)
  (hpath_expression)
  (spath_expression)
] @string.special.path

(uri_expression) @string.special.url

; escape sequences
(escape_sequence) @string.escape

; delimiters
[
  "."
  ";"
  ":"
  ","
] @punctuation.delimiter

; brackets
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; `?` in `{ x ? y }:`, used to set defaults for named function arguments
(formal
  name: (identifier) @variable.parameter
  "?"? @operator)

; `...` in `{ ... }`, used to ignore unknown named function arguments (see above)
(ellipses) @variable.parameter.builtin

; universal is the parameter of the function expression
; `:` in `x: y`, used to separate function argument from body (see above)
(function_expression
  universal: (identifier) @variable.parameter
  ":" @punctuation.special)

; function calls
(apply_expression
  function: (variable_expression
    name: (identifier) @function.call))

; basic identifiers
(variable_expression) @variable

(variable_expression
  name: (identifier) @keyword.import
  (#eq? @keyword.import "import"))

(variable_expression
  name: (identifier) @boolean
  (#any-of? @boolean "true" "false"))

; builtin functions (with builtins prefix)
(select_expression
  expression: (variable_expression
    name: (identifier) @_id)
  attrpath: (attrpath
    attr: (identifier) @function.builtin)
  (#eq? @_id "builtins"))

; builtin functions (without builtins prefix)
(variable_expression
  name: (identifier) @function.builtin
  (#any-of? @function.builtin
    ; nix eval --json --impure --expr 'with builtins; filter (x: !(elem x [ "abort" "import" "throw" ]) && isFunction builtins.${x}) (attrNames builtins)' | jq -c 'sort | .[]'
    "add"
    "addDrvOutputDependencies"
    "addErrorContext"
    "all"
    "any"
    "appendContext"
    "attrNames"
    "attrValues"
    "baseNameOf"
    "bitAnd"
    "bitOr"
    "bitXor"
    "break"
    "catAttrs"
    "ceil"
    "compareVersions"
    "concatLists"
    "concatMap"
    "concatStringsSep"
    "deepSeq"
    "derivation"
    "derivationStrict"
    "dirOf"
    "div"
    "elem"
    "elemAt"
    "fetchGit"
    "fetchMercurial"
    "fetchTarball"
    "fetchTree"
    "fetchurl"
    "filter"
    "filterSource"
    "findFile"
    "flakeRefToString"
    "floor"
    "foldl'"
    "fromJSON"
    "fromTOML"
    "functionArgs"
    "genList"
    "genericClosure"
    "getAttr"
    "getContext"
    "getEnv"
    "getFlake"
    "groupBy"
    "hasAttr"
    "hasContext"
    "hashFile"
    "hashString"
    "head"
    "intersectAttrs"
    "isAttrs"
    "isBool"
    "isFloat"
    "isFunction"
    "isInt"
    "isList"
    "isNull"
    "isPath"
    "isString"
    "length"
    "lessThan"
    "listToAttrs"
    "map"
    "mapAttrs"
    "match"
    "mul"
    "parseDrvName"
    "parseFlakeRef"
    "partition"
    "path"
    "pathExists"
    "placeholder"
    "readDir"
    "readFile"
    "readFileType"
    "removeAttrs"
    "replaceStrings"
    "scopedImport"
    "seq"
    "sort"
    "split"
    "splitVersion"
    "storePath"
    "stringLength"
    "sub"
    "substring"
    "tail"
    "toFile"
    "toJSON"
    "toPath"
    "toString"
    "toXML"
    "trace"
    "traceVerbose"
    "tryEval"
    "typeOf"
    "unsafeDiscardOutputDependency"
    "unsafeDiscardStringContext"
    "unsafeGetAttrPos"
    "zipAttrsWith"
    ; primops, `__<tab>` in `nix repl`
    "__add"
    "__addErrorContext"
    "__all"
    "__any"
    "__appendContext"
    "__attrNames"
    "__attrValues"
    "__bitAnd"
    "__bitOr"
    "__bitXor"
    "__catAttrs"
    "__ceil"
    "__compareVersions"
    "__concatLists"
    "__concatMap"
    "__concatStringsSep"
    "__currentSystem"
    "__currentTime"
    "__deepSeq"
    "__div"
    "__elem"
    "__elemAt"
    "__fetchurl"
    "__filter"
    "__filterSource"
    "__findFile"
    "__floor"
    "__foldl'"
    "__fromJSON"
    "__functionArgs"
    "__genericClosure"
    "__genList"
    "__getAttr"
    "__getContext"
    "__getEnv"
    "__getFlake"
    "__groupBy"
    "__hasAttr"
    "__hasContext"
    "__hashFile"
    "__hashString"
    "__head"
    "__intersectAttrs"
    "__isAttrs"
    "__isBool"
    "__isFloat"
    "__isFunction"
    "__isInt"
    "__isList"
    "__isPath"
    "__isString"
    "__langVersion"
    "__length"
    "__lessThan"
    "__listToAttrs"
    "__mapAttrs"
    "__match"
    "__mul"
    "__nixPath"
    "__nixVersion"
    "__parseDrvName"
    "__partition"
    "__path"
    "__pathExists"
    "__readDir"
    "__readFile"
    "__replaceStrings"
    "__seq"
    "__sort"
    "__split"
    "__splitVersion"
    "__storeDir"
    "__storePath"
    "__stringLength"
    "__sub"
    "__substring"
    "__tail"
    "__toFile"
    "__toJSON"
    "__toPath"
    "__toXML"
    "__trace"
    "__traceVerbose"
    "__tryEval"
    "__typeOf"
    "__unsafeDiscardOutputDependency"
    "__unsafeDiscardStringContext"
    "__unsafeGetAttrPos"
    "__zipAttrsWith"
  )
)

; constants
(variable_expression
  name: (identifier) @constant.builtin
  (#any-of? @constant.builtin
    ; nix eval --json --impure --expr 'with builtins; filter (x: !(isFunction builtins.${x} || isBool builtins.${x})) (attrNames builtins)' | jq -c 'sort | .[]'
    "builtins"
    "currentSystem"
    "currentTime"
    "langVersion"
    "nixPath"
    "nixVersion"
    "null"
    "storeDir"
  )
)

; string interpolation (this was very annoying to get working properly)
(interpolation
  "${" @punctuation.special
  (_)
  "}" @punctuation.special)

(select_expression
  expression: (_) @_expr
  attrpath: (attrpath
    attr: (identifier) @variable.member)
  (#not-eq? @_expr "builtins"))

(attrset_expression
  (binding_set
    (binding
      .
      (attrpath
        (identifier) @variable.member))))

(rec_attrset_expression
  (binding_set
    (binding
      .
      (attrpath
        (identifier) @variable.member))))

; function definition
(binding
  attrpath: (attrpath
    attr: (identifier) @function)
  expression: (function_expression))

; unary operators
(unary_expression
  operator: _ @operator)

; binary operators
(binary_expression
  operator: _ @operator)

[
  "="
  "@"
  "?"
] @operator

; integers, also highlight a unary -
[
  (unary_expression
    "-"
    (integer_expression))
  (integer_expression)
] @number

; floats, also highlight a unary -
[
  (unary_expression
    "-"
    (float_expression))
  (float_expression)
] @number.float

; exceptions
(variable_expression
  name: (identifier) @keyword.exception
  (#any-of? @keyword.exception "abort" "throw"))
