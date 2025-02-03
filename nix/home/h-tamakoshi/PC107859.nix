{ ... }: {
  imports = [
    ../modules/common.nix
  ];

  programs.home-manager.enable = true;
  home.sessionPath = [
    "/opt/homebrew/bin/"
  ];
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "24.11";
}
