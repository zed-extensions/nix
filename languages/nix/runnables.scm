; ============================================================================
; Nix flake output runnables
; ============================================================================
; Detects flake output attribute bindings and tags them for task templates.
; Works with both 3-level (e.g. packages.<system>.<name>) and 2-level
; (e.g. packages.<name>, inside forAllSystems/eachSystem) attrpath patterns.
;
; Captures:
;   @run   - where the run button appears (on the output name)
;   @name  - the flake output name (-> $ZED_CUSTOM_name)
;
; Users must configure task templates in .zed/tasks.json to use these tags.
; Example task template for nix-build:
;   {
;     "label": "nix build .#$ZED_CUSTOM_name",
;     "command": "nix",
;     "args": ["build", ".#$ZED_CUSTOM_name"],
;     "tags": ["nix-build"]
;   }
; ============================================================================

; --- packages ---
(
  (binding
    attrpath: (attrpath
      . (identifier) @_category
      (identifier) @run @name .)
    (#eq? @_category "packages")) @_nix-package
  (#set! tag nix-package)
)

; --- checks (3-level: checks.<system>.<name>) ---
; Captures @system for use in task templates as $ZED_CUSTOM_system.
; Only matches 3-level attrpaths; 2-level (forAllSystems) checks
; won't get a per-check button — use "nix flake check" from the task palette.
(
  (binding
    attrpath: (attrpath
      . (identifier) @_category
      (identifier) @system
      (identifier) @run @name .)
    (#eq? @_category "checks")) @_nix-check
  (#set! tag nix-check)
)

; --- devShells ---
(
  (binding
    attrpath: (attrpath
      . (identifier) @_category
      (identifier) @run @name .)
    (#eq? @_category "devShells")) @_nix-develop
  (#set! tag nix-develop)
)

; --- apps ---
(
  (binding
    attrpath: (attrpath
      . (identifier) @_category
      (identifier) @run @name .)
    (#eq? @_category "apps")) @_nix-run
  (#set! tag nix-run)
)

; --- formatter (1-level, inside forAllSystems/eachSystem) ---
(
  (binding
    attrpath: (attrpath
      . (identifier) @run @_category .)
    (#eq? @_category "formatter")) @_nix-fmt
  (#set! tag nix-fmt)
)

; --- formatter (2-level, with system identifier) ---
(
  (binding
    attrpath: (attrpath
      . (identifier) @_category
      (identifier) @run .)
    (#eq? @_category "formatter")) @_nix-fmt
  (#set! tag nix-fmt)
)

; --- formatter (2-level, with system interpolation e.g. ${system}) ---
(
  (binding
    attrpath: (attrpath
      . (identifier) @_category
      (interpolation) @run .)
    (#eq? @_category "formatter")) @_nix-fmt
  (#set! tag nix-fmt)
)
