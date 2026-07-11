{ config, pkgs, inputs, ... }: {
  programs.helix = {
    enable = true;
    
    package = inputs.cat-helix.packages.${pkgs.system}.default;

    themes = { cat-aura = ./cat-aura.toml; };

    settings = {
      theme = "cat-aura";
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
            insert = "";
          };
        };

        cursor-shape.insert = "bar";
        inline-diagnostics.cursor-line = "warning";
      };
    };
  };
}
