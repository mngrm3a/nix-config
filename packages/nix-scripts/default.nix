pkgs:
let
  nix-store-path = pkgs.writeShellScriptBin "nix-store-path" ''
    if command_path=$(command -v "$1"); then
      readlink -f "$command_path"
    else
      readlink -f "$1"
    fi
  '';
  nix-store-derivation = pkgs.writeShellScriptBin "nix-store-derivation" ''
    nix-store --query --deriver "$(nix-store-path $1)"
  '';
  nix-store-dependencies = pkgs.writeShellScriptBin "nix-store-dependencies" ''
    nix-store --query --references "$(nix-store-path $1)"
  '';
  nix-store-references = pkgs.writeShellScriptBin "nix-store-references" ''
    nix-store --query --referrers "$(nix-store-path $1)"
  '';
in
pkgs.symlinkJoin {
  name = "nix-scripts";
  paths = [
    nix-store-path
    nix-store-derivation
    nix-store-dependencies
    nix-store-references
  ];
}
