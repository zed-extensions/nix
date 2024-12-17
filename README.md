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
