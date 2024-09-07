mod language_servers;

use zed_extension_api::{self as zed, settings::LspSettings, LanguageServerId, Result};
use zed::serde_json;

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

    fn language_server_initialization_options(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<Option<serde_json::Value>> {
        let initialization_options =
            LspSettings::for_worktree(language_server_id.as_ref(), worktree)
                .ok()
                .and_then(|lsp_settings| lsp_settings.initialization_options.clone())
                .unwrap_or_default();

        Ok(Some(serde_json::json!(initialization_options)))
    }
}

zed::register_extension!(NixExtension);
