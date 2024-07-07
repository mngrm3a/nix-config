pkgs:
pkgs.stdenvNoCC.mkDerivation {
  name = "git-scripts";
  src = ./.;
  buildInputs = [ pkgs.zsh ];
  installPhase = ''
    mkdir -p $out
    cp -r $src/bin $out/
    cp -r $src/share $out/
  '';
}
