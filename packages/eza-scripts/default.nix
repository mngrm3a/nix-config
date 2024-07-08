pkgs:
pkgs.writeShellScriptBin "l" ''
  if [[ -z "$1" ]]; then
      f="$(readlink -f "$(pwd)")"
  else
      f="$1"
  fi

  if [[ -f "$f" ]]; then
    exec bat "$f"
  else
    exec exa --group --long --icons --git --git-ignore "$f"
  fi
''
