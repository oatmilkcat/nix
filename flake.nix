{
  description = "cat's nix-darwin config ^_^";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cat-helix = {
      url = "github:oatmilkcat/helix/4b4a1796b23f220dba3b7a652082fb401d56aa1b";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    workmux.url = "github:raine/workmux";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, cat-helix, ... }:
    {
      darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/mbp/config.nix
          home-manager.darwinModules.home-manager
          {
            users.users.cat = {
              name = "cat";
              home = "/Users/cat";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.cat = import ./home/home.nix;
          }
        ];
      };

      darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/work/config.nix
          home-manager.darwinModules.home-manager
          {
            users.users.cat = {
              name = "cat";
              home = "/Users/cat";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.cat = { imports =
              [ ./home/home.nix ] ++
              (let overlayPath = /Users/cat/.config/nix-private/work-overlay.nix;
               in if builtins.pathExists overlayPath
                  then [ overlayPath ]
                  else []);
            };
          }
        ];
      };
    };
}
