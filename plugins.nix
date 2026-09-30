{pkgs}:
with pkgs.vimPlugins; [
  # --- Themes ---
  {
    plugins = [
      catppuccin-nvim
      github-nvim-theme
      kanagawa-nvim
      cyberdream-nvim
      gruber-darker-nvim
      gruvbox-material
      onedark-nvim
      noctis-nvim
      sonokai
      no-clown-fiesta-nvim
    ];
    deps = [lush-nvim]; # makes some themes better or something
  }

  # --- Core ---
  {plugin = blink-cmp;}
  {plugin = nvim-colorizer-lua;}
  {plugin = fidget-nvim;}
  {plugin = grug-far-nvim;}
  {plugin = lualine-nvim;}
  {plugin = luasnip;}
  {plugin = mini-pairs;}
  {plugin = mini-surround;}
  # {plugin = noice-nvim;}
  {
    plugin = startup-nvim;
    deps = [telescope-nvim plenary-nvim telescope-file-browser-nvim];
  }
  {
    plugin = text-case-nvim;
    deps = [telescope-nvim];
  }
  {
    plugin = todo-comments-nvim;
    deps = [plenary-nvim];
  }
  {plugin = toggleterm-nvim;}
  {plugin = transparent-nvim;}
  {plugin = vim-better-whitespace;}
  {plugin = vim-move;}
  {plugin = vim-visual-multi;}

  {plugin = nvim-notify;}
  {plugin = vim-easy-align;}
  {plugin = nvim-web-devicons;}

  # --- Telescope shite ---
  {
    plugin = telescope-nvim;
    deps = [plenary-nvim];
  }
  {
    plugin = telescope-file-browser-nvim;
    deps = [telescope-nvim plenary-nvim];
    runtimeDeps = [pkgs.fd];
  }

  # =======================================================================
  # ==================== LSP (and some language stuff) ====================
  # =======================================================================
  # --- Nix ---
  {
    plugin = nvim-lspconfig;
    runtimeDeps = [pkgs.nil];
    grammars = ["nix"];
  }

  # --- Python ---
  {
    plugin = nvim-lspconfig;
    runtimeDeps = [pkgs.pyright];
    grammars = ["python"];
  }
  {
    plugin = venv-selector-nvim;
    deps = [nvim-lspconfig telescope-nvim];
    runtimeDeps = [pkgs.fd pkgs.python3];
  }

  # --- Rust ---
  {
    plugin = nvim-lspconfig;
    runtimeDeps = [pkgs.rust-analyzer];
    grammars = ["rust" "toml"];
  }

  # --- Web stuff ---
  {
    # Typescript / Javascript
    plugin = nvim-lspconfig;
    runtimeDeps = [pkgs.typescript-language-server];
    grammars = ["typescript" "javascript"];
  }
  {
    # HTML/CSS/JSON
    plugin = nvim-lspconfig;
    runtimeDeps = [pkgs.vscode-langservers-extracted];
    grammars = ["html" "css" "json"];
  }

  # --- Clangd ---
  {
    plugin = nvim-lspconfig;
    runtimeDeps = [pkgs.clang-tools];
    grammars = ["c" "cpp"];
  }

  # --- Lua ---
  {
    plugin = nvim-lspconfig;
    runtimeDeps = [pkgs.lua-language-server];
    grammars = ["lua"];
  }
]
