mod language_servers;

use zed_extension_api::{self as zed, serde_json, settings::LspSettings, LanguageServerId, Result};

use crate::language_servers::{Nil, Nixd};

struct NixExtension {
    nil: Option<Nil>,
    nixd: Option<Nixd>,
}

impl zed::Extension for NixExtension {
    fn new() -> Self {
        Self {
            nil: None,
            nixd: None,
        }
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        match language_server_id.as_ref() {
            Nil::LANGUAGE_SERVER_ID => {
                let nil = self.nil.get_or_insert_with(Nil::new);
                nil.language_server_command(language_server_id, worktree)
            }
            Nixd::LANGUAGE_SERVER_ID => {
                let nixd = self.nixd.get_or_insert_with(Nixd::new);
                nixd.language_server_command(language_server_id, worktree)
            }
            language_server_id => Err(format!("unknown language server: {language_server_id}")),
        }
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

        let mut map = serde_json::Map::new();
        map.insert(language_server_id.to_string(), settings);
        Ok(Some(serde_json::json!(map)))
    }
}

zed::register_extension!(NixExtension);
