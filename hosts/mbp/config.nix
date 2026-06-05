{ pkgs, ... }:

{
  system.primaryUser = "yourname";

  # CLI tool
  environment.systemPackages = with pkgs; [
    bat fzf delta lsd ripgrep tree
  ];

  # GUI apps (declarative Homebrew)
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [];
  };

  # macOS preferences
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllFiles = true;
    NSGlobalDomain.KeyRepeat = 2;
  };

  # Determinate installer manages Nix itself
  nix.enable = false;

  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
