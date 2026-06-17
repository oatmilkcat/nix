{ config, pkgs, inputs, ... }: {
  programs.nushell = {
    enable = true;

    shellAliases = {
      vi = "hx";
      vim = "hx";
    };

    configFile.source = ./config.nu;
  };

  programs.starship.enable = true;

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;
}
