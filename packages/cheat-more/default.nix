pkgs:
pkgs.writeShellScriptBin "cheat" ''
  arg=$(echo "$@" | tr ' ' '+')
  curl -sL "https://cheat.sh/$arg" | bat
''
