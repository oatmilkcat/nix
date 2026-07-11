{ config, pkgs, lib, ... }:

{
  imports = builtins.map (e: ../modules/${e}) (builtins.attrNames (builtins.readDir ../modules));

  programs.git = {
    enable = true;
    settings = {
      user.name = "Cat Lafayette";
      user.email = "cat@end.email";
      push.autoSetupRemote = true;
      core.editor = "hx";
    };
  };

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # programming
    rustup
    nodejs_24

    # package managers
    yarn

    # cli - environment management
    direnv

    # cli - database management
    sqlx-cli
  ];
}
