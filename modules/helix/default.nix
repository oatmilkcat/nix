{ config, pkgs, inputs, ... }: {
  programs.helix = {
    enable = true;
    
    package = inputs.cat-helix.packages.${pkgs.system}.default;

    settings = {
      theme = "fleet_dark";
      editor = {
        line-number = "relative";
        popup-border = "all";
        end-of-line-diagnostics = "hint";
        rounded-corners = true;

        statusline = {
          left = ["file-name" "read-only-indicator" "file-modification-indicator"];
          center = ["mode"];
          mode = {
            normal = "";
            select = "󱥸";
            insert = "";
          };
        };
      };
    };
  };
}
