$env.PATH = ($env.PATH | split row (char esep) | append /nix/var/nix/profiles/default/bin | append /etc/profiles/per-user/cat/bin);

$env.config.show_banner = false
