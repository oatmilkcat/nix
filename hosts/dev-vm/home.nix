{ pkgs, lib, ... }:

{
  home.username = "cat";
  home.homeDirectory = "/home/cat";

  # Ubuntu, not NixOS
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;

  # Flakes aren't enabled in the system nix.conf, and ~/.config/nix is this repo
  home.sessionVariables.NIX_CONFIG = "experimental-features = nix-command flakes";

  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -alF";
      la = "ls -A";
      grep = "grep --color=auto";
      hms = "home-manager switch --flake ~/.config/nix";
    };
  };

  programs.git.settings = {
    user.signingkey = lib.mkForce "B934B8CD57D53848";
    credential."https://github.com".helper = [ "" "!/usr/bin/gh auth git-credential" ];
    credential."https://gist.github.com".helper = [ "" "!/usr/bin/gh auth git-credential" ];
  };

  programs.jujutsu.settings.signing.key = lib.mkForce "B934B8CD57D53848";

  home.packages = with pkgs; [
    bat fzf lsd ripgrep tree htop fd jq fastfetch
  ];
}
