{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "opencode-vm" ''
      synced="$HOME/synced"
      case "$PWD/" in
        "$synced"/*) rel="''${PWD#"$synced"}" ;;
        *) echo "opencode-vm: $PWD isn't inside $synced" >&2; exit 1 ;;
      esac

      # ~ stays unquoted so it expands on the VM
      dir="~/synced$(printf '%q' "$rel")"
      args=""
      if (( $# )); then args=$(printf ' %q' "$@"); fi

      # Login shell so /etc/profile.d exports BIFROST_API_KEY
      remote="mkdir -p $dir && cd $dir && COLORTERM=truecolor exec opencode$args"
      exec ssh -q -t cat@dev-cat "bash -lc $(printf '%q' "$remote")"
    '')
  ];
}
