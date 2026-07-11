{ config, pkgs, inputs, ... }: {
  programs.nushell = {
    enable = true;

    shellAliases = {
      vi = "hx";
      vim = "hx";
      z = "zellij";
      sudo = ''sudo -p $"(ansi attr_dimmed)╰(ansi reset) (ansi purple)(ansi reset)  "'';
      "," = "/usr/bin/open";
    };

    configFile.source = ./config.nu;
  };

  programs.starship.enable = true;

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;
}
