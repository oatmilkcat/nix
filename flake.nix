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
      url = "github:oatmilkcat/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, cat-helix }:
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
    };
}
