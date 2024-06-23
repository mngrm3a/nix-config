{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils = {
      url = "github:numtide/flake-utils";
      # follow = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      # follow = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      flake-utils,
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
          pkgs = nixpkgs.legacyPackages.${system};
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
              inherit inputs;
            };
          };
        }
      );
}
