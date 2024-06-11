use zed_extension_api::{self as zed, Result,LanguageServerId};

struct NixExtension {
}

impl zed::Extension for NixExtension {
    fn new() -> Self {
        Self {}
    }

    fn language_server_command(
        &mut self,
        _: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        let path = worktree
            .which("nixd")
            .ok_or_else(|| "The Nix language server (nixd) is not available in your environment (PATH).
                You can install it from https://github.com/nix-community/nixd.".to_string())?;

        Ok(zed::Command {
            command: path,
            args: vec![],
            env: vec![],
        })
    }

}

zed::register_extension!(NixExtension);