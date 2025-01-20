{
  description = "nix-darwin config for my computer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Darwin (for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , home-manager
    , darwin
    , nixpkgs
    }:
    let
      inherit (self) outputs;
      system = "aarch64-darwin";
      users = {
        htamakos = {
          name = "htamakos";
          privateEmail = "tmkshrnr@gmail.com";
        };

        testuser = {
          name = "testuser";
          privateEmail = "tmkshrnr@gmail.com";
        };
      };

      mkDarwinConfiguration = hostname: username:
        darwin.lib.darwinSystem {
          system = system;
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
          };
          modules = [
            ./nix/nix-darwin/configuration.nix
          ];
        };

      mkHomeConfiguration = system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit inputs outputs;
            userConfig = users.${username};
          };
          modules = [
            ./nix/home/${username}/${hostname}.nix
          ];
        };
    in
    {
      darwinConfigurations = {
        "HironorinoMacBook-Pro" = mkDarwinConfiguration "HironorinoMacBook-Pro" "htamakos";
      };

      homeConfigurations = {
        "htamakos@HironorinoMacBook-Pro" = mkHomeConfiguration "aarch64-darwin" "htamakos" "HironorinoMacBook-Pro";
        "testuser@HironorinoMacBook-Pro" = mkHomeConfiguration "aarch64-darwin" "testuser" "HironorinoMacBook-Pro";
      };
    };
}
