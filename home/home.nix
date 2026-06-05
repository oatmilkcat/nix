{ config, pkgs, lib, ... }:

{
  programs.nushell = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Cat Lafayette";
      user.email = "cat@end.email";
      push.autoSetupRemote = true;
    };
  };

  programs.starship.enable = true;

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;

  home.stateVersion = "24.11";
}
