# Builds neovim with all plugins and runtime tooling bundled, so nothing is installed at runtime.
{pkgs}: let
  inherit (pkgs) lib vimPlugins;

  pluginModules = import ./plugins.nix {inherit pkgs;};

  # Extract direct plugins supporting both singular `plugin` and plural `plugins` list
  declaredPlugins =
    builtins.concatMap (
      m:
        if m ? plugin
        then [m.plugin]
        else if m ? plugins
        then m.plugins
        else []
    )
    pluginModules;

  # Extract plugin dependencies declared in `deps`
  declaredDeps = builtins.concatMap (m: m.deps or []) pluginModules;

  # Combine and deduplicate all Vim plugins
  allVimPlugins = lib.lists.unique (declaredPlugins ++ declaredDeps);

  # Extract and deduplicate all runtime binaries (system dependencies)
  runtimeTools = lib.lists.unique (
    builtins.concatMap (m: m.runtimeDeps or []) pluginModules
  );

  # Extract and deduplicate Treesitter grammars
  treesitterGrammarNames = lib.lists.unique (
    builtins.concatMap (m: m.grammars or []) pluginModules
  );

  treesitterPlugin = vimPlugins.nvim-treesitter.withPlugins (
    grammars: map (name: grammars."tree-sitter-${name}") treesitterGrammarNames
  );

  allPlugins = allVimPlugins ++ [treesitterPlugin];

  binPath = pkgs.lib.makeBinPath runtimeTools;
in
  pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
    name = "neovim";
    wrapRc = false;
    plugins = allPlugins;
    wrapperArgs = [
      "--prefix" "PATH" ":" binPath

      "--add-flags"
      ''--cmd "set runtimepath^=${./.}"''
      "--add-flags"
      ''-u ${./.}/init.lua''
    ];
  }
