{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
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
          packages.default = home-manager.defaultPackage.${system};

          packages.homeConfigurations.mngrm3a = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ];
            extraSpecialArgs = { };
          };

          devShells.default = pkgs.mkShell {
            buildInputs = [
              pkgs.nil
              pkgs.nixfmt-rfc-style
            ];
          };
        }
      );
}
