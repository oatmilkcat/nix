{ config, pkgs, lib, ... }:

{
  imports = builtins.map (e: ../modules/${e}) (builtins.attrNames (builtins.readDir ../modules));

  programs.git = {
    enable = true;
    settings = {
      user.name = "Cat Lafayette";
      user.email = "cat@end.email";
      user.signingkey = "2C7E3B2362C46679";
      push.autoSetupRemote = true;
      core.editor = "hx";
      commit.gpgsign = true;
      tag.gpgSign = true;
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = "Cat Lafayette";
      user.email = "cat@end.email";
      ui.default-command = "log";
      ui.editor = "hx";
      ui.pager = "delta";

      signing = {
        behavior = "own";
        backend = "gpg";
        key = "2C7E3B2362C46679";
      };
    };
  };

  programs.gpg.enable = true;

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

    delta
  ];
}
