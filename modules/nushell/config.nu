$env.PATH = ($env.PATH | split row (char esep) | append /nix/var/nix/profiles/default/bin);
