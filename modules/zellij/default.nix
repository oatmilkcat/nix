{ config, pkgs, inputs, ... }: {
  programs.zellij = {
    enable = true;
    extraConfig = builtins.readFile ./config.kdl;
  };
}
