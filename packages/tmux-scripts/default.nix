pkgs:
pkgs.stdenvNoCC.mkDerivation {
  name = "tmux-scripts";
  src = ./.;
  buildInputs = [ pkgs.zsh ];
  installPhase = ''
    mkdir -p $out
    cp -r $src/bin $out/
    cp -r $src/share $out/
  '';
}
