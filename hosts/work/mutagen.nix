{ config, pkgs, lib, ... }:

let
  mutagen = "${pkgs.mutagen}/bin/mutagen";
in
{
  home.packages = [ pkgs.mutagen ];

  launchd.agents.mutagen = {
    enable = true;
    config = {
      ProgramArguments = [ mutagen "daemon" "run" ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  # Defaults are captured when a session is created; after changing them,
  # `mutagen sync terminate synced` and rebuild to recreate the session.
  home.file.".mutagen.yml".text = ''
    sync:
      defaults:
        mode: two-way-resolved
        ignore:
          vcs: true
          paths:
            - node_modules/
            - target/
            - .venv/
            - __pycache__/
            - .direnv/
            - .DS_Store
  '';

  home.activation.mutagenSyncedSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if ! ${mutagen} sync list synced >/dev/null 2>&1; then
      run mkdir -p "${config.home.homeDirectory}/synced"
      run ${mutagen} sync create --name=synced \
        "${config.home.homeDirectory}/synced" cat@dev-cat:~/synced \
        || echo "mutagen: couldn't create the 'synced' sync session (is dev-cat reachable?)" >&2
    fi
  '';
}
