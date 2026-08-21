{
  description = "My Neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
  # Automatically generates outputs for all default systems
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        customNeovim = import ./neovim.nix {inherit pkgs;};
      in {
        packages = {
          default = customNeovim;
          nvim = customNeovim;
        };
      }
    )
    // {
      # System-independent outputs (like overlays) sit outside eachDefaultSystem
      overlays.default = final: prev: {
        my-nvim = import ./neovim.nix {pkgs = final;};
      };
    };
}
