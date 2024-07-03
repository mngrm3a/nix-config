{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #TODO: figure out, why follows doesn't work
    home-manager.url = "github:nix-community/home-manager";
    zsh-toolbox.url = "github:mngrm3a/zsh-toolbox";

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
      home-manager,
      zsh-toolbox,
      zsh-async,
      zsh-fzf-tab,
      zsh-pure,
      simple-zsh-nix-shell,
      ...
    }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      overlay = final: prev: {
        inherit
          zsh-async
          zsh-fzf-tab
          zsh-pure
          simple-zsh-nix-shell
          ;
      };
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
      nixkgsFor = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = [
            overlay
            zsh-toolbox.overlays.default
          ];
        }
      );
    in
    {
      packages = forAllSystems (system: {
        default = home-manager.packages.${system}.default;
        homeConfigurations.mngrm3a =
          let
            pkgs = nixkgsFor.${system};
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home-manager/mngrm3a ];
            extraSpecialArgs = { };
          };
      });

      formatter = forAllSystems (system: nixkgsFor.${system}.nixfmt-rfc-style);

      devShells = forAllSystems (system: {
        default =
          let
            pkgs = nixkgsFor.${system};
          in
          with pkgs;
          mkShellNoCC {
            nativeBuildInputs = [
              nil
              nixfmt-rfc-style
            ];
          };
      });
    };
}
