# Nix

Nix language support in Zed

## Configuration

Various options can be configured via [Zed `settings.json`](https://zed.dev/docs/configuring-zed#settings-files) files.

### Configure Nixd

```json
{
  "lsp": {
    "nixd": {
      "settings": {
        "diagnostic": {
          "suppress": [ "sema-extra-with" ]
        }
      }
    }
  }
}
```

See: [Nixd LSP Configuration Docs](https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md) for more options.

### Configure Nil

```json
{
  "lsp": {
    "nil": {
      "settings": {
         "diagnostics": {
          "ignored": [ "unused_binding" ]
        }
      }
    }
  }
}
```

See: [Nil LSP Configuration Docs](https://github.com/oxalica/nil/blob/main/docs/configuration.md) for more options.


### Only use Nixd

```json
{
  "languages": {
    "Nix": {
      "language_servers": [ "nixd", "!nil" ]
    }
  }
}
```

### Only use Nil

```json
{
  "languages": {
    "Nix": {
      "language_servers": [ "nil", "!nixd" ]
    }
  }
}
```

## Runnable tasks

The extension detects flake output bindings (`packages`, `checks`, `devShells`, `apps`, `formatter`) and shows run buttons in the gutter. Clicking a button opens a task picker with relevant actions:

| Output | Actions |
|--------|---------|
| `packages` | nix build, nix run, nix build --debugger |
| `checks` | nix check, nix flake check (all), nix check --debugger |
| `devShells` | nix develop, nix develop (impure), nix develop --debugger |
| `apps` | nix run, nix run --debugger |
| `formatter` | nix fmt, nix fmt --check |

Both 2-level (`packages.default`) and 3-level (`packages.x86_64-linux.default`) attrpath patterns are supported.

The `--debugger` variants launch the [Nix debugger](https://nix.dev/manual/nix/latest/command-ref/nix-build#opt-debugger), which drops into an interactive REPL on evaluation errors or `builtins.break` calls. Useful commands: `:bt` (backtrace), `:env` (show variables), `:continue`, `:step`.

### Configure formatters

You can configure formatters through LSP:

```jsonc
{
  "lsp": {
    "nil": {    // or "nixd":
      "initialization_options": {
        "formatting": {
          "command": ["alejandra", "--quiet", "--"]  // or ["nixfmt"]
        }
      }
    }
  }
}
```

Or through Zed itself:

```jsonc
{
  "languages": {
    "Nix": {
      "formatter": {
        "external": {
          "command": "alejandra",  // or "nixfmt"
          "arguments": ["--quiet", "--"]
        }
      }
    }
  }
}
```
