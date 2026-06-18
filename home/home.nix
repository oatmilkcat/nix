{ config, pkgs, lib, ... }:

{
  imports = builtins.map (e: ../modules/${e}) (builtins.attrNames (builtins.readDir ../modules));

  programs.git = {
    enable = true;
    settings = {
      user.name = "Cat Lafayette";
      user.email = "cat@end.email";
      push.autoSetupRemote = true;
    };
  };

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # programming
    rustup
    nodejs_24

    yarn
  ];
}
