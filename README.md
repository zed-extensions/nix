# Nix

Nix language support in Zed

## Configuration

### Configure Nixd

Options: <https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md>

[`settings.json`](https://zed.dev/docs/configuring-zed#settings-files)
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

### Configure Nil

Options: <https://github.com/oxalica/nil/blob/main/docs/configuration.md>

[`settings.json`](https://zed.dev/docs/configuring-zed#settings-files)
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

### Only use Nixd

[`settings.json`](https://zed.dev/docs/configuring-zed#settings-files)
```json
{
	"languages": {
		"Nix": {
			"language_servers": [ "nixd", "!nil" ],
		}
	}
}

```

### Only use Nil

[`settings.json`](https://zed.dev/docs/configuring-zed#settings-files)
```json
{
	"languages": {
		"Nix": {
			"language_servers": [ "nil", "!nixd" ],
		}
	}
}

```
