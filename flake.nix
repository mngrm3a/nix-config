{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-24.05";

    zsh-async = {
      url = "github:mafredri/zsh-async";
      flake = false;
    };
    zsh-fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };
    zsh-pure = {
      url = "github:sindresorhus/pure";
      flake = false;
    };
    simple-zsh-nix-shell = {
      url = "github:goolord/simple-zsh-nix-shell";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      flake-utils,
      zsh-async,
      zsh-fzf-tab,
      zsh-pure,
      simple-zsh-nix-shell,
      ...
    }:
    flake-utils.lib.eachSystem
      [
        "aarch64-darwin"
        "x86_64-linux"
      ]
      (
        system:
        let
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
          pkgs = nixpkgs.legacyPackages.${system}.extend (
            final: prev: {
              neovim-unwrapped = pkgs-unstable.neovim-unwrapped;
              inherit
                zsh-async
                zsh-fzf-tab
                zsh-pure
                simple-zsh-nix-shell
                ;
            }
          );
        in
        {
          packages.default = home-manager.packages.${system}.default;

          formatter = pkgs.nixfmt-rfc-style;
          devShells.default =
            with pkgs;
            mkShellNoCC {
              buildInputs = [
                nil
                nixfmt-rfc-style
              ];
            };

          packages.homeConfigurations.mngrm3a = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home-manager/mngrm3a ];
            extraSpecialArgs = {
              unstable = nixpkgs-unstable.legacyPackages.${system};
            };
          };
        }
      );
}
