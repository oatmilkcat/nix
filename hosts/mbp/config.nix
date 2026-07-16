{ pkgs, ... }:

{
  system.primaryUser = "cat";

  # CLI tool
  environment.systemPackages = with pkgs; [
    bat fzf delta lsd ripgrep tree htop
  ];

  # GUI apps (declarative Homebrew)
  homebrew = {
    enable = true;
    casks = [ "iterm2" "tailscale-app" ];
  };

  # macOS preferences
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllFiles = true;
    NSGlobalDomain.KeyRepeat = 2;
    menuExtraClock.Show24Hour = true;
  };

  # Determinate installer manages Nix itself
  nix.enable = false;

  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";

  services.tailscale.enable = true;

  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';
}
