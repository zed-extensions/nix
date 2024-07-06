use zed_extension_api::{self as zed, serde_json, settings::LspSettings, LanguageServerId, Result};

struct NixExtension;

impl zed::Extension for NixExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        _: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        let path = worktree.which("nixd").ok_or_else(|| {
            "The Nix language server (nixd) is not available in your environment (PATH).
                You can install it from https://github.com/nix-community/nixd."
                .to_string()
        })?;

        Ok(zed::Command {
            command: path,
            args: vec![],
            env: vec![],
        })
    }

    fn language_server_workspace_configuration(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<Option<zed::serde_json::Value>> {
        let settings = LspSettings::for_worktree(language_server_id.as_ref(), worktree)
            .ok()
            .and_then(|lsp_settings| lsp_settings.settings.clone())
            .unwrap_or_default();

        Ok(Some(serde_json::json!({
            "nixd": settings,
        })))
    }
}

zed::register_extension!(NixExtension);
