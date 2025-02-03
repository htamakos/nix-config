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

        h-tamakoshi = {
          name = "h-tamakoshi";
          email = "h-tamakoshi@sakura.ad.jp";
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
        "PC107859" = mkDarwinConfiguration "PC107859" "h-tamakoshi";
      };

      homeConfigurations = {
        "htamakos@HironorinoMacBook-Pro" = mkHomeConfiguration "aarch64-darwin" "htamakos" "HironorinoMacBook-Pro";
        "testuser@HironorinoMacBook-Pro" = mkHomeConfiguration "aarch64-darwin" "testuser" "HironorinoMacBook-Pro";
        "h-tamakoshi@PC107859" = mkHomeConfiguration "aarch64-darwin" "h-tamakoshi" "PC107859";
      };
    };
}
